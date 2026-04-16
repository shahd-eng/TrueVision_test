import '../../domain/entities/trending_item.dart';

class TrendingItemModel extends TrendingItem {
  const TrendingItemModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imagePath,
    super.isAiGenerated,
    required super.views,
    required super.shares,
    super.aiConfidence,
  });

  factory TrendingItemModel.fromJson(Map<String, dynamic> json) {
    return TrendingItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imagePath: json['imagePath'] as String,
      isAiGenerated: json['isAiGenerated'] as bool? ?? false,
      views: json['views'] as String,
      shares: json['shares'] as String,
      aiConfidence: (json['aiConfidence'] as num?)?.toDouble() ?? 0,
    );
  }
}
