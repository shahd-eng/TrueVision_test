import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/recent_detection.dart';
import '../../../domain/entities/trending_item.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/dashboard_repository.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository _repository;

  DashboardCubit(this._repository) : super(const DashboardState.initial());

  Future<void> loadDashboard() async {
    emit(const DashboardState.loading());

    try {
      final user = await _repository.getCurrentUser();
      final trendingItem = await _repository.getTrendingItem();
      final recentDetections = await _repository.getRecentDetections();

      emit(
        DashboardState.loaded(
          user: user,
          trendingItem: trendingItem,
          recentDetections: recentDetections,
        ),
      );
    } catch (e) {
      emit(DashboardState.error(e.toString()));
    }
  }
}
