import 'package:equatable/equatable.dart';

class TrendingItem extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final bool isAiGenerated;
  final String views;
  final String shares;
  final double aiConfidence;

  const TrendingItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    this.isAiGenerated = false,
    required this.views,
    required this.shares,
    this.aiConfidence = 0,
  });

  @override
  List<Object?> get props => [id, title, description];
}
