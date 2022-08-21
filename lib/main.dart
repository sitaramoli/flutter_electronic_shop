import 'package:electronic_shop/app/constants/spacing_constants.dart';
import 'package:electronic_shop/routing/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dependency_injection.dart' as di;
import 'features/authentication/presentation/login/login_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const ElectronicApp()));
}

class ElectronicApp extends StatelessWidget {
  const ElectronicApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
            create: (_) => di.instance<LoginViewModel>()),
      ],
      child: MaterialApp(
        title: 'Electronic Shop',
        debugShowCheckedModeBanner: false,
        theme: _themeData,
        initialRoute: Routes.splashRoute,
        onGenerateRoute: (settings) => RouteGenerator.getRoute(settings),
      ),
    );
  }
}

//theme data
final _themeData = ThemeData(
  primaryColor: const Color(0xfff5603b),
  scaffoldBackgroundColor: const Color(0xffdbdad7),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: const Color(0xfff5603b),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFE7E2E2),
    iconColor: Color(0xfff5603b),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(SpacingConstants.s20)),
    ),
  ),
  fontFamily: 'Questrial',
  iconTheme: const IconThemeData(),
  textTheme: const TextTheme(
    headline1:
        TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: Colors.red),
    headline2: TextStyle(
        fontSize: 60, fontWeight: FontWeight.bold, color: Colors.blue),
    headline3: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
    headline4: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
    headline5: TextStyle(
        fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
    headline6: TextStyle(
        fontSize: 25, fontWeight: FontWeight.bold, color: Color(0xfff5603b)),
    subtitle1: TextStyle(fontSize: 17),
    subtitle2: TextStyle(fontSize: 15),
    button: TextStyle(fontSize: 17, color: Color(0xFFE7E2E2)),
  ),
);
