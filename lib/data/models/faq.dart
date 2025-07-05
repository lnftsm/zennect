import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

enum FAQCategory { membership, classes, payments, technical, general }

class FAQ {
  final String id;
  final String question;
  final String answer;
  final FAQCategory category;
  final int order;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  FAQ({
    required this.id,
    required this.question,
    required this.answer,
    required this.category,
    this.order = 0,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
      category: FAQCategory.values.firstWhere(
        (e) => e.toString().split('.').last == json['category'],
      ),
      order: json['order'] ?? 0,
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'category': category.toString().split('.').last,
      'order': order,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String categoryDisplayName(BuildContext context) {
    final localizer = AppLocalizations.of(context);
    switch (category) {
      case FAQCategory.membership:
        return localizer!.faqMembership;
      case FAQCategory.classes:
        return localizer!.faqClasses;
      case FAQCategory.payments:
        return localizer!.faqPayments;
      case FAQCategory.technical:
        return localizer!.faqTechnical;
      case FAQCategory.general:
        return localizer!.faqGeneral;
    }
  }

  FAQ copyWith({
    String? id,
    String? question,
    String? answer,
    FAQCategory? category,
    int? order,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FAQ(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      category: category ?? this.category,
      order: order ?? this.order,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
