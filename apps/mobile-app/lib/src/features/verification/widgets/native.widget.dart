import 'package:almabike_shared/almabike_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class NativeWidget extends StatelessWidget {
  final String personId;
  final String viewType;
  final String accessToken;

  const NativeWidget({
    super.key,
    required this.personId,
    required this.viewType,
    required this.accessToken,
  });

  Widget buildPlatformType() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return PlatformViewLink(
          viewType: viewType,
          surfaceFactory: (context, controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <Factory<
                  OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: (params) {
            return PlatformViewsService.initExpensiveAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              creationParams: {
                'access-token': accessToken,
                'person-id': personId,
                'language': AppStorage.locale,
              },
              creationParamsCodec: const StandardMessageCodec(),
              onFocus: () {
                params.onFocusChanged(true);
              },
            )
              ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
              ..create();
          },
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: {
            "access-token": accessToken,
            "person-id": personId,
            "language": AppStorage.locale,
          },
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        throw UnsupportedError('$defaultTargetPlatform is not supported!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildPlatformType());
  }
}
