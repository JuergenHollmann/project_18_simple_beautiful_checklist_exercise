import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';
import 'package:simple_beautiful_checklist_exercise/shared/shared_preferences_repository.dart';

import 'features/splash/splash_screen.dart';
import 'home_screen.dart';

void main() async {
  // Wird benötigt, um auf SharedPreferences zuzugreifen
  WidgetsFlutterBinding.ensureInitialized();

  // √ todo:   Hier statt MockDatabase() ein SharedPreferencesRepository() verwenden.
  // √ vorher: final DatabaseRepository repository = MockDatabase();
  final DatabaseRepository repository = SharedPreferencesRepository();

  runApp(MainApp(repository: repository));
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.repository,
  });

  final DatabaseRepository repository;

  @override
  Widget build(BuildContext context) {
    /*--------------------------------- geändert wegen Bug in iOS ---*/
    /* MUSS noch im LightMode bei den Schriftfarben angepasst werden */
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: GoogleFonts.robotoMonoTextTheme(
          ThemeData.light().textTheme,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.robotoMonoTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
      ),
      /* MUSS noch im LightMode bei den Schriftfarben angepasst werden,
         deshalb ist noch temporär umgestellt von "ThemeMode.system" auf "ThemeMode.dark" */
      // themeMode: ThemeMode.system, // TODO: Bugfix DarkMode
      themeMode: ThemeMode.dark,
      title: 'Checklisten App',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => HomeScreen(
              repository: repository,
            ),
      },
    );
    /*--------------------------------- alter Original-Code ---*/
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     brightness: Brightness.light,
    //     textTheme: GoogleFonts.robotoMonoTextTheme(Theme.of(context).textTheme),
    //   ),
    //   darkTheme: ThemeData(
    //     brightness: Brightness.dark,
    //     textTheme: GoogleFonts.robotoMonoTextTheme(
    //       ThemeData(brightness: Brightness.dark).textTheme,
    //     ),
    //   ),
    //   themeMode: ThemeMode.system,
    //   title: 'Checklisten App',
    //   initialRoute: '/',
    //   routes: {
    //     '/': (context) => const SplashScreen(),
    //     '/home': (context) => HomeScreen(
    //           repository: repository,
    //         ),
    //   },
    // );
    /*--------------------------------- *** ---*/
  }
}
