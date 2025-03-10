import 'package:almabike_admin/core/presentation/utils/navigation/route_config.gr.dart';
import 'package:auto_route/auto_route.dart';

bool isAuthenticated = true;

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: ToirHomeRoute.page,
          initial: true,
          guards: guards,
        ),
      ];

  List<String> get unguardedRoutes => [];

  bool isUnguardedRoute(String routeName) =>
      unguardedRoutes.contains(routeName);

  @override
  late final List<AutoRouteGuard> guards = [
    AutoRouteGuard.simple(
      (resolver, router) {
        final routeName = resolver.routeName;
        final isGuarded = isAuthenticated || isUnguardedRoute(routeName);
        if (isGuarded) {
          resolver.next();
        } else {
          // resolver.redirect(AuthRoute());
        }
      },
    ),
  ];
}
