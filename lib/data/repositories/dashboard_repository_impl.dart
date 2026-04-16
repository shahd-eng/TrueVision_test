import '../../domain/entities/recent_detection.dart';
import '../../domain/entities/trending_item.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_datasource.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> getCurrentUser() => remoteDataSource.getCurrentUser();

  @override
  Future<TrendingItem?> getTrendingItem() => remoteDataSource.getTrendingItem();

  @override
  Future<List<RecentDetection>> getRecentDetections() =>
      remoteDataSource.getRecentDetections();
}
