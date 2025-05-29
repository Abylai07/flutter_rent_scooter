// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'route_config.dart';

/// generated route for
/// [AuthVerificationView]
class AuthVerificationRoute extends PageRouteInfo<AuthVerificationRouteArgs> {
  AuthVerificationRoute({
    Key? key,
    required String phone,
    List<PageRouteInfo>? children,
  }) : super(
         AuthVerificationRoute.name,
         args: AuthVerificationRouteArgs(key: key, phone: phone),
         initialChildren: children,
       );

  static const String name = 'AuthVerificationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AuthVerificationRouteArgs>();
      return AuthVerificationView(key: args.key, phone: args.phone);
    },
  );
}

class AuthVerificationRouteArgs {
  const AuthVerificationRouteArgs({this.key, required this.phone});

  final Key? key;

  final String phone;

  @override
  String toString() {
    return 'AuthVerificationRouteArgs{key: $key, phone: $phone}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AuthVerificationRouteArgs) return false;
    return key == other.key && phone == other.phone;
  }

  @override
  int get hashCode => key.hashCode ^ phone.hashCode;
}

/// generated route for
/// [AuthView]
class AuthRoute extends PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    Key? key,
    bool showRememberButton = false,
    List<PageRouteInfo>? children,
  }) : super(
         AuthRoute.name,
         args: AuthRouteArgs(key: key, showRememberButton: showRememberButton),
         initialChildren: children,
       );

  static const String name = 'AuthRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AuthRouteArgs>(
        orElse: () => const AuthRouteArgs(),
      );
      return AuthView(
        key: args.key,
        showRememberButton: args.showRememberButton,
      );
    },
  );
}

class AuthRouteArgs {
  const AuthRouteArgs({this.key, this.showRememberButton = false});

  final Key? key;

  final bool showRememberButton;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key, showRememberButton: $showRememberButton}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AuthRouteArgs) return false;
    return key == other.key && showRememberButton == other.showRememberButton;
  }

  @override
  int get hashCode => key.hashCode ^ showRememberButton.hashCode;
}

/// generated route for
/// [BankCardView]
class BankCardRoute extends PageRouteInfo<void> {
  const BankCardRoute({List<PageRouteInfo>? children})
    : super(BankCardRoute.name, initialChildren: children);

  static const String name = 'BankCardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BankCardView();
    },
  );
}

/// generated route for
/// [EnterNumberView]
class EnterNumberRoute extends PageRouteInfo<void> {
  const EnterNumberRoute({List<PageRouteInfo>? children})
    : super(EnterNumberRoute.name, initialChildren: children);

  static const String name = 'EnterNumberRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EnterNumberView();
    },
  );
}

/// generated route for
/// [HistoryView]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HistoryView();
    },
  );
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeView();
    },
  );
}

/// generated route for
/// [LanguageView]
class LanguageRoute extends PageRouteInfo<void> {
  const LanguageRoute({List<PageRouteInfo>? children})
    : super(LanguageRoute.name, initialChildren: children);

  static const String name = 'LanguageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LanguageView();
    },
  );
}

/// generated route for
/// [OnboardingView]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardingView();
    },
  );
}

/// generated route for
/// [PinCodeView]
class PinCodeRoute extends PageRouteInfo<void> {
  const PinCodeRoute({List<PageRouteInfo>? children})
    : super(PinCodeRoute.name, initialChildren: children);

  static const String name = 'PinCodeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PinCodeView();
    },
  );
}

/// generated route for
/// [ProfileView]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileView();
    },
  );
}

/// generated route for
/// [QrScannerView]
class QrScannerRoute extends PageRouteInfo<void> {
  const QrScannerRoute({List<PageRouteInfo>? children})
    : super(QrScannerRoute.name, initialChildren: children);

  static const String name = 'QrScannerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const QrScannerView();
    },
  );
}

/// generated route for
/// [SecurityView]
class SecurityRoute extends PageRouteInfo<void> {
  const SecurityRoute({List<PageRouteInfo>? children})
    : super(SecurityRoute.name, initialChildren: children);

  static const String name = 'SecurityRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SecurityView();
    },
  );
}

/// generated route for
/// [SetPinCodeView]
class SetPinCodeRoute extends PageRouteInfo<void> {
  const SetPinCodeRoute({List<PageRouteInfo>? children})
    : super(SetPinCodeRoute.name, initialChildren: children);

  static const String name = 'SetPinCodeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SetPinCodeView();
    },
  );
}

/// generated route for
/// [UserInfoView]
class UserInfoRoute extends PageRouteInfo<void> {
  const UserInfoRoute({List<PageRouteInfo>? children})
    : super(UserInfoRoute.name, initialChildren: children);

  static const String name = 'UserInfoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserInfoView();
    },
  );
}

/// generated route for
/// [VerificationResultView]
class VerificationResultRoute extends PageRouteInfo<void> {
  const VerificationResultRoute({List<PageRouteInfo>? children})
    : super(VerificationResultRoute.name, initialChildren: children);

  static const String name = 'VerificationResultRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const VerificationResultView();
    },
  );
}

/// generated route for
/// [VerificationStepOneView]
class VerificationStepOneRoute extends PageRouteInfo<void> {
  const VerificationStepOneRoute({List<PageRouteInfo>? children})
    : super(VerificationStepOneRoute.name, initialChildren: children);

  static const String name = 'VerificationStepOneRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const VerificationStepOneView();
    },
  );
}

/// generated route for
/// [VerificationStepThreeView]
class VerificationStepThreeRoute extends PageRouteInfo<void> {
  const VerificationStepThreeRoute({List<PageRouteInfo>? children})
    : super(VerificationStepThreeRoute.name, initialChildren: children);

  static const String name = 'VerificationStepThreeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const VerificationStepThreeView();
    },
  );
}

/// generated route for
/// [VerificationStepTwoView]
class VerificationStepTwoRoute extends PageRouteInfo<void> {
  const VerificationStepTwoRoute({List<PageRouteInfo>? children})
    : super(VerificationStepTwoRoute.name, initialChildren: children);

  static const String name = 'VerificationStepTwoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const VerificationStepTwoView();
    },
  );
}
