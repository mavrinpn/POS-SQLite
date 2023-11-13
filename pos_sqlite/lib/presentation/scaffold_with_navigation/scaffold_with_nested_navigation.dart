import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos_sqlite/app/nav_tab.dart';
import 'package:pos_sqlite/presentation/scaffold_with_navigation/scaffold_with_navigation_bar.dart';
import 'package:pos_sqlite/presentation/scaffold_with_navigation/scaffold_with_navigation_rail.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
    required this.branches,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;
  final List<NavTab> branches;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBarItems = [
      for (var branch in branches)
        BottomNavigationBarItem(
          icon: Icon(
            branch.icon,
            key: Key(branch.path),
          ),
          label: branch.label,
        ),
    ];

    final navigationRailDestinations = [
      for (var branch in branches)
        NavigationRailDestination(
          label: Text(branch.label),
          icon: Icon(branch.icon),
        )
    ];

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 450) {
        return ScaffoldWithNavigationBar(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
          items: bottomNavigationBarItems,
        );
      } else {
        return ScaffoldWithNavigationRail(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
          items: navigationRailDestinations,
        );
      }
    });
  }
}
