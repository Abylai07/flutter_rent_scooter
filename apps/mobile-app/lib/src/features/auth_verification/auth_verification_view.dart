import 'package:almabike_app/src/core/utils/navigation/route_config.dart';
import 'package:almabike_app/src/features/auth_verification/bloc/auth_verification_bloc.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/widgets/core/bike_button.dart';
import 'package:almabike_shared/core/widgets/core/pincode_widget.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/services/locale_auth_service.dart';
import '../auth/bloc/auth_bloc.dart';
import '../pin_code/widgets/show_biometric_alert.dart';

@RoutePage()
class AuthVerificationView extends StatefulWidget {
  const AuthVerificationView({super.key, required this.phone});
  final String phone;

  @override
  State<AuthVerificationView> createState() => _AuthVerificationViewState();
}

class _AuthVerificationViewState extends State<AuthVerificationView> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _successCode() {
    showBiometricDialog(
      context: context,
      text: Localization.of(context).setPasscodeTitle,
      icon: Assets.icons.setCode,
      onConfirm: () async {
        if (await LocalAuthService.hasBiometrics()) {
          AutoRouter.of(context).replace(const SetPinCodeRoute());
        } else {
          AppStorage.authByBiometrics = false;
          context.router.replace(const HomeRoute());
        }
      },
      onCancel: () {
        AppStorage.authByBiometrics = false;
        context.router.replace(const VerificationStepOneRoute());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthVerificationBloc(
            restClient: context.read<AuthRestClient>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              AuthBloc(restClient: context.read<AuthRestClient>()),
        ),
      ],
      child: BlocConsumer<AuthVerificationBloc, AuthVerificationBlocState>(
        listener: (context, state) {
          state.whenOrNull(
            success: () {
              _successCode();
            },
          );
        },
        builder: (context, state) {
          return BikeScaffold(
            appBar: BikeAppBar(
              title: Localization.of(context).authorization,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: BikePincodeWidget(
                    title: Localization.of(context).enter_code_from_sms,
                    controller: controller,
                    errorText: state.whenOrNull(
                      error: (message) => message,
                    ),
                    onCompleted: (code) {
                      context.read<AuthVerificationBloc>().add(
                            AuthVerificationBlocEvent.verify(
                              phone: widget.phone,
                              code: code,
                            ),
                          );
                      controller.clear();
                    },
                  ),
                ),
                const SizedBox.shrink()
              ],
            ),
            bottomNavigationBar: BlocConsumer<AuthBloc, AuthBlocState>(
              listener: (context, state) {
                state.whenOrNull(error: () {
                  showSnackBar(context,
                      'PIN-код уже был отправлен. Пожалуйста, подождите перед повторной попыткой.');
                });
              },
              builder: (context, state) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: BikeButton(
                      title: Localization.of(context).get_code,
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              AuthBlocEvent.auth(
                                phone: widget.phone,
                              ),
                            );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
