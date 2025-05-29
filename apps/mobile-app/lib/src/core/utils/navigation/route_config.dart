import 'package:almabike_app/src/features/home/home_view.dart';
import 'package:almabike_app/src/features/pin_code/pin_code_view.dart';
import 'package:almabike_app/src/features/pin_code/set_pin_code_view.dart';
import 'package:almabike_app/src/features/profile/profile_view.dart';
import 'package:almabike_app/src/features/profile/views/bank_card_view.dart';
import 'package:almabike_app/src/features/profile/views/history_view.dart';
import 'package:almabike_app/src/features/profile/views/security_view.dart';
import 'package:almabike_app/src/features/profile/views/user_info_view.dart';
import 'package:almabike_app/src/features/qr_scanner/enter_number_view.dart';
import 'package:almabike_app/src/features/qr_scanner/qr_scanner_view.dart';
import 'package:almabike_app/src/features/verification/pages/verification_step_one.dart';
import 'package:almabike_app/src/features/verification/pages/verification_step_three.dart';
import 'package:almabike_app/src/features/verification/pages/verification_step_two.dart';
import 'package:almabike_shared/core/utils/app_storage.dart';
import 'package:almabike_app/src/features/auth/auth_view.dart';
import 'package:almabike_app/src/features/onboarding/onboarding_view.dart';
import 'package:almabike_app/src/features/profile/views/language_view.dart';
import 'package:almabike_app/src/features/verification/pages/verification_result.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../features/auth_verification/auth_verification_view.dart';

part 'route_config.gr.dart';

bool isOnboarded = false;
bool isAuthenticated = false;
bool isVerified = false;

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        //Home
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          guards: guards,
        ),
        AutoRoute(page: QrScannerRoute.page),
        AutoRoute(page: EnterNumberRoute.page),

        // Authorization
        AutoRoute(page: AuthRoute.page),
        AutoRoute(page: AuthVerificationRoute.page),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: PinCodeRoute.page),
        AutoRoute(page: SetPinCodeRoute.page),

        //Verification
        AutoRoute(page: VerificationStepOneRoute.page),
        AutoRoute(page: VerificationStepTwoRoute.page),
        AutoRoute(page: VerificationStepThreeRoute.page),
        AutoRoute(page: VerificationResultRoute.page),

        //Profile
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: UserInfoRoute.page),
        AutoRoute(page: BankCardRoute.page),
        AutoRoute(page: HistoryRoute.page),
        AutoRoute(page: LanguageRoute.page),
        AutoRoute(page: SecurityRoute.page),
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
          } else if (AppStorage.authByBiometrics) {
            resolver.redirectUntil(const PinCodeRoute());
          } else {
            resolver.redirectUntil(AuthRoute());
          }
        } else {
          final isGuarded = isOnboarded || routeName == OnboardingRoute.name;
          if (isGuarded) {
            resolver.next();
          } else {
            resolver.redirectUntil(const OnboardingRoute());
            isOnboarded = true;
          }
        }
      },
    ),
  ];
}
