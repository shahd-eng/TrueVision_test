import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/app_colors.dart';
import '../dashboard/cubit/dashboard_cubit.dart';
import '../dashboard/pages/dashboard_home_page.dart';
import '../dashboard/widgets/dashboard_bottom_nav_bar.dart';
import '../education/education_mode_home.dart';
import '../profile/pages/profile_page.dart';

/// Exposes main tab switching to descendants (e.g. nested routes, profile back).
class MainShellScope extends InheritedWidget {
  final void Function(int tabIndex) selectTab;

  const MainShellScope({
    super.key,
    required this.selectTab,
    required super.child,
  });

  static MainShellScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MainShellScope>();
  }

  static void selectTabOf(BuildContext context, int tabIndex) {
    maybeOf(context)?.selectTab(tabIndex);
  }

  @override
  bool updateShouldNotify(MainShellScope oldWidget) =>
      selectTab != oldWidget.selectTab;
}

/// Root layout: primary tabs + shared bottom navigation.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  /// Bottom nav indices: 0 Home, 1 Learn, 2 FAB (never stored), 3 History, 4 Profile.
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().loadDashboard();
  }

  final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _learnNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _profileNavigatorKey =
      GlobalKey<NavigatorState>();

  int _stackIndexForTab(int tab) {
    switch (tab) {
      case 0:
        return 0;
      case 1:
        return 1;
      case 4:
        return 2;
      default:
        return 0;
    }
  }

  void _popNestedRoutesForTab(int tab) {
    if (tab == 0) {
      _homeNavigatorKey.currentState?.popUntil((r) => r.isFirst);
    } else if (tab == 1) {
      _learnNavigatorKey.currentState?.popUntil((r) => r.isFirst);
    } else if (tab == 4) {
      _profileNavigatorKey.currentState?.popUntil((r) => r.isFirst);
    }
  }

  void selectTab(int index) {
    if (index == 2 || index == 3) return;
    if (index != _tabIndex) {
      _popNestedRoutesForTab(_tabIndex);
      setState(() => _tabIndex = index);
    }
  }

  void _onBottomNavTap(int index) {
    if (index == 2) return;
    if (index == 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('History coming soon')),
      );
      return;
    }
    selectTab(index);
  }

  void _onScanTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Scan coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainShellScope(
      selectTab: selectTab,
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundDarkColor,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: _stackIndexForTab(_tabIndex),
                  children: [
                    Navigator(
                      key: _homeNavigatorKey,
                      initialRoute: '/',
                      onGenerateRoute: (settings) {
                        return MaterialPageRoute<void>(
                          settings: settings,
                          builder: (_) => const DashboardHomePage(),
                        );
                      },
                    ),
                    Navigator(
                      key: _learnNavigatorKey,
                      initialRoute: '/',
                      onGenerateRoute: (settings) {
                        return MaterialPageRoute<void>(
                          settings: settings,
                          builder: (_) => const EducationHomeScreen(),
                        );
                      },
                    ),
                    Navigator(
                      key: _profileNavigatorKey,
                      initialRoute: '/',
                      onGenerateRoute: (settings) {
                        return MaterialPageRoute<void>(
                          settings: settings,
                          builder: (_) => BlocBuilder<DashboardCubit, DashboardState>(
                            builder: (context, state) {
                              if (state.status == DashboardStatus.loaded &&
                                  state.user != null) {
                                return ProfilePage(user: state.user!);
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              DashboardBottomNavBar(
                selectedIndex: _tabIndex,
                onTabSelected: _onBottomNavTap,
                onScanTap: _onScanTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
