import 'data/datasources/dashboard_remote_datasource_impl.dart';
import 'data/repositories/dashboard_repository_impl.dart';
import 'features/dashboard/cubit/dashboard_cubit.dart';


/// Simple dependency injection container for the application.
/// For larger apps, consider using get_it or injectable.
class Injection {
  static DashboardCubit createDashboardCubit() {
    final dataSource = DashboardRemoteDataSourceImpl();
    final repository = DashboardRepositoryImpl(remoteDataSource: dataSource);
    return DashboardCubit(repository);
  }
}
