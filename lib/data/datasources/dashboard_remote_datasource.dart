import '../models/recent_detection_model.dart';
import '../models/trending_item_model.dart';
import '../models/user_model.dart';

abstract class DashboardRemoteDataSource {
  Future<UserModel> getCurrentUser();
  Future<TrendingItemModel?> getTrendingItem();
  Future<List<RecentDetectionModel>> getRecentDetections();
}
