// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:almabike_app/src/features/auth/auth_view.dart' as _i2;
import 'package:almabike_app/src/features/auth_verification/auth_verification_view.dart'
    as _i1;
import 'package:almabike_app/src/features/home/home_view.dart' as _i3;
import 'package:almabike_app/src/features/onboarding/onboarding_view.dart'
    as _i4;
import 'package:almabike_app/src/features/pin_code/pin_code_view.dart' as _i5;
import 'package:almabike_app/src/features/pin_code/set_pin_code_view.dart'
    as _i7;
import 'package:almabike_app/src/features/qr_scanner/qr_scanner.dart' as _i6;
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

/// generated route for
/// [_i1.AuthVerificationView]
class AuthVerificationRoute
    extends _i8.PageRouteInfo<AuthVerificationRouteArgs> {
  AuthVerificationRoute({
    _i9.Key? key,
    required String phone,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         AuthVerificationRoute.name,
         args: AuthVerificationRouteArgs(key: key, phone: phone),
         initialChildren: children,
       );

  static const String name = 'AuthVerificationRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AuthVerificationRouteArgs>();
      return _i1.AuthVerificationView(key: args.key, phone: args.phone);
    },
  );
}

class AuthVerificationRouteArgs {
  const AuthVerificationRouteArgs({this.key, required this.phone});

  final _i9.Key? key;

  final String phone;

  @override
  String toString() {
    return 'AuthVerificationRouteArgs{key: $key, phone: $phone}';
  }
}

/// generated route for
/// [_i2.AuthView]
class AuthRoute extends _i8.PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    _i9.Key? key,
    bool showRememberButton = false,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         AuthRoute.name,
         args: AuthRouteArgs(key: key, showRememberButton: showRememberButton),
         initialChildren: children,
       );

  static const String name = 'AuthRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AuthRouteArgs>(
        orElse: () => const AuthRouteArgs(),
      );
      return _i2.AuthView(
        key: args.key,
        showRememberButton: args.showRememberButton,
      );
    },
  );
}

class AuthRouteArgs {
  const AuthRouteArgs({this.key, this.showRememberButton = false});

  final _i9.Key? key;

  final bool showRememberButton;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key, showRememberButton: $showRememberButton}';
  }
}

/// generated route for
/// [_i3.HomeView]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeView();
    },
  );
}

/// generated route for
/// [_i4.OnboardingView]
class OnboardingRoute extends _i8.PageRouteInfo<void> {
  const OnboardingRoute({List<_i8.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.OnboardingView();
    },
  );
}

/// generated route for
/// [_i5.PinCodeView]
class PinCodeRoute extends _i8.PageRouteInfo<void> {
  const PinCodeRoute({List<_i8.PageRouteInfo>? children})
    : super(PinCodeRoute.name, initialChildren: children);

  static const String name = 'PinCodeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.PinCodeView();
    },
  );
}

/// generated route for
/// [_i6.QrScannerView]
class QrScannerRoute extends _i8.PageRouteInfo<void> {
  const QrScannerRoute({List<_i8.PageRouteInfo>? children})
    : super(QrScannerRoute.name, initialChildren: children);

  static const String name = 'QrScannerRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.QrScannerView();
    },
  );
}

/// generated route for
/// [_i7.SetPinCodeView]
class SetPinCodeRoute extends _i8.PageRouteInfo<void> {
  const SetPinCodeRoute({List<_i8.PageRouteInfo>? children})
    : super(SetPinCodeRoute.name, initialChildren: children);

  static const String name = 'SetPinCodeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.SetPinCodeView();
    },
  );
}
