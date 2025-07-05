import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

enum UserRole {
  // Member - Just a regular user, no special permissions
  // Üye - Sadece normal bir kullanıcı, özel izinleri yok
  member,
  // Trainer - Created by admin, can manage classes and view reports
  // Eğitmen - Admin tarafından oluşturulan, dersleri yönetebilir ve raporları görüntüleyebilir
  trainer,
  // Admin - Created by super admin, can manage users and view reports
  // Admin - Süper admin tarafından oluşturulan, kullanıcıları yönetebilir ve raporları görüntüleyebilir
  admin,
  // Super Admin - Created during development/setup, can manage everything
  // Süper Admin - Geliştirme/kurulum sırasında oluşturulan, her şeyi yönetebilir
  superAdmin,
}

extension UserRoleExtension on UserRole {
  String displayName(BuildContext context) {
    final localizer = AppLocalizations.of(context)!;
    switch (this) {
      case UserRole.member:
        return localizer.userRoleMember;
      case UserRole.trainer:
        return localizer.userRoleTrainer;
      case UserRole.admin:
        return localizer.userRoleAdmin;
      case UserRole.superAdmin:
        return localizer.userRoleSuperAdmin;
    }
  }

  bool get canManageUsers =>
      this == UserRole.admin || this == UserRole.superAdmin;
  bool get canManageClasses =>
      this == UserRole.admin ||
      this == UserRole.superAdmin ||
      this == UserRole.trainer;
  bool get canViewReports =>
      this == UserRole.admin || this == UserRole.superAdmin;
  bool get canManagePayments =>
      this == UserRole.admin || this == UserRole.superAdmin;
  bool get isStaff =>
      this == UserRole.trainer ||
      this == UserRole.admin ||
      this == UserRole.superAdmin;
}
