import 'package:almabike_app/core/presentation/utils/navigation/route_config.gr.dart';
import 'package:almabike_app/core/presentation/views/auth/bloc/auth_bloc.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/utils/networking/https/clients/i_rest_client.dart';
import 'package:almabike_shared/core/widgets/core/bike_button.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

@RoutePage()
class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  late final TextEditingController controller;
  late MaskTextInputFormatter mask;

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(restClient: context.read<IRestClient>()),
      child: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          state.whenOrNull(success: (phone) {
            AutoRouter.of(context).push(AuthVerificationRoute(phone: phone));
          });
        },
        builder: (context, state) {
          return BikeScaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            context.read<ThemeUtil>().changeTheme();
                          },
                          borderRadius: BikeBorderRadiuses.radius16,
                          child: Container(
                            height: 32,
                            width: 94,
                            decoration: BoxDecoration(
                              color: context.theme.whenByValue(
                                light: BikeColors.background.dark.element,
                                dark: BikeColors.background.light.element,
                              ),
                              borderRadius: BikeBorderRadiuses.radius16,
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BikeBorderRadiuses.radius16,
                          onTap: () {
                            final localization =
                                context.read<LocalizationUtil>();

                            final localeEn = localization.supportedLocales[0];
                            final localeRu = localization.supportedLocales[2];

                            final locale = localization.locale;
                            if (locale == localeEn) {
                              localization.setRu();
                            } else if (locale == localeRu) {
                              localization.setKk();
                            } else {
                              localization.setEn();
                            }
                          },
                          child: Container(
                            height: 32,
                            width: 94,
                            decoration: BoxDecoration(
                              color: context.theme.whenByValue(
                                light: BikeColors.background.light.element,
                                dark: BikeColors.background.dark.element,
                              ),
                              borderRadius: BikeBorderRadiuses.radius16,
                            ),
                            child: Center(
                              child: BikeText(
                                Localization.of(context).language,
                                style: BikeTypography.body.medium.copyWith(
                                  color: context.theme.whenByValue(
                                    light: BikeColors.text.light.primary,
                                    dark: BikeColors.text.dark.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    AspectRatio(
                      aspectRatio: 328 / 24,
                      child: Assets.logos.logo.svg(),
                    ),
                    SizedBox(height: 40),
                    BikeText(
                      Localization.of(context).enter_phone_number,
                      style: BikeTypography.headline.large.copyWith(
                        color: context.theme.whenByValue(
                          light: BikeColors.text.light.primary,
                          dark: BikeColors.text.dark.primary,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    BikePhoneWidget(
                      controller: controller,
                      onBuild: (maskFormatter) {
                        mask = maskFormatter;
                      },
                      errorText: state.whenOrNull(
                        error: () => Localization.of(context).incorrect_phone,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: BikeButton(
                  title: Localization.of(context).get_code,
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          AuthBlocEvent.auth(
                            phone: mask.unmaskText(controller.text),
                          ),
                        );
                    controller.clear();
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
