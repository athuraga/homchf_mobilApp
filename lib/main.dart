import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:homchf/model/cartmodel.dart';
import 'package:homchf/screens/splash_screen.dart';
import 'package:homchf/utils/SharedPreferenceUtil.dart';
import 'package:homchf/utils/constants.dart';
import 'package:homchf/utils/localization/localizations_delegate.dart';
import 'package:homchf/utils/preference_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';
import 'utils/localization/locale_constant.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'constantsonesignal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceUtil.getInstance();
  runApp(MyApp(
    model: CartModel(),
  ));
}

class MyApp extends StatefulWidget {
  final CartModel model;

  const MyApp({Key? key, required this.model}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    configOneSignel();
  }

  void configOneSignel() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared.setAppId(
        oneSignalAppId); //this ‘oneSignalAppId’ is imported from constantsonesignal.dart file
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
  }

  @override
  Widget build(BuildContext context) {
    PreferenceUtils.init();
    return RefreshConfiguration(
      footerTriggerDistance: 15,
      dragSpeedRatio: 0.91,
      headerBuilder: () => MaterialClassicHeader(),
      footerBuilder: () => ClassicFooter(),
      enableLoadingWhenNoData: true,
      enableRefreshVibrate: false,
      enableLoadMoreVibrate: false,
      child: ScopedModel<CartModel>(
        model: widget.model,
        child: MaterialApp(
          locale: _locale,
          supportedLocales: [
            Locale('en', ''),
            Locale('es', ''),
            Locale('ar', ''),
          ],
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Color(Constants.colorBackground),
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(secondary: Color(Constants.colorTheme)),
              appBarTheme: AppBarTheme(
                  backgroundColor: Color(Constants.colorAppbar),
                  // foregroundColor: Color(Constants.colorAppbarback),
                  iconTheme: IconThemeData(
                    color: Color(Constants.colorAppbarback),
                  ),
                  actionsIconTheme: IconThemeData(
                    color: Color(Constants.colorAppbarback),
                  ),
                  titleTextStyle: TextStyle(
                    color: Color(Constants.colorAppbarback),
                  ),
                  toolbarTextStyle: TextStyle(
                    color: Color(Constants.colorAppbarback),
                  ),
                  textTheme: TextTheme(
                      // center text style
                      headline6: TextStyle(color: Colors.white),
                      // Side text style
                      bodyText2: TextStyle(color: Colors.white)))),
          home: SplashScreen(
            model: widget.model,
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
