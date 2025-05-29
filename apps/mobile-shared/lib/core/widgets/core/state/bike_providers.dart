import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/utils/networking/https/rest_client.dart';
import 'package:almabike_shared/core/widgets/core/map/bloc/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class BikeProviders extends StatelessWidget {
  const BikeProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeUtil.instance),
        ChangeNotifierProvider(create: (context) => LocalizationUtil.instance),
        RepositoryProvider<DeviceRestClient>(
          create: (BuildContext context) => RestClient().device,
        ),
        RepositoryProvider<AuthRestClient>(
          create: (BuildContext context) => RestClient().auth,
        ),
        BlocProvider<MapBloc>(
          create: (BuildContext context) => MapBloc(
            restClient: RestClient().device,
          ),
        ),

      ],
      child: child,
    );
  }
}
