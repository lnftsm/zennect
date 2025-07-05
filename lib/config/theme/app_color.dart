import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors - Zen-inspired palette
  static const Color primary = Color(0xFF2E8B57); // Sea Green
  static const Color primaryLight = Color(0xFF52C785);
  static const Color primaryDark = Color(0xFF1F5F3F);

  // Secondary Colors
  static const Color secondary = Color(0xFF8B7355); // Warm Brown
  static const Color secondaryLight = Color(0xFFB8A082);
  static const Color secondaryDark = Color(0xFF5D4C37);

  // Accent Colors
  static const Color accent = Color(0xFFE6B17A); // Soft Gold
  static const Color accentLight = Color(0xFFF0C794);
  static const Color accentDark = Color(0xFFD4975C);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Background Colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFFFFFFFF);

  // Border Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderFocused = Color(0xFF2E8B57);
  static const Color borderError = Color(0xFFF44336);

  // Shadow Colors
  static Color shadow = const Color(0xFF000000).withValues(alpha: 0.16);
  static Color shadowLight = const Color(0xFF000000).withValues(alpha: 0.08);
  static Color shadowDark = const Color(0xFF000000).withValues(alpha: 0.24);

  // Overlay Colors
  static Color overlay = const Color(0xFF000000).withValues(alpha: 0.5);
  static Color overlayLight = const Color(0xFF000000).withValues(alpha: 0.3);
  static Color overlayDark = const Color(0xFF000000).withValues(alpha: 0.7);

  // Status Colors for Membership
  static const Color statusActive = Color(0xFF4CAF50);
  static const Color statusExpired = Color(0xFFF44336);
  static const Color statusPending = Color(0xFFFF9800);
  static const Color statusSuspended = Color(0xFF9E9E9E);

  // Class Type Colors
  static const Color pilatesColor = Color(0xFF8E24AA); // Purple
  static const Color yogaColor = Color(0xFF43A047); // Green
  static const Color meditationColor = Color(0xFF1E88E5); // Blue
  static const Color wellnessColor = Color(0xFFFF7043); // Orange

  // Difficulty Level Colors
  static const Color beginnerColor = Color(0xFF4CAF50); // Green
  static const Color intermediateColor = Color(0xFFFF9800); // Orange
  static const Color advancedColor = Color(0xFFF44336); // Red

  // Payment Status Colors
  static const Color paymentSuccess = Color(0xFF4CAF50);
  static const Color paymentPending = Color(0xFFFF9800);
  static const Color paymentFailed = Color(0xFFF44336);
  static const Color paymentRefunded = Color(0xFF9C27B0);

  // Calendar Colors
  static const Color calendarToday = Color(0xFF2E8B57);
  static const Color calendarSelected = Color(0xFF1F5F3F);
  static const Color calendarAvailable = Color(0xFF4CAF50);
  static const Color calendarFull = Color(0xFFF44336);
  static const Color calendarPast = Color(0xFF9E9E9E);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2E8B57), Color(0xFF52C785)],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8B7355), Color(0xFFB8A082)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE6B17A), Color(0xFFF0C794)],
  );

  // Method to get color by class category
  static Color getClassCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'pilates':
        return pilatesColor;
      case 'yoga':
        return yogaColor;
      case 'meditation':
        return meditationColor;
      case 'wellness':
        return wellnessColor;
      default:
        return primary;
    }
  }

  // Method to get color by difficulty level
  static Color getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return beginnerColor;
      case 'intermediate':
        return intermediateColor;
      case 'advanced':
        return advancedColor;
      default:
        return primary;
    }
  }

  // Method to get color by membership status
  static Color getMembershipStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return statusActive;
      case 'expired':
        return statusExpired;
      case 'pending':
        return statusPending;
      case 'suspended':
        return statusSuspended;
      default:
        return grey500;
    }
  }

  // Method to get color by payment status
  static Color getPaymentStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
        return paymentSuccess;
      case 'pending':
        return paymentPending;
      case 'failed':
      case 'cancelled':
        return paymentFailed;
      case 'refunded':
        return paymentRefunded;
      default:
        return grey500;
    }
  }
}
