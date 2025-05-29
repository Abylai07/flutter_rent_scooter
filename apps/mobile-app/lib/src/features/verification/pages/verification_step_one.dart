import 'package:almabike_app/src/core/utils/navigation/route_config.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/widgets/core/bike_button.dart';
import 'package:almabike_shared/core/widgets/core/bike_container.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/verigram/verigram_cubit.dart';

@RoutePage()
class VerificationStepOneView extends StatelessWidget {
  const VerificationStepOneView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return BikeScaffold(
      appBar: BikeAppBar(
        title: Localization.of(context).verification,
        subTitle: Localization.of(context).step_num_of_3(1),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BikeButton(
            title: Localization.of(context).next,
            onPressed: () {
              context.pushRoute(const VerificationStepTwoRoute());
            },
          ),
        ),
      ),
      body: BlocBuilder<VerificationCubit, VerificationState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BikeText(
                  Localization.of(context).enter_data,
                  style: BikeTypography.title.medium,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BikeBorderRadiuses.radius20,
                    border: Border.all(
                      width: 1,
                      color: context.theme.whenByValue(
                        light: BikeColors.background.light.grey,
                        dark: BikeColors.background.dark.grey,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BikeText(
                        Localization.of(context).not_resident,
                        style: BikeTypography.body.large,
                      ),
                      SizedBox(
                        width: 38,
                        height: 24,
                        child: CupertinoSwitch(
                          value: !state.isCitizen,
                          activeTrackColor: BikeColors.main.light.primary,
                          onChanged: (val) {
                            context
                                .read<VerificationCubit>()
                                .selectCitizen(!val);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                state.isCitizen
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BikeText(
                            Localization.of(context).six_digit_code,
                            style: BikeTypography.body.small.copyWith(
                              color: context.theme.whenByValue(
                                light: BikeColors.text.light.secondary,
                                dark: BikeColors.text.dark.secondary,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 16),
                            child: BikeTextField(
                              controller: controller,
                              hintText: '012 123',
                            ),
                          ),
                          BikeContainer(
                            color: context.theme.whenByValue(
                              light: BikeColors.background.light.lightGray,
                              dark: BikeColors.background.light.lightGray,
                            ),
                            borderRadius: BikeBorderRadiuses.radius16,
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                BikeContainer(
                                    color: context.theme.whenByValue(
                                      light: BikeColors.background.light.grey,
                                      dark: BikeColors.background.light.grey,
                                    ),
                                    shape: BoxShape.circle,
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.only(right: 12),
                                    child: Assets.icons.attention.svg(
                                      height: 16,
                                      colorFilter: ColorFilter.mode(
                                        BikeColors.main.light.primary,
                                        BlendMode.srcIn,
                                      ),
                                    )),
                                Expanded(
                                  child: BikeText(
                                    Localization.of(context).instructions,
                                    style: BikeTypography.body.medium,
                                    maxLines: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: BikeTextField(
                              title: Localization.of(context).full_name,
                              hintText: Localization.of(context).full_name,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: BikeTextField(
                              title: Localization.of(context).birth_date,
                              hintText: Localization.of(context).birth_date,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
