import '../../domain/entities/recent_detection.dart';

class RecentDetectionModel extends RecentDetection {
  const RecentDetectionModel({
    required super.id,
    required super.label,
    required super.platform,
    required super.title,
    required super.subtitle,
    super.imagePath,
  });

  factory RecentDetectionModel.fromJson(Map<String, dynamic> json) {
    return RecentDetectionModel(
      id: json['id'] as String,
      label: json['label'] as String,
      platform: json['platform'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      imagePath: json['imagePath'] as String?,
    );
  }
}
