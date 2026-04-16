import '../entities/recent_detection.dart';
import '../entities/trending_item.dart';
import '../entities/user.dart';

abstract class DashboardRepository {
  Future<User> getCurrentUser();
  Future<TrendingItem?> getTrendingItem();
  Future<List<RecentDetection>> getRecentDetections();
}
