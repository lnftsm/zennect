import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

enum PrivateClassStatus { pending, approved, rejected, completed, cancelled }

class PrivateClassRequest {
  final String id;
  final String userId;
  final String? instructorId;
  final DateTime requestedDate;
  final String requestedTime;
  final String? notes;
  final double? price;
  final PrivateClassStatus status;
  final String? adminNotes;
  final DateTime? approvedAt;
  final DateTime? rejectedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  PrivateClassRequest({
    required this.id,
    required this.userId,
    this.instructorId,
    required this.requestedDate,
    required this.requestedTime,
    this.notes,
    this.price,
    this.status = PrivateClassStatus.pending,
    this.adminNotes,
    this.approvedAt,
    this.rejectedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PrivateClassRequest.fromJson(Map<String, dynamic> json) {
    return PrivateClassRequest(
      id: json['id'],
      userId: json['userId'],
      instructorId: json['instructorId'],
      requestedDate: DateTime.parse(json['requestedDate']),
      requestedTime: json['requestedTime'],
      notes: json['notes'],
      price: json['price']?.toDouble(),
      status: PrivateClassStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      adminNotes: json['adminNotes'],
      approvedAt: json['approvedAt'] != null
          ? DateTime.parse(json['approvedAt'])
          : null,
      rejectedAt: json['rejectedAt'] != null
          ? DateTime.parse(json['rejectedAt'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'instructorId': instructorId,
      'requestedDate': requestedDate.toIso8601String(),
      'requestedTime': requestedTime,
      'notes': notes,
      'price': price,
      'status': status.toString().split('.').last,
      'adminNotes': adminNotes,
      'approvedAt': approvedAt?.toIso8601String(),
      'rejectedAt': rejectedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  bool get isPending => status == PrivateClassStatus.pending;
  bool get isApproved => status == PrivateClassStatus.approved;
  bool get isRejected => status == PrivateClassStatus.rejected;
  bool get isCompleted => status == PrivateClassStatus.completed;
  bool get isCancelled => status == PrivateClassStatus.cancelled;

  String statusDisplayName(BuildContext context) {
    final localizer = AppLocalizations.of(context);
    switch (status) {
      case PrivateClassStatus.pending:
        return localizer!.privateClassPending;
      case PrivateClassStatus.approved:
        return localizer!.privateClassApproved;
      case PrivateClassStatus.rejected:
        return localizer!.privateClassRejected;
      case PrivateClassStatus.completed:
        return localizer!.privateClassCompleted;
      case PrivateClassStatus.cancelled:
        return localizer!.privateClassCancelled;
    }
  }

  String get formattedPrice =>
      price != null ? '${price!.toStringAsFixed(0)} ₺' : 'Belirtilmemiş';

  PrivateClassRequest copyWith({
    String? id,
    String? userId,
    String? instructorId,
    DateTime? requestedDate,
    String? requestedTime,
    String? notes,
    double? price,
    PrivateClassStatus? status,
    String? adminNotes,
    DateTime? approvedAt,
    DateTime? rejectedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PrivateClassRequest(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      instructorId: instructorId ?? this.instructorId,
      requestedDate: requestedDate ?? this.requestedDate,
      requestedTime: requestedTime ?? this.requestedTime,
      notes: notes ?? this.notes,
      price: price ?? this.price,
      status: status ?? this.status,
      adminNotes: adminNotes ?? this.adminNotes,
      approvedAt: approvedAt ?? this.approvedAt,
      rejectedAt: rejectedAt ?? this.rejectedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
