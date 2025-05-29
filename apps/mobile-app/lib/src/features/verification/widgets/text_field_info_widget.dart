import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/widgets/core/bike_container.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:flutter/cupertino.dart';

class TextFieldInfoWidget extends StatelessWidget {
  const TextFieldInfoWidget({
    super.key,
    required this.label,
    required this.text,
  });
  final String label;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BikeText(
          label,
          style: BikeTypography.body.small.copyWith(
            color: context.theme.whenByValue(
              light: BikeColors.text.light.secondary,
              dark: BikeColors.text.dark.secondary,
            ),
          ),
        ),
        BikeContainer(
          withBorder: true,
          margin: const EdgeInsets.only(bottom: 16, top: 8),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          borderRadius: BikeBorderRadiuses.radius16,
          child: Align(
            alignment: Alignment.centerLeft,
            child: BikeText(
              text ?? '',
              style: BikeTypography.body.large,
            ),
          ),
        ),
      ],
    );
  }
}
