import 'package:almabike_app/src/features/qr_scanner/widgets/scanner_widget.dart';
import 'package:almabike_shared/core/style/tokens/bike_icons.dart';
import 'package:almabike_shared/core/widgets/core/bike_button.dart';
import 'package:almabike_shared/core/widgets/core/bike_icon_button.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

@RoutePage()
class QrScannerView extends StatefulWidget {
  const QrScannerView({super.key});

  @override
  State<StatefulWidget> createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  final MobileScannerController controller = MobileScannerController();
  bool isPopUpCalled = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.stop();
      controller.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 200,
      height: 200,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _buildQrView(context, scanWindow),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    BikeIconButton(
                      size: const BikeIconButtonSizeL(),
                      onPressed: () => context.router.maybePop(),
                      icon: BikeIcons.arrow_left,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: BikeButton(
                          size: const BikeButtonSizeM(),
                          onPressed: (){},
                          title: 'Ввести номер вручную',
                        ),
                      ),
                    ),
                    BikeIconButton(
                      size: const BikeIconButtonSizeL(),
                      onPressed: () => context.router.maybePop(),
                      icon: BikeIcons.sun,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context, scan) {
    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          onDetect: (capture) async {
            final List<Barcode> barcodes = capture.barcodes;
            if (!isPopUpCalled && barcodes.isNotEmpty) {
              try {
                String? rawValue = barcodes.first.rawValue;
                isPopUpCalled = true;
              } catch (e) {
                isPopUpCalled = true;
              }
            }
          },
        ),
        const QRScannerOverlay(),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
