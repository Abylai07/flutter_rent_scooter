import 'package:almabike_app/src/core/utils/navigation/route_config.dart';
import 'package:almabike_app/src/features/auth/bloc/auth_bloc.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/utils/l10n/generated/l10n.dart';
import 'package:almabike_shared/core/widgets/core/bike_button.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

@RoutePage()
class AuthView extends StatefulWidget {
  const AuthView({super.key, this.showRememberButton = false});

  final bool showRememberButton;

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
      create: (context) => AuthBloc(restClient: context.read<AuthRestClient>()),
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
                        SizedBox(
                          key: ValueKey(AppStorage.locale),
                          height: 34,
                          width: 110,
                          child: Transform.translate(
                            offset: const Offset(0, -8),
                            child: CustomDropdown<Locale>(
                              excludeSelected: false,
                              hideSelectedFieldWhenExpanded: true,
                              closedHeaderPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              items: AppLocalizations.delegate.supportedLocales,
                              decoration: CustomDropdownDecoration(
                                closedSuffixIcon: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Icon(
                                    BikeIcons.arrow_down,
                                    size: 12,
                                    color: context.theme.whenByValue(
                                        light: BikeColors.text.light.secondary,
                                        dark: BikeColors.text.dark.secondary),
                                  ),
                                ),
                                closedFillColor: context.theme.whenByValue(
                                  light: BikeColors.background.light.element,
                                  dark: BikeColors.background.dark.element,
                                ),
                                listItemDecoration: ListItemDecoration(
                                  selectedColor: context.theme.whenByValue(
                                    light: BikeColors.background.light.grey,
                                    dark: BikeColors
                                        .background.dark.buttonSecondary,
                                  ),
                                ),
                                expandedFillColor: context.theme.whenByValue(
                                  light: BikeColors.background.light.element,
                                  dark: BikeColors.background.dark.element,
                                ),
                                closedBorderRadius: BikeBorderRadiuses.radius16,
                              ),
                              initialItem: Locale(AppStorage.locale),
                              onChanged: (value) {
                                final localization =
                                    context.read<LocalizationUtil>();
                                final locale = value ?? localization.locale;
                                localization.set(locale: locale);
                              },
                              listItemBuilder: (context, item, show, func) {
                                return Text(
                                  item.languageCode == 'kk'
                                      ? 'Қазақша'
                                      : item.languageCode == 'ru'
                                          ? 'Русский'
                                          : 'English',
                                  style: BikeTypography.body.medium.copyWith(
                                    color: context.theme.whenByValue(
                                      light: BikeColors.text.light.primary,
                                      dark: BikeColors.text.dark.primary,
                                    ),
                                  ),
                                );
                              },
                              headerBuilder: (context, item, show) {
                                return Text(
                                  Localization.of(context).language,
                                  style: BikeTypography.body.medium.copyWith(
                                      color: context.theme.whenByValue(
                                    light: BikeColors.text.light.secondary,
                                    dark: BikeColors.text.dark.secondary,
                                  )),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    AspectRatio(
                      aspectRatio: 328 / 24,
                      child: Assets.logos.logo.svg(),
                    ),
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BikeText(
                        Localization.of(context).enter_phone_number,
                        style: BikeTypography.headline.large.copyWith(
                          color: context.theme.whenByValue(
                            light: BikeColors.text.light.primary,
                            dark: BikeColors.text.dark.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BikeButton(
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
                    if (widget.showRememberButton) ...[
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => context.router.maybePop(),
                        child: Text(
                          Localization.of(context).rememberedCode,
                          style: BikeTypography.body.large,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
