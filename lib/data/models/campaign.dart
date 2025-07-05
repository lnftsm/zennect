enum CampaignType { percentage, fixedAmount, firstTime, seasonal }

class Campaign {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final CampaignType type;
  final double? discountPercentage;
  final double? discountAmount;
  final String? promoCode;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> applicablePackages; // package IDs
  final int? usageLimit;
  final int currentUsage;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Campaign({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.type,
    this.discountPercentage,
    this.discountAmount,
    this.promoCode,
    required this.startDate,
    required this.endDate,
    this.applicablePackages = const [],
    this.usageLimit,
    this.currentUsage = 0,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      type: CampaignType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      discountPercentage: json['discountPercentage']?.toDouble(),
      discountAmount: json['discountAmount']?.toDouble(),
      promoCode: json['promoCode'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      applicablePackages: List<String>.from(json['applicablePackages'] ?? []),
      usageLimit: json['usageLimit'],
      currentUsage: json['currentUsage'] ?? 0,
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'type': type.toString().split('.').last,
      'discountPercentage': discountPercentage,
      'discountAmount': discountAmount,
      'promoCode': promoCode,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'applicablePackages': applicablePackages,
      'usageLimit': usageLimit,
      'currentUsage': currentUsage,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  bool get isValid {
    final now = DateTime.now();
    return isActive &&
        now.isAfter(startDate) &&
        now.isBefore(endDate) &&
        (usageLimit == null || currentUsage < usageLimit!);
  }

  bool get hasUsageLimit => usageLimit != null;
  bool get isUsageExhausted =>
      usageLimit != null && currentUsage >= usageLimit!;
  bool get hasPromoCode => promoCode != null && promoCode!.isNotEmpty;
  int get remainingUsage =>
      usageLimit != null ? (usageLimit! - currentUsage) : -1;

  double calculateDiscount(double originalPrice) {
    if (!isValid) return 0;

    if (discountPercentage != null) {
      return originalPrice * (discountPercentage! / 100);
    } else if (discountAmount != null) {
      return discountAmount!;
    }
    return 0;
  }

  double calculateDiscountedPrice(double originalPrice) {
    final discount = calculateDiscount(originalPrice);
    return originalPrice - discount;
  }

  Campaign copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    CampaignType? type,
    double? discountPercentage,
    double? discountAmount,
    String? promoCode,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? applicablePackages,
    int? usageLimit,
    int? currentUsage,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Campaign(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountAmount: discountAmount ?? this.discountAmount,
      promoCode: promoCode ?? this.promoCode,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      applicablePackages: applicablePackages ?? this.applicablePackages,
      usageLimit: usageLimit ?? this.usageLimit,
      currentUsage: currentUsage ?? this.currentUsage,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
