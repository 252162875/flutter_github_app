import 'package:flutter/material.dart';
import 'package:flutter_github_app/common/Global.dart';
import 'package:flutter_github_app/i10n/localization_intl.dart';
import 'package:flutter_github_app/routes/HomeRoute.dart';
import 'package:flutter_github_app/routes/LoginRoute.dart';
import 'package:flutter_github_app/states/ProfileChangeNotifier.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'routes/LanguageRoute.dart';
import 'routes/ThemeRoute.dart';

void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(builder:
          (BuildContext context, themeModel, localeModel, Widget child) {
        return MaterialApp(
          theme: ThemeData(primarySwatch: themeModel.theme),
          onGenerateTitle: (context) {
            return GmLocalizations.of(context).title;
          },
          home: HomeRoute(),
          locale: localeModel.getLocale(),
          supportedLocales: [
            const Locale("en", "US"),
            const Locale("zh", "CN")
          ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GmLocalizationsDelegate()
          ],
          localeResolutionCallback:
              (Locale _locale, Iterable<Locale> supportedLocales) {
            if (localeModel.getLocale() != null) {
              return localeModel.getLocale();
            } else {
              Locale locale;
              if (supportedLocales.contains(_locale)) {
                locale = _locale;
              } else {
                locale = Locale("en", "US");
              }
              return locale;
            }
          },
          routes: <String, WidgetBuilder>{
            "login": (context) => LoginRoute(),
            "themes": (context) => ThemeRoute(),
            "language": (context) => LanguageRoute(),
          },
        );
      }),
    );
  }
}
