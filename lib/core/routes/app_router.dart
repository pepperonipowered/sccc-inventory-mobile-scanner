import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:sccc_v3/core/routes/scaffold_with_nested_navigation.dart';
import 'package:sccc_v3/core/routes/stream_to_listenable.dart';
import 'package:sccc_v3/feat/auth/presentation/bloc/auth_cubit.dart';
import 'package:sccc_v3/feat/auth/presentation/bloc/auth_states.dart';
import 'package:sccc_v3/feat/auth/presentation/pages/login_page.dart';
import 'package:sccc_v3/feat/auth/presentation/pages/profile_page.dart';
import 'package:sccc_v3/feat/auth/presentation/pages/register_page.dart';
import 'package:sccc_v3/feat/borrow_list/presentation/pages/borrow_list_page.dart';
import 'package:sccc_v3/feat/borrow_transaction/presentation/borrow_transaction_page.dart';
import 'package:sccc_v3/feat/item_list/presentation/pages/equipment_details_page.dart';
import 'package:sccc_v3/feat/item_list/presentation/pages/item_list_page.dart';
import 'package:sccc_v3/feat/item_list/presentation/pages/supply_details_page.dart';
import 'package:sccc_v3/feat/scanner/presentation/pages/scanner_page.dart';
import 'package:sccc_v3/service_locator.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  static GoRouter getRouter(AuthCubit authCubit) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      refreshListenable: StreamToListenable([authCubit.stream]),
      redirect: (context, state) {
        final status = authCubit.state;
        final isAuthPage = state.uri.path == '/login' || state.uri.path == '/register';

        getIt<Logger>().d('Checking redirect, status: $status, path: ${state.uri.path}');

        if (status is AuthLoading) {
          // Avoid redirecting during initial loading
          return '/login';
        }

        if (status is Authenticated && isAuthPage) {
          return '/';
        }

        if (status is UnAuthenticated && !isAuthPage || status is AuthError) {
          // Allow unauthenticated users to access /login and /register
          if (!isAuthPage) {
            // If trying to access protected routes, redirect to login
            return '/login';
          }
        }

        return null;
      },
      routes: [
        GoRoute(path: '/register', pageBuilder: (context, state) => const MaterialPage(child: RegisterPage())),
        GoRoute(path: '/login', pageBuilder: (context, state) => const MaterialPage(child: LoginPage())),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/',
                  pageBuilder: (context, state) => NoTransitionPage(child: ItemListPage()),
                  routes: [
                    GoRoute(
                      path: 'supply/:itemId',
                      pageBuilder: (context, state) {
                        final itemId = state.pathParameters['itemId']!;
                        return MaterialPage(child: SupplyDetailsPage(itemId: itemId));
                      },
                    ),
                    GoRoute(
                      path: 'equipment',
                      pageBuilder: (context, state) {
                        final itemId = state.uri.queryParameters['item_id']!;
                        final copyNum = state.uri.queryParameters['copy_num']!;
                        return MaterialPage(child: EquipmentDetailsPage(itemId: itemId, copyNum: copyNum));
                      },
                    ),
                    GoRoute(
                      path: 'borrow_list',
                      pageBuilder: (context, state) {
                        return MaterialPage(child: BorrowListPage());
                      },
                      routes: [
                        GoRoute(
                          path: 'new_transaction',
                          pageBuilder: (context, state) {
                            return MaterialPage(child: BorrowTransactionPage());
                          },
                        ),
                      ],
                    ),
                    GoRoute(
                      path: 'qr_scanner',
                      pageBuilder: (context, state) {
                        return MaterialPage(child: ScannerPage());
                      },
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/settings',
                  pageBuilder: (context, state) => const NoTransitionPage(child: ProfilePage()),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
