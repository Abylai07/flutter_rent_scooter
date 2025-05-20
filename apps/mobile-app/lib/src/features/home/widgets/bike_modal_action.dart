import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/widgets/core/bike_container.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:flutter/material.dart';

class BikeModalActionWidget extends StatelessWidget {
  final String title;
  final String description;
  const BikeModalActionWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BikeContainer(
      height: 92,
      width: size.width / 4,
      borderRadius: BikeBorderRadiuses.radius24,
      withBorder: true,
      withShadow: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BikeText(
            title,
            style: BikeTypography.title.small.copyWith(
              color: context.theme.whenByValue(
                light: BikeColors.text.light.primary,
                dark: BikeColors.text.dark.primary,
              ),
            ),
          ),
          BikeText(
            description,
            style: BikeTypography.body.small.copyWith(
              color: context.theme.whenByValue(
                light: BikeColors.text.light.secondary,
                dark: BikeColors.text.dark.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}