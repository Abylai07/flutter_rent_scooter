import 'package:almabike_shared/core/widgets/core/bike_text_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class BikePhoneWidget extends StatefulWidget {
  const BikePhoneWidget({
    super.key,
    this.controller,
    this.onBuild,
    this.errorText,
  });

  final void Function(MaskTextInputFormatter maskFormatter)? onBuild;
  final TextEditingController? controller;
  final String? errorText;

  @override
  State<BikePhoneWidget> createState() => _BikePhoneWidgetState();
}

class _BikePhoneWidgetState extends State<BikePhoneWidget> {
  @override
  void initState() {
    widget.onBuild?.call(mask);
    super.initState();
  }

  final mask = MaskTextInputFormatter(
    mask: '(###) ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return BikeTextField(
      controller: widget.controller,
      title: 'Номер телефона',
      hintText: '(000) 000 00 00',
      prefixText: '+7 ',
      inputFormatters: [mask],
      keyboardType: TextInputType.phone,
      errorText: widget.errorText,
    );
  }
}
