import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/utils/log_service.dart';
import '../../core/error/exceptions.dart';
import '../models/class_schedule.dart';
import '../models/reservation.dart';
import '../models/waitlist.dart';

class ScheduleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get schedules for a specific date range
  Future<List<ClassSchedule>> getSchedulesForDateRange(
    DateTime startDate,
    DateTime endDate, {
    String? classId,
    String? instructorId,
    String? studioId,
  }) async {
    try {
      LogService.i('Fetching schedules for date range: $startDate to $endDate');

      Query query = _firestore
          .collection('schedules')
          .where('startTime', isGreaterThanOrEqualTo: startDate)
          .where('startTime', isLessThan: endDate.add(const Duration(days: 1)))
          .orderBy('startTime');

      // Apply filters if provided
      if (classId != null) {
        query = query.where('classId', isEqualTo: classId);
      }
      if (instructorId != null) {
        query = query.where('instructorId', isEqualTo: instructorId);
      }
      if (studioId != null) {
        query = query.where('studioId', isEqualTo: studioId);
      }

      final snapshot = await query.get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return ClassSchedule.fromJson(data);
      }).toList();
    } catch (e) {
      LogService.e('Error fetching schedules', error: e);
      throw ServerException(
        message: 'Failed to load class schedules',
        code: 'SCHEDULE_FETCH_ERROR',
      );
    }
  }

  /// Get today's schedules
  Future<List<ClassSchedule>> getTodaySchedules() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return getSchedulesForDateRange(today, today);
  }

  /// Get schedules for the current week
  Future<List<ClassSchedule>> getWeekSchedules() async {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    return getSchedulesForDateRange(
      DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
      DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day),
    );
  }

  /// Book a class
  Future<Reservation> bookClass(String scheduleId, String userId) async {
    try {
      LogService.userAction(
        'Booking class',
        data: {'scheduleId': scheduleId, 'userId': userId},
      );

      // Use transaction to ensure data consistency
      return await _firestore.runTransaction<Reservation>((transaction) async {
        // Get the schedule document
        final scheduleRef = _firestore.collection('schedules').doc(scheduleId);
        final scheduleDoc = await transaction.get(scheduleRef);

        if (!scheduleDoc.exists) {
          throw const NotFoundException(
            message: 'Class schedule not found',
            code: 'SCHEDULE_NOT_FOUND',
          );
        }

        final scheduleData = scheduleDoc.data()!;
        scheduleData['id'] = scheduleDoc.id;
        final schedule = ClassSchedule.fromJson(scheduleData);

        // Check if class is full
        if (schedule.isFull) {
          throw const BusinessException(
            message: 'Class is full',
            code: 'CLASS_FULL',
          );
        }

        // Check if user already has a reservation
        final existingReservation = await _firestore
            .collection('reservations')
            .where('scheduleId', isEqualTo: scheduleId)
            .where('userId', isEqualTo: userId)
            .where('status', whereIn: ['confirmed', 'checked_in'])
            .get();

        if (existingReservation.docs.isNotEmpty) {
          throw const BusinessException(
            message: 'You already have a reservation for this class',
            code: 'ALREADY_BOOKED',
          );
        }

        // Create reservation
        final now = DateTime.now();
        final reservationData = {
          'userId': userId,
          'scheduleId': scheduleId,
          'status': 'confirmed',
          'bookedAt': now,
          'createdAt': now,
          'updatedAt': now,
        };

        final reservationRef = _firestore.collection('reservations').doc();
        transaction.set(reservationRef, reservationData);

        // Update schedule enrollment
        transaction.update(scheduleRef, {
          'currentEnrollment': FieldValue.increment(1),
          'updatedAt': FieldValue.serverTimestamp(),
        });

        // Return the reservation
        reservationData['id'] = reservationRef.id;
        return Reservation.fromJson(reservationData);
      });
    } catch (e) {
      LogService.e('Error booking class', error: e);
      if (e is BusinessException || e is NotFoundException) {
        rethrow;
      }
      throw ServerException(
        message: 'Failed to book class',
        code: 'BOOKING_ERROR',
      );
    }
  }

  /// Cancel a reservation
  Future<void> cancelReservation(String reservationId) async {
    try {
      LogService.userAction(
        'Cancelling reservation',
        data: {'reservationId': reservationId},
      );

      await _firestore.runTransaction((transaction) async {
        // Get the reservation
        final reservationRef = _firestore
            .collection('reservations')
            .doc(reservationId);
        final reservationDoc = await transaction.get(reservationRef);

        if (!reservationDoc.exists) {
          throw const NotFoundException(
            message: 'Reservation not found',
            code: 'RESERVATION_NOT_FOUND',
          );
        }

        final reservationData = reservationDoc.data()!;
        final scheduleId = reservationData['scheduleId'] as String;

        // Update reservation status
        transaction.update(reservationRef, {
          'status': 'cancelled',
          'cancelledAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });

        // Update schedule enrollment
        final scheduleRef = _firestore.collection('schedules').doc(scheduleId);
        transaction.update(scheduleRef, {
          'currentEnrollment': FieldValue.increment(-1),
          'updatedAt': FieldValue.serverTimestamp(),
        });

        // TODO: Notify waitlist if any
        _notifyWaitlist(scheduleId);
      });
    } catch (e) {
      LogService.e('Error cancelling reservation', error: e);
      if (e is NotFoundException) {
        rethrow;
      }
      throw ServerException(
        message: 'Failed to cancel reservation',
        code: 'CANCELLATION_ERROR',
      );
    }
  }

  /// Join waitlist for a full class
  Future<Waitlist> joinWaitlist(String scheduleId, String userId) async {
    try {
      LogService.userAction(
        'Joining waitlist',
        data: {'scheduleId': scheduleId, 'userId': userId},
      );

      // Check if user is already on waitlist
      final existingWaitlist = await _firestore
          .collection('waitlists')
          .where('scheduleId', isEqualTo: scheduleId)
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: 'waiting')
          .get();

      if (existingWaitlist.docs.isNotEmpty) {
        throw const BusinessException(
          message: 'You are already on the waitlist',
          code: 'ALREADY_WAITLISTED',
        );
      }

      // Get current waitlist position
      final waitlistCount = await _firestore
          .collection('waitlists')
          .where('scheduleId', isEqualTo: scheduleId)
          .where('status', isEqualTo: 'waiting')
          .get();

      final position = waitlistCount.docs.length + 1;

      // Create waitlist entry
      final now = DateTime.now();
      final waitlistData = {
        'userId': userId,
        'scheduleId': scheduleId,
        'position': position,
        'joinedAt': now,
        'status': 'waiting',
        'createdAt': now,
        'updatedAt': now,
      };

      final waitlistRef = _firestore.collection('waitlists').doc();
      await waitlistRef.set(waitlistData);

      waitlistData['id'] = waitlistRef.id;
      return Waitlist.fromJson(waitlistData);
    } catch (e) {
      LogService.e('Error joining waitlist', error: e);
      if (e is BusinessException) {
        rethrow;
      }
      throw ServerException(
        message: 'Failed to join waitlist',
        code: 'WAITLIST_ERROR',
      );
    }
  }

  /// Get user's reservations
  Future<List<Reservation>> getUserReservations(
    String userId, {
    ReservationStatus? status,
    DateTime? fromDate,
  }) async {
    try {
      Query query = _firestore
          .collection('reservations')
          .where('userId', isEqualTo: userId)
          .orderBy('bookedAt', descending: true);

      if (status != null) {
        query = query.where(
          'status',
          isEqualTo: status.toString().split('.').last,
        );
      }

      if (fromDate != null) {
        query = query.where('bookedAt', isGreaterThanOrEqualTo: fromDate);
      }

      final snapshot = await query.get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return Reservation.fromJson(data);
      }).toList();
    } catch (e) {
      LogService.e('Error fetching user reservations', error: e);
      throw ServerException(
        message: 'Failed to load reservations',
        code: 'RESERVATIONS_FETCH_ERROR',
      );
    }
  }

  /// Get user's waitlist entries
  Future<List<Waitlist>> getUserWaitlists(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('waitlists')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: 'waiting')
          .orderBy('joinedAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Waitlist.fromJson(data);
      }).toList();
    } catch (e) {
      LogService.e('Error fetching user waitlists', error: e);
      throw ServerException(
        message: 'Failed to load waitlists',
        code: 'WAITLISTS_FETCH_ERROR',
      );
    }
  }

  /// Private method to notify waitlist when spot becomes available
  Future<void> _notifyWaitlist(String scheduleId) async {
    try {
      // Get the first person on waitlist
      final waitlistSnapshot = await _firestore
          .collection('waitlists')
          .where('scheduleId', isEqualTo: scheduleId)
          .where('status', isEqualTo: 'waiting')
          .orderBy('position')
          .limit(1)
          .get();

      if (waitlistSnapshot.docs.isNotEmpty) {
        final waitlistDoc = waitlistSnapshot.docs.first;

        // Update waitlist status to notified
        await waitlistDoc.reference.update({
          'status': 'notified',
          'notifiedAt': FieldValue.serverTimestamp(),
          'responseDeadline': DateTime.now().add(const Duration(minutes: 15)),
          'updatedAt': FieldValue.serverTimestamp(),
        });

        // TODO: Send push notification
        // NotificationService.sendWaitlistNotification(...)
      }
    } catch (e) {
      LogService.e('Error notifying waitlist', error: e);
      // Don't throw here as this is a background operation
    }
  }

  /// Stream to listen to schedule updates
  Stream<List<ClassSchedule>> watchSchedulesForDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return _firestore
        .collection('schedules')
        .where('startTime', isGreaterThanOrEqualTo: startOfDay)
        .where('startTime', isLessThan: endOfDay)
        .orderBy('startTime')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            //final data = doc.data() as Map<String, dynamic>;
            final data = doc.data();
            data['id'] = doc.id;
            return ClassSchedule.fromJson(data);
          }).toList();
        });
  }

  /// Stream to listen to user's reservations
  Stream<List<Reservation>> watchUserReservations(String userId) {
    return _firestore
        .collection('reservations')
        .where('userId', isEqualTo: userId)
        .where('status', whereIn: ['confirmed', 'checked_in'])
        .orderBy('bookedAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return Reservation.fromJson(data);
          }).toList();
        });
  }
}
