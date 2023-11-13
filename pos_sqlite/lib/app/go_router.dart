import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos_sqlite/app/nav_tab.dart';
import 'package:pos_sqlite/business/entities/category_entity.dart';
import 'package:pos_sqlite/business/entities/order_entity.dart';
import 'package:pos_sqlite/business/entities/table_entity.dart';
import 'package:pos_sqlite/main.dart';
import 'package:pos_sqlite/presentation/pages/goods/items_page.dart';
import 'package:pos_sqlite/presentation/pages/goods/categories_page.dart';
import 'package:pos_sqlite/presentation/pages/orders/client_page.dart';
import 'package:pos_sqlite/presentation/pages/orders/orders_page.dart';
import 'package:pos_sqlite/presentation/pages/orders/tables_page.dart';

import '../presentation/scaffold_with_navigation/scaffold_with_nested_navigation.dart';

final _mainNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>();
final _shellNavigatorBKey = GlobalKey<NavigatorState>();

GoRouter goRouter() {
  List<NavTab> branches = [
    NavTab(
      path: '/goods',
      icon: Icons.list,
      label: 'Товары',
    ),
    NavTab(
      path: '/orders',
      icon: Icons.receipt,
      label: 'Заказы',
    ),
  ];

  return GoRouter(
    initialLocation: branches[0].path,
    navigatorKey: _mainNavigatorKey,
    debugLogDiagnostics: showDebug,
    routes: [
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) =>
            CustomTransitionPage<void>(
          key: state.pageKey,
          child: ScaffoldWithNestedNavigation(
              navigationShell: navigationShell, branches: branches),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAKey,
            routes: [
              GoRoute(
                path: branches[0].path,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CategoriesPage(),
                ),
                routes: [
                  GoRoute(
                    path: 'category',
                    builder: (context, state) {
                      final category = state.extra as CategoryEntity;
                      return ItemsPage(category: category);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBKey,
            routes: [
              GoRoute(
                path: branches[1].path,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: TablesPage(),
                ),
                routes: [
                  GoRoute(
                    path: 'table_orders',
                    builder: (context, state) {
                      final table = state.extra as TableEntity;
                      return OrdersPage(table: table);
                    },
                  ),
                  GoRoute(
                    path: 'all_orders',
                    builder: (context, state) {
                      return const OrdersPage();
                    },
                  ),
                  GoRoute(
                    path: 'order',
                    builder: (context, state) {
                      final order = state.extra as OrderEntity;
                      return ClientPage(order: order);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
