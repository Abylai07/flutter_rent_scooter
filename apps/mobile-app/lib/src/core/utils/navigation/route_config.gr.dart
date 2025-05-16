// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:almabike_app/src/feature/auth/auth_view.dart'
    as _i2;
import 'package:almabike_app/src/feature/auth_verification/auth_verification_view.dart'
    as _i1;
import 'package:almabike_app/src/feature/home/home_view.dart'
    as _i3;
import 'package:almabike_app/src/feature/onboarding/onboarding_view.dart'
    as _i4;
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

/// generated route for
/// [_i1.AuthVerificationView]
class AuthVerificationRoute
    extends _i5.PageRouteInfo<AuthVerificationRouteArgs> {
  AuthVerificationRoute({
    _i6.Key? key,
    required String phone,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         AuthVerificationRoute.name,
         args: AuthVerificationRouteArgs(key: key, phone: phone),
         initialChildren: children,
       );

  static const String name = 'AuthVerificationRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AuthVerificationRouteArgs>();
      return _i1.AuthVerificationView(key: args.key, phone: args.phone);
    },
  );
}

class AuthVerificationRouteArgs {
  const AuthVerificationRouteArgs({this.key, required this.phone});

  final _i6.Key? key;

  final String phone;

  @override
  String toString() {
    return 'AuthVerificationRouteArgs{key: $key, phone: $phone}';
  }
}

/// generated route for
/// [_i2.AuthView]
class AuthRoute extends _i5.PageRouteInfo<void> {
  const AuthRoute({List<_i5.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthView();
    },
  );
}

/// generated route for
/// [_i3.HomeView]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeView();
    },
  );
}

/// generated route for
/// [_i4.OnboardingView]
class OnboardingRoute extends _i5.PageRouteInfo<void> {
  const OnboardingRoute({List<_i5.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.OnboardingView();
    },
  );
}
