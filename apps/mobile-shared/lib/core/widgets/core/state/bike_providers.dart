import 'package:almabike_shared/core/style/theme/theme_util.dart';
import 'package:almabike_shared/core/utils/l10n/utils/l10n_util.dart';
import 'package:almabike_shared/core/utils/networking/https/clients/i_rest_client.dart';
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
        RepositoryProvider<IRestClient>(
          create: (BuildContext context) => RestClient().app,
        ),
        BlocProvider<MapBloc>(
          create: (BuildContext context) => MapBloc(
            restClient: RestClient().app,
          ),
        ),
      ],
      child: child,
    );
  }
}
