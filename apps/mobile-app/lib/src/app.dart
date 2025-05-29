import 'package:almabike_app/src/core/utils/navigation/route_config.dart';
import 'package:almabike_app/src/features/verification/bloc/verigram/verigram_cubit.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/utils/constants/bike_constants.dart';
import 'package:almabike_shared/core/utils/networking/https/rest_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlmabikeApp extends StatefulWidget {
  const AlmabikeApp({super.key});

  @override
  State<AlmabikeApp> createState() => _AlmabikeAppState();
}

class _AlmabikeAppState extends State<AlmabikeApp> {
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => VerificationCubit(RestClient().auth),
          ),
        ],
        child: BikeApp(
          appTitle: BikeConstants.almabikeTitle,
          routerConfig: appRouter.config(),
        ),
      ),
    );
  }
}
