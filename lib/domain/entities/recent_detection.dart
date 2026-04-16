import 'package:equatable/equatable.dart';

class RecentDetection extends Equatable {
  final String id;
  final String label;
  final String platform;
  final String title;
  final String subtitle;
  final String? imagePath;

  const RecentDetection({
    required this.id,
    required this.label,
    required this.platform,
    required this.title,
    required this.subtitle,
    this.imagePath,
  });

  @override
  List<Object?> get props => [id, label, platform, title, subtitle];
}
