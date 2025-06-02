import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/widgets/core/bike_button.dart';
import 'package:almabike_shared/core/widgets/core/bike_container.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/navigation/route_config.dart';
import '../bloc/verigram/verigram_cubit.dart';
import '../widgets/text_field_info_widget.dart';

@RoutePage()
class VerificationStepTwoView extends StatelessWidget {
  const VerificationStepTwoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BikeScaffold(
      appBar: BikeAppBar(
        title: Localization.of(context).verification,
        subTitle: Localization.of(context).step_num_of_3(2),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BikeButton(
            title: Localization.of(context).next,
            onPressed: () {
              context.pushRoute(const VerificationStepThreeRoute());
            },
          ),
        ),
      ),
      body: BlocBuilder<VerificationCubit, VerificationState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: state.isCitizen
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BikeText(
                          Localization.of(context).check_personal_data,
                          style: BikeTypography.title.medium,
                        ),
                        const SizedBox(height: 16),
                        TextFieldInfoWidget(
                          label: Localization.of(context).full_name,
                          text: 'Рахат Рахатов Рахатович',
                        ),
                        TextFieldInfoWidget(
                          label: Localization.of(context).iin,
                          text: '',
                        ),
                        TextFieldInfoWidget(
                          label: Localization.of(context).document_number,
                          text: '',
                        ),
                        TextFieldInfoWidget(
                          label: Localization.of(context).birth_date,
                          text: '',
                        ),
                        TextFieldInfoWidget(
                          label: Localization.of(context).birth_place,
                          text: '',
                        ),
                        TextFieldInfoWidget(
                          label: Localization.of(context).nationality,
                          text: '',
                        ),
                        TextFieldInfoWidget(
                          label: Localization.of(context).issuing_authority,
                          text: '',
                        ),
                        TextFieldInfoWidget(
                          label: Localization.of(context).issue_expiry_date,
                          text: '',
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BikeText(
                          Localization.of(context).upload_passport,
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
                          child: Column(
                            spacing: 8,
                            children: [
                              BikeButton(
                                title: Localization.of(context).take_photo,
                                onPressed: () {},
                                size: const BikeButtonSizeM(),
                              ),
                              BikeOutlineButton(
                                title:
                                    Localization.of(context).upload_from_phone,
                                onPressed: () {},
                                size: const BikeButtonSizeM(),
                              ),
                            ],
                          ),
                        ),
                        BikeContainer(
                            color: context.theme.whenByValue(
                              light: BikeColors.background.light.lightGray,
                              dark: BikeColors.background.darkgit.lightGray,
                            ),
                            borderRadius: BikeBorderRadiuses.radius16,
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                BikeContainer(
                                    color: context.theme.whenByValue(
                                      light: BikeColors.background.light.grey,
                                      dark: BikeColors.background.dark.grey,
                                    ),
                                    shape: BoxShape.circle,
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.only(right: 12),
                                    child: Icon(
                                      BikeIcons.sun,
                                      size: 16,
                                      color: context.theme.whenByValue(
                                        light: BikeColors.icon.light.black,
                                        dark: BikeColors.icon.dark.white,
                                      ),
                                    )),
                                Expanded(
                                  child: BikeText(
                                    Localization.of(context).photo_quality_requirement,
                                    style: BikeTypography.body.medium,
                                    maxLines: 10,
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
