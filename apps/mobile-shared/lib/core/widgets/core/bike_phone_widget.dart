import 'package:almabike_shared/core/widgets/core/bike_text_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class BikePhoneWidget extends StatelessWidget {
  BikePhoneWidget({super.key});

  final mask = MaskTextInputFormatter(
    mask: '(###) ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return BikeTextField(
      title: 'Номер телефона',
      hintText: '(000) 000 00 00',
      prefixText: '+7 ',
      inputFormatters: [mask],
      keyboardType: TextInputType.phone,
    );
  }
}
