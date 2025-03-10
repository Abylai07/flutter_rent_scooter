import 'package:almabike_admin/core/presentation/utils/navigation/route_config.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/utils/constants/bike_constants.dart';
import 'package:flutter/material.dart';

class ToirApp extends StatefulWidget {
  const ToirApp({super.key});

  @override
  State<ToirApp> createState() => _ToirAppState();
}

class _ToirAppState extends State<ToirApp> {
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BikeApp(
      appTitle: BikeConstants.almabikeAdminTitle,
      routerConfig: appRouter.config(),
    );
  }
}
