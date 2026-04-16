part of 'dashboard_cubit.dart';

enum DashboardStatus { initial, loading, loaded, error }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final User? user;
  final TrendingItem? trendingItem;
  final List<RecentDetection> recentDetections;
  final String? errorMessage;

  const DashboardState._({
    required this.status,
    this.user,
    this.trendingItem,
    this.recentDetections = const [],
    this.errorMessage,
  });

  const DashboardState.initial() : this._(status: DashboardStatus.initial);

  const DashboardState.loading() : this._(status: DashboardStatus.loading);

  // ignore: prefer_const_constructors_in_immutables
  DashboardState.loaded({
    required User user,
    TrendingItem? trendingItem,
    required List<RecentDetection> recentDetections,
  }) : this._(
         status: DashboardStatus.loaded,
         user: user,
         trendingItem: trendingItem,
         recentDetections: recentDetections,
       );

  const DashboardState.error(String message)
    : this._(status: DashboardStatus.error, errorMessage: message);

  @override
  List<Object?> get props => [
    status,
    user,
    trendingItem,
    recentDetections,
    errorMessage,
  ];
}
