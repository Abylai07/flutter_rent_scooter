import 'package:almabike_app/core/presentation/utils/navigation/route_config.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/utils/constants/bike_constants.dart';
import 'package:flutter/material.dart';

class AlmabikeApp extends StatefulWidget {
  const AlmabikeApp({super.key});

  @override
  State<AlmabikeApp> createState() => _AlmabikeAppState();
}

class _AlmabikeAppState extends State<AlmabikeApp> {
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BikeApp(
      appTitle: BikeConstants.almabikeTitle,
      routerConfig: appRouter.config(),
    );
  }
}
