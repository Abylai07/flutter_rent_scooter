import 'package:almabike_app/src/core/utils/navigation/route_config.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/widgets/core/bike_container.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';

import '../../../core/utils/services/locale_auth_service.dart';

@RoutePage()
class SecurityView extends StatelessWidget {
  const SecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    return BikeScaffold(
      appBar: BikeAppBar(title: Localization.of(context).security),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder(
                future: LocalAuthService.getAvailableBiometrics(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  }
                  final hasFaceId =
                      snapshot.data?.contains(BiometricType.face) ?? false;
                  return buildBikeContainer(
                    context,
                    child: Row(
                      children: [
                        BikeCircleIconWidget(
                          icon: hasFaceId
                              ? Assets.icons.faceId
                              : Assets.icons.touchId,
                        ),
                        BikeText(
                          hasFaceId
                              ? Localization.of(context).faceIdLogin
                              : Localization.of(context).touchIdLogin,
                          style: BikeTypography.title.small,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 38,
                          height: 24,
                          child: CupertinoSwitch(
                            value: true,
                            activeTrackColor: BikeColors.main.light.primary,
                            onChanged: (val) {},
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            GestureDetector(
              onTap: (){
                context.router.push(const SetPinCodeRoute());
              },
              child: buildBikeContainer(
                context,
                child: Row(
                  children: [
                    BikeCircleIconWidget(
                      icon: Assets.icons.setCode,
                    ),
                    BikeText(
                      Localization.of(context).passcodeLogin,
                      style: BikeTypography.title.small,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 38,
                      height: 24,
                      child: CupertinoSwitch(
                        value: true,
                        activeTrackColor: BikeColors.main.light.primary,
                        onChanged: (val) {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            buildBikeContainer(
              context,
              child: Row(
                children: [
                  BikeCircleIconWidget(
                    icon: Assets.icons.redact,
                  ),
                  BikeText(
                    Localization.of(context).changePasscode,
                    style: BikeTypography.title.small,
                  ),
                  const Spacer(),
                  Assets.icons.arrowRight.svg(
                    height: 12,
                  ),
                ],
              ),
            ),
            buildBikeContainer(
              context,
              child: Row(
                children: [
                  BikeCircleIconWidget(
                    child: Icon(
                      BikeIcons.phone,
                      color: BikeColors.icon.light.green,
                      size: 18,
                    ),
                  ),
                  BikeText(
                    Localization.of(context).changePhoneNumber,
                    style: BikeTypography.title.small,
                  ),
                  const Spacer(),
                  Assets.icons.arrowRight.svg(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BikeContainer buildBikeContainer(BuildContext context,
      {required Widget child}) {
    return BikeContainer(
        color: context.theme.whenByValue(
          light: BikeColors.background.light.lightGray,
          dark: BikeColors.background.dark.lightGray,
        ),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        borderRadius: BikeBorderRadiuses.radius16,
        child: child);
  }
}
