import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

enum NotificationType {
  classReminder,
  membershipExpiring,
  waitlistAvailable,
  announcement,
  classCancelled,
  privateClassApproved,
  privateClassRejected,
  lowClassCount,
}

class AppNotification {
  final String id;
  final String userId;
  final String title;
  final String body;
  final NotificationType type;
  final Map<String, dynamic>? data;
  final bool isRead;
  final DateTime? readAt;
  final DateTime createdAt;

  AppNotification({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    this.data,
    this.isRead = false,
    this.readAt,
    required this.createdAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
      type: NotificationType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      data: json['data'],
      isRead: json['isRead'] ?? false,
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt']) : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'type': type.toString().split('.').last,
      'data': data,
      'isRead': isRead,
      'readAt': readAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  bool get isClassReminder => type == NotificationType.classReminder;
  bool get isMembershipExpiring => type == NotificationType.membershipExpiring;
  bool get isWaitlistAvailable => type == NotificationType.waitlistAvailable;
  bool get isAnnouncement => type == NotificationType.announcement;
  bool get isClassCancelled => type == NotificationType.classCancelled;
  bool get isPrivateClassUpdate =>
      type == NotificationType.privateClassApproved ||
      type == NotificationType.privateClassRejected;
  bool get isLowClassCount => type == NotificationType.lowClassCount;

  String typeLocalizedName(BuildContext context) {
    final localizer = AppLocalizations.of(context);
    switch (type) {
      case NotificationType.classReminder:
        return localizer!.notificationClassReminder;
      case NotificationType.membershipExpiring:
        return localizer!.notificationMembershipExpiring;
      case NotificationType.waitlistAvailable:
        return localizer!.notificationWaitlistAvailable;
      case NotificationType.announcement:
        return localizer!.notificationAnnouncement;
      case NotificationType.classCancelled:
        return localizer!.notificationClassCancelled;
      case NotificationType.privateClassApproved:
        return localizer!.notificationPrivateClassApproved;
      case NotificationType.privateClassRejected:
        return localizer!.notificationPrivateClassRejected;
      case NotificationType.lowClassCount:
        return localizer!.notificationLowClassCount;
    }
  }

  AppNotification copyWith({
    String? id,
    String? userId,
    String? title,
    String? body,
    NotificationType? type,
    Map<String, dynamic>? data,
    bool? isRead,
    DateTime? readAt,
    DateTime? createdAt,
  }) {
    return AppNotification(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      data: data ?? this.data,
      isRead: isRead ?? this.isRead,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
