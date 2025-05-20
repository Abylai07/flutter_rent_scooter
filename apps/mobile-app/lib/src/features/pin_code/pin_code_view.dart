import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:almabike_shared/core/widgets/core/error_snack_bar.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../core/utils/app_storage.dart';
import '../../core/utils/navigation/route_config.gr.dart';
import '../../core/utils/services/locale_auth_service.dart';
import 'bloc/pin_code_bloc.dart';

@RoutePage()
class PinCodeView extends StatelessWidget {
  const PinCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PinCodeBloc(),
      child: const _PinCodeViewContent(),
    );
  }
}

class _PinCodeViewContent extends StatefulWidget {
  const _PinCodeViewContent();

  @override
  State<_PinCodeViewContent> createState() => _PinCodeViewContentState();
}

class _PinCodeViewContentState extends State<_PinCodeViewContent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authenticateWithBiometrics(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinCodeBloc, PinCodeState>(
      listener: (context, state) {
        if (state.isPinComplete && !state.isProcessing) {
          _verifyPin(context, state.enteredPin);
        }
      },
      builder: (context, state) {
        return BikeScaffold(
          appBar: BikeAppBar(
            title: Localization.of(context).authorization,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Assets.icons.enter.svg(height: 18),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 80),

                // Title text
                Text(
                  Localization.of(context).inputPasscode,
                  style: BikeTypography.headline.large,
                ),

                const SizedBox(height: 54),

                // PIN code dots
                _buildPinDots(state),

                const Spacer(),

                // Keypad
                _buildKeypad(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPinDots(PinCodeState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        state.pinLength,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: state.isError
                ? BikeColors.main.light.red
                : index < state.enteredPin.length
                    ? BikeColors.main.light.primary
                    : context.theme.whenByValue(
                        light: BikeColors.background.light.grey,
                        dark: BikeColors.background.dark.grey),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildKeypad(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 46.0),
      child: Column(
        children: [
          _buildKeypadRow(['1', '2', '3'], context),
          const SizedBox(height: 28),
          _buildKeypadRow(['4', '5', '6'], context),
          const SizedBox(height: 28),
          _buildKeypadRow(['7', '8', '9'], context),
          const SizedBox(height: 28),
          _buildKeypadRow(['biometric', '0', 'delete'], context),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () => context.router.push(AuthRoute(showRememberButton: true)),
            child: Text(
              Localization.of(context).forgotPasscode,
              style: BikeTypography.body.large,
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildKeypadRow(List<String> keys, BuildContext context) {
    final bloc = context.read<PinCodeBloc>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: keys.map((key) {
        if (key == 'biometric') {
          return FutureBuilder(
              future: LocalAuthService.getAvailableBiometrics(),
              builder: (context, snapshot) {
                final hasFaceId =
                    snapshot.data?.contains(BiometricType.face) ?? false;

                return IconButton(
                  padding: const EdgeInsets.all(12),
                  onPressed: () async {
                    await _authenticateWithBiometrics(context);
                  },
                  icon: hasFaceId
                      ? Assets.icons.faceId.svg(
                          height: 24,
                          width: 24,
                          colorFilter: ColorFilter.mode(
                              context.theme.whenByValue(
                                  light: BikeColors.icon.light.black,
                                  dark: BikeColors.icon.dark.white),
                              BlendMode.srcIn))
                      : Assets.icons.touchId.svg(
                          height: 24,
                          width: 24,
                          colorFilter: ColorFilter.mode(
                              context.theme.whenByValue(
                                  light: BikeColors.icon.light.black,
                                  dark: BikeColors.icon.dark.white),
                              BlendMode.srcIn)),
                );
              });
        } else if (key == 'delete') {
          return IconButton(
            padding: const EdgeInsets.all(12),
            onPressed: () => bloc.add(DigitRemoved()),
            icon: Assets.icons.delete.svg(height: 24, width: 24, colorFilter: ColorFilter.mode(
                context.theme.whenByValue(
                    light: BikeColors.icon.light.black,
                    dark: BikeColors.icon.dark.white),
                BlendMode.srcIn)),
          );
        } else {
          return IconButton(
            onPressed: () => bloc.add(DigitEntered(key)),
            padding: const EdgeInsets.all(12),
            icon: Text(
              key,
              style: BikeTypography.headline.large.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }
      }).toList(),
    );
  }

  Future<void> _verifyPin(BuildContext context, String enteredPin) async {
    final bloc = context.read<PinCodeBloc>();

    final isVerified = await LocalAuthService.verifyCode(enteredPin);

    if (isVerified) {
      context.router.replaceAll([const HomeRoute()]);
    } else {
      bloc.add(PinError());
    }
  }

  Future<void> _authenticateWithBiometrics(BuildContext context) async {
    final authed = await LocalAuthService.authenticateWithBiometrics(
      Localization.of(context).biometricPrompt,
    );

    if (authed) {
      context.router.replaceAll([const HomeRoute()]);
    }
  }
}
