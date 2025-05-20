import 'package:almabike_app/src/core/utils/app_storage.dart';
import 'package:almabike_app/src/core/utils/navigation/route_config.gr.dart';
import 'package:almabike_app/src/core/utils/services/locale_auth_service.dart';
import 'package:almabike_app/src/features/pin_code/widgets/show_biometric_alert.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/widgets/core/error_snack_bar.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import 'bloc/pin_code_bloc.dart';

@RoutePage()
class SetPinCodeView extends StatelessWidget {
  const SetPinCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PinCodeBloc(),
      child: const _SetPinCodeViewContent(),
    );
  }
}

class _SetPinCodeViewContent extends StatelessWidget {
  const _SetPinCodeViewContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinCodeBloc, PinCodeState>(
      listener: (context, state) {
        if (state.isPinComplete &&
            state.currentStep == PinEntryStep.confirmation &&
            state.enteredPin == state.firstPin &&
            !state.isProcessing) {
          _handleSuccessfulPinSetup(context, state.firstPin);
        }
      },
      builder: (context, state) {
        return BikeScaffold(
          appBar: BikeAppBar(
            title: Localization.of(context).setPasscode,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 80),

                // Title text - changes based on current step
                Text(
                  state.currentStep == PinEntryStep.initial
                      ? Localization.of(context).enterPasscode
                      : Localization.of(context).repeatPasscode,
                  style: BikeTypography.headline.large,
                ),

                const SizedBox(height: 54),

                // PIN code dots
                _buildPinDots(context, state),

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

  Widget _buildPinDots(BuildContext context, PinCodeState state) {
    return Column(
      children: [
        if (state.currentStep == PinEntryStep.confirmation) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Row(
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
                        : BikeColors.main.light.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
        Row(
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
        ),
      ],
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
          _buildKeypadRow(['face_id', '0', 'delete'], context),
          const SizedBox(height: 86),
        ],
      ),
    );
  }

  Widget _buildKeypadRow(List<String> keys, BuildContext context) {
    final bloc = context.read<PinCodeBloc>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: keys.map((key) {
        if (key == 'face_id') {
          return const SizedBox(width: 50);
        } else if (key == 'delete') {
          return IconButton(
            padding: const EdgeInsets.all(12),
            onPressed: () => bloc.add(DigitRemoved()),
            icon: Assets.icons.delete.svg(
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                  context.theme.whenByValue(
                      light: BikeColors.icon.light.black,
                      dark: BikeColors.icon.dark.white),
                  BlendMode.srcIn),
            ),
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

  void _handleSuccessfulPinSetup(BuildContext context, String firstPin) async {
    final hasFaceId = (await LocalAuthService.getAvailableBiometrics())
        .contains(BiometricType.face);
    await showBiometricDialog(
      context: context,
      text: hasFaceId
          ? Localization.of(context).enableFaceId
          : Localization.of(context).enableTouchId,
      icon: hasFaceId ? Assets.icons.faceId : Assets.icons.touchId,
      onConfirm: () async {
          context.router.replaceAll([const PinCodeRoute()]);

        // final authed = await LocalAuthService.authenticateWithBiometrics(
        //   Localization.of(context).biometricPrompt,
        // );
        // if (authed) {
        //   AppStorage.authByBiometrics = true;
        //   LocalAuthService.writeCode(firstPin);
        //
        //   context.router.replaceAll([PinCodeRoute()]);
        // } else {
        //   showErrorSnackBar(context, Localization.of(context).error);
        // }
      },
      onCancel: () {
        context.router.maybePop();
        // LocalAuthService.cancelAuthentication();
        // context.router.replace(const HomeRoute());
      },
    );
  }
}
