import 'package:flutter/foundation.dart';
import '../../core/utils/log_service.dart';
import '../../core/error/exceptions.dart';
import '../../data/services/schedule_service.dart';
import '../../data/models/class_schedule.dart';
import '../../data/models/reservation.dart';
import '../../data/models/waitlist.dart';

enum ScheduleState { initial, loading, loaded, error }

class ScheduleProvider extends ChangeNotifier {
  final ScheduleService _scheduleService = ScheduleService();

  // State
  ScheduleState _state = ScheduleState.initial;
  String? _errorMessage;
  DateTime _selectedDate = DateTime.now();

  // Data
  List<ClassSchedule> _schedules = [];
  List<Reservation> _userReservations = [];
  List<Waitlist> _userWaitlists = [];
  ClassSchedule? _selectedSchedule;

  // Loading states for specific operations
  bool _isBooking = false;
  bool _isCancelling = false;
  bool _isJoiningWaitlist = false;

  // Getters
  ScheduleState get state => _state;
  String? get errorMessage => _errorMessage;
  DateTime get selectedDate => _selectedDate;
  List<ClassSchedule> get schedules => _schedules;
  List<Reservation> get userReservations => _userReservations;
  List<Waitlist> get userWaitlists => _userWaitlists;
  ClassSchedule? get selectedSchedule => _selectedSchedule;
  bool get isBooking => _isBooking;
  bool get isCancelling => _isCancelling;
  bool get isJoiningWaitlist => _isJoiningWaitlist;
  bool get isLoading => _state == ScheduleState.loading;
  bool get hasError => _state == ScheduleState.error;

  // Computed getters
  List<ClassSchedule> get todaySchedules {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    return _schedules.where((schedule) {
      return schedule.startTime.isAfter(todayStart) &&
          schedule.startTime.isBefore(todayEnd);
    }).toList();
  }

  List<ClassSchedule> get upcomingSchedules {
    final now = DateTime.now();
    return _schedules.where((schedule) {
      return schedule.startTime.isAfter(now);
    }).toList();
  }

  List<Reservation> get upcomingReservations {
    final now = DateTime.now();
    return _userReservations.where((reservation) {
      // You'll need to join with schedule data to get start time
      // For now, filter by booking date (simplified)
      return reservation.reservedAt.isAfter(now) &&
          reservation.status == ReservationStatus.confirmed;
    }).toList();
  }

  // Initialize the provider
  Future<void> initialize(String userId) async {
    try {
      _setState(ScheduleState.loading);

      // Load initial data
      await Future.wait([
        loadSchedulesForDate(_selectedDate),
        loadUserReservations(userId),
        loadUserWaitlists(userId),
      ]);

      _setState(ScheduleState.loaded);
    } catch (e) {
      LogService.e('Error initializing schedule provider', error: e);
      _setError('Failed to load schedule data');
    }
  }

  // Load schedules for a specific date
  Future<void> loadSchedulesForDate(DateTime date) async {
    try {
      _setState(ScheduleState.loading);

      final schedules = await _scheduleService.getSchedulesForDateRange(
        date,
        date,
      );
      _schedules = schedules;
      _selectedDate = date;

      _setState(ScheduleState.loaded);
      LogService.i('Loaded ${schedules.length} schedules for $date');
    } catch (e) {
      LogService.e('Error loading schedules for date', error: e);
      _setError('Failed to load schedules');
    }
  }

  // Load schedules for date range
  Future<void> loadSchedulesForDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      _setState(ScheduleState.loading);

      final schedules = await _scheduleService.getSchedulesForDateRange(
        startDate,
        endDate,
      );
      _schedules = schedules;

      _setState(ScheduleState.loaded);
      LogService.i(
        'Loaded ${schedules.length} schedules for range $startDate - $endDate',
      );
    } catch (e) {
      LogService.e('Error loading schedules for date range', error: e);
      _setError('Failed to load schedules');
    }
  }

  // Load today's schedules
  Future<void> loadTodaySchedules() async {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    await loadSchedulesForDate(todayStart);
  }

  // Load this week's schedules
  Future<void> loadWeekSchedules() async {
    try {
      _setState(ScheduleState.loading);

      final schedules = await _scheduleService.getWeekSchedules();
      _schedules = schedules;

      _setState(ScheduleState.loaded);
      LogService.i('Loaded ${schedules.length} schedules for this week');
    } catch (e) {
      LogService.e('Error loading week schedules', error: e);
      _setError('Failed to load weekly schedules');
    }
  }

  // Book a class
  Future<bool> bookClass(String scheduleId, String userId) async {
    try {
      _setBookingState(true);

      final reservation = await _scheduleService.bookClass(scheduleId, userId);

      // Update local state
      _userReservations.insert(0, reservation);

      // Update schedule enrollment in local state
      final scheduleIndex = _schedules.indexWhere((s) => s.id == scheduleId);
      if (scheduleIndex != -1) {
        _schedules[scheduleIndex] = _schedules[scheduleIndex].copyWith(
          currentEnrollment: _schedules[scheduleIndex].currentEnrollment + 1,
        );
      }

      _setBookingState(false);
      notifyListeners();

      LogService.userAction(
        'Class booked successfully',
        data: {'scheduleId': scheduleId, 'reservationId': reservation.id},
      );

      return true;
    } catch (e) {
      _setBookingState(false);
      LogService.e('Error booking class', error: e);

      if (e is BusinessException) {
        _setError(e.message);
      } else {
        _setError('Failed to book class');
      }

      return false;
    }
  }

  // Cancel a reservation
  Future<bool> cancelReservation(String reservationId) async {
    try {
      _setCancellingState(true);

      // Find the reservation to get schedule ID
      final reservation = _userReservations.firstWhere(
        (r) => r.id == reservationId,
      );

      await _scheduleService.cancelReservation(reservationId);

      // Update local state
      _userReservations.removeWhere((r) => r.id == reservationId);

      // Update schedule enrollment in local state
      final scheduleIndex = _schedules.indexWhere(
        (s) => s.id == reservation.scheduleId,
      );
      if (scheduleIndex != -1) {
        _schedules[scheduleIndex] = _schedules[scheduleIndex].copyWith(
          currentEnrollment: _schedules[scheduleIndex].currentEnrollment - 1,
        );
      }

      _setCancellingState(false);
      notifyListeners();

      LogService.userAction(
        'Reservation cancelled successfully',
        data: {'reservationId': reservationId},
      );

      return true;
    } catch (e) {
      _setCancellingState(false);
      LogService.e('Error cancelling reservation', error: e);
      _setError('Failed to cancel reservation');
      return false;
    }
  }

  // Join waitlist
  Future<bool> joinWaitlist(String scheduleId, String userId) async {
    try {
      _setJoiningWaitlistState(true);

      final waitlist = await _scheduleService.joinWaitlist(scheduleId, userId);

      // Update local state
      _userWaitlists.insert(0, waitlist);

      _setJoiningWaitlistState(false);
      notifyListeners();

      LogService.userAction(
        'Joined waitlist successfully',
        data: {
          'scheduleId': scheduleId,
          'waitlistId': waitlist.id,
          'position': waitlist.position,
        },
      );

      return true;
    } catch (e) {
      _setJoiningWaitlistState(false);
      LogService.e('Error joining waitlist', error: e);

      if (e is BusinessException) {
        _setError(e.message);
      } else {
        _setError('Failed to join waitlist');
      }

      return false;
    }
  }

  // Load user reservations
  Future<void> loadUserReservations(String userId) async {
    try {
      final reservations = await _scheduleService.getUserReservations(userId);
      _userReservations = reservations;
      notifyListeners();

      LogService.i('Loaded ${reservations.length} user reservations');
    } catch (e) {
      LogService.e('Error loading user reservations', error: e);
      // Don't set error state for this as it's a secondary operation
    }
  }

  // Load user waitlists
  Future<void> loadUserWaitlists(String userId) async {
    try {
      final waitlists = await _scheduleService.getUserWaitlists(userId);
      _userWaitlists = waitlists;
      notifyListeners();

      LogService.i('Loaded ${waitlists.length} user waitlists');
    } catch (e) {
      LogService.e('Error loading user waitlists', error: e);
      // Don't set error state for this as it's a secondary operation
    }
  }

  // Apply filters
  void applyFilters({
    String? classId,
    String? instructorId,
    String? studioId,
  }) async {
    try {
      _setState(ScheduleState.loading);

      final schedules = await _scheduleService.getSchedulesForDateRange(
        _selectedDate,
        _selectedDate,
        classId: classId,
        instructorId: instructorId,
        studioId: studioId,
      );

      _schedules = schedules;
      _setState(ScheduleState.loaded);

      LogService.i(
        'Applied filters: class=$classId, instructor=$instructorId, studio=$studioId',
      );
    } catch (e) {
      LogService.e('Error applying filters', error: e);
      _setError('Failed to apply filters');
    }
  }

  // Clear filters
  void clearFilters() {
    loadSchedulesForDate(_selectedDate);
  }

  // Select a specific schedule for detailed view
  void selectSchedule(ClassSchedule schedule) {
    _selectedSchedule = schedule;
    notifyListeners();
  }

  // Clear selected schedule
  void clearSelectedSchedule() {
    _selectedSchedule = null;
    notifyListeners();
  }

  // Change selected date
  void changeSelectedDate(DateTime date) {
    _selectedDate = date;
    loadSchedulesForDate(date);
  }

  // Refresh all data
  Future<void> refresh(String userId) async {
    try {
      _setState(ScheduleState.loading);

      await Future.wait([
        loadSchedulesForDate(_selectedDate),
        loadUserReservations(userId),
        loadUserWaitlists(userId),
      ]);

      _setState(ScheduleState.loaded);
    } catch (e) {
      LogService.e('Error refreshing data', error: e);
      _setError('Failed to refresh data');
    }
  }

  // Check if user has reservation for specific schedule
  bool hasReservationForSchedule(String scheduleId) {
    return _userReservations.any(
      (reservation) =>
          reservation.scheduleId == scheduleId &&
          reservation.status == ReservationStatus.confirmed,
    );
  }

  // Check if user is on waitlist for specific schedule
  bool isOnWaitlistForSchedule(String scheduleId) {
    return _userWaitlists.any(
      (waitlist) =>
          waitlist.scheduleId == scheduleId &&
          waitlist.status == WaitlistStatus.waiting,
    );
  }

  // Get reservation for specific schedule
  Reservation? getReservationForSchedule(String scheduleId) {
    try {
      return _userReservations.firstWhere(
        (reservation) =>
            reservation.scheduleId == scheduleId &&
            reservation.status == ReservationStatus.confirmed,
      );
    } catch (e) {
      return null;
    }
  }

  // Get waitlist entry for specific schedule
  Waitlist? getWaitlistForSchedule(String scheduleId) {
    try {
      return _userWaitlists.firstWhere(
        (waitlist) =>
            waitlist.scheduleId == scheduleId &&
            waitlist.status == WaitlistStatus.waiting,
      );
    } catch (e) {
      return null;
    }
  }

  // Private methods for state management
  void _setState(ScheduleState state) {
    _state = state;
    if (state != ScheduleState.error) {
      _errorMessage = null;
    }
    notifyListeners();
  }

  void _setError(String message) {
    _state = ScheduleState.error;
    _errorMessage = message;
    notifyListeners();
  }

  void _setBookingState(bool isBooking) {
    _isBooking = isBooking;
    notifyListeners();
  }

  void _setCancellingState(bool isCancelling) {
    _isCancelling = isCancelling;
    notifyListeners();
  }

  void _setJoiningWaitlistState(bool isJoining) {
    _isJoiningWaitlist = isJoining;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    if (_state == ScheduleState.error) {
      _state = ScheduleState.loaded;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    // Clean up any resources if needed
    super.dispose();
  }
}
