import 'package:flutter/material.dart';
import 'package:free_notes_mobile/routes.dart';
import 'package:free_notes_mobile/screens/SplashScreen.dart';
import 'constants/Colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Free - Notes',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            actionsIconTheme: IconThemeData(color: notesIconColor)),
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: secondaryBgColor,
        ),
      ),
      initialRoute: SplashScreen.routeName,
      routes: routes,
      // home: const Wrapper(),
    );
  }
}
