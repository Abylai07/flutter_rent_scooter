import 'package:almabike_app/core/presentation/utils/navigation/route_config.gr.dart';
import 'package:almabike_app/core/presentation/views/auth_verification/bloc/auth_verification_bloc.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/utils/networking/https/clients/i_rest_client.dart';
import 'package:almabike_shared/core/widgets/core/bike_button.dart';
import 'package:almabike_shared/core/widgets/core/pincode_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AuthVerificationView extends StatefulWidget {
  const AuthVerificationView({super.key, required this.phone});
  final String phone;

  @override
  State<AuthVerificationView> createState() => _AuthVerificationViewState();
}

class _AuthVerificationViewState extends State<AuthVerificationView> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthVerificationBloc(
        restClient: context.read<IRestClient>(),
      ),
      child: BlocConsumer<AuthVerificationBloc, AuthVerificationBlocState>(
        listener: (context, state) {
          state.whenOrNull(
            success: () {
              AutoRouter.of(context).replace(const HomeRoute());
            },
          );
        },
        builder: (context, state) {
          return BikeScaffold(
            appBar: BikeAppBar(
              title: Localization.of(context).authorization,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: BikePincodeWidget(
                    title: Localization.of(context).enter_code_from_sms,
                    controller: controller,
                    errorText: state.whenOrNull(
                      error: (message) => message,
                    ),
                    onCompleted: (code) {
                      context.read<AuthVerificationBloc>().add(
                            AuthVerificationBlocEvent.verify(
                              phone: widget.phone,
                              code: code,
                            ),
                          );
                      controller.clear();
                    },
                  ),
                ),
                SizedBox.shrink()
              ],
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: BikeButton(
                  title: Localization.of(context).get_code,
                  onPressed: () {},
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
