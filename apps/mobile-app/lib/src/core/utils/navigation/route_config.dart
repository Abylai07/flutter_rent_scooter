import 'package:almabike_app/src/core/utils/app_storage.dart';
import 'package:almabike_app/src/core/utils/navigation/route_config.gr.dart';
import 'package:auto_route/auto_route.dart';

bool isOnboarded = false;
bool isAuthenticated = true;

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          guards: guards,
        ),
        AutoRoute(page: AuthRoute.page),
        AutoRoute(page: AuthVerificationRoute.page),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: PinCodeRoute.page),
        AutoRoute(page: SetPinCodeRoute.page),
        AutoRoute(page: QrScannerRoute.page),
      ];

  List<String> get unguardedRoutes => [
        AuthRoute.name,
        AuthVerificationRoute.name,
        SetPinCodeRoute.name,
        PinCodeRoute.name,
      ];

  bool isUnguardedRoute(String routeName) =>
      unguardedRoutes.contains(routeName);

  @override
  late final List<AutoRouteGuard> guards = [
    AutoRouteGuard.simple(
      (resolver, router) {
        final routeName = resolver.routeName;
        isOnboarded = AppStorage.isOnboarded;
        if (isOnboarded) {
          final isGuarded = isAuthenticated || isUnguardedRoute(routeName);
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
            resolver.redirect(const OnboardingRoute());
            isOnboarded = true;
          }
        }
      },
    ),
  ];
}
