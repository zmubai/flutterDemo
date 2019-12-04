import 'package:flutter/material.dart';
import 'package:github_client_app/common/Global.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
        providers: <SingleChildCloneableWidget>[
          ChangeNotifierProvider.value(value: ThemeModel()),
          ChangeNotifierProvider.value(value: UserModel()),
          ChangeNotifierProvider.value(value: LocalModel()),
        ],
        child: Consumer2<ThemeMode, LocalModel>(
          builder: (BuildContext context, themeModel, localModel, Widget child){
            return MaterialApp(
              theme: ThemeData(
                // primarySwatch: themeModel.theme,
              ),
              onGenerateTitle: (context){
                //return GmLocalizations.of(context).title;
                return "国际化名称";
              },
              home: HomeRoute(),
              locale: localModel.getLocal(),
              supportedLocales: [
                const Locale("en", "US"),
                const Locale("zh", "CN"),
              ],
              localizationsDelegates: [
                // GlobalMaterialLocalizations.delegate,
                // GlobalMaterialLocalizations.delegate,
                // GmLocalizationsDelegate()
              ],
              localeResolutionCallback: (Locale _locale, Iterable<Locale> supportedLocales){
                if (localModel.getLocal() != null) {
                  return localModel.getLocal();
                } else {
                  Locale locale;
                  if (supportedLocales.contains(_locale)) {
                    locale = _locale;
                  }
                  else{
                    locale = Locale("en","US");
                  }
                  return locale;
                }
              },
              routes: <String,WidgetBuilder>{
                // "login" (context) => LoginRoute(),
                // "themes" (context) => ThemeChangeRoute(),
                // "language" (context) => LanguageRoute(),
              },
            );
          },
        ),
    );
  }
}

class HomeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}