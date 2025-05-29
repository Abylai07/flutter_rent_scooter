import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/utils/l10n/generated/l10n.dart';
import 'package:almabike_shared/core/widgets/core/bike_container.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BikeScaffold(
      appBar: BikeAppBar(title: Localization.of(context).languageTitle),
      body: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: AppLocalizations.delegate.supportedLocales.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, i) {
                final item = AppLocalizations.delegate.supportedLocales[i];
                return GestureDetector(
                  onTap: (){
                    context.read<LocalizationUtil>().set(locale: item);
                  },
                  child: BikeContainer(
                    color: context.theme.whenByValue(
                      light: BikeColors.background.light.lightGray,
                      dark: BikeColors.background.dark.lightGray,
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                    padding:
                        const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                    borderRadius: BikeBorderRadiuses.radius16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BikeText(
                          item.languageCode == 'kk'
                              ? 'Қазақша'
                              : item.languageCode == 'ru'
                                  ? 'Русский'
                                  : 'English',
                        ),
                        BikeCheckbox(
                          value: item.languageCode == AppStorage.locale,
                          onChanged: (val){
                            context.read<LocalizationUtil>().set(locale: item);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
