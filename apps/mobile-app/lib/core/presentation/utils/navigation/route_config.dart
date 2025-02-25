import 'package:almabike_app/core/presentation/utils/navigation/route_config.gr.dart';
import 'package:auto_route/auto_route.dart';

bool isOnboarded = false;
bool isAuthenticated = false;

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          guards: guards,
        ),
        AutoRoute(page: AuthRoute.page, initial: false),
        AutoRoute(page: OnboardingRoute.page, initial: false),
      ];

  @override
  late final List<AutoRouteGuard> guards = [
    AutoRouteGuard.simple(
      (resolver, router) {
        final routeName = resolver.routeName;
        if (isOnboarded) {
          final isGuarded = isAuthenticated || routeName == AuthRoute.name;
          if (isGuarded) {
            resolver.next();
          } else {
            resolver.redirect(AuthRoute());
          }
        } else {
          final isGuarded = isOnboarded || routeName == OnboardingRoute.name;
          if (isGuarded) {
            resolver.next();
          } else {
            resolver.redirect(OnboardingRoute());
            isOnboarded = true;
          }
        }
      },
    ),
  ];
}
