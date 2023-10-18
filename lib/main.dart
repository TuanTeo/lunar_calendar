import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lunar_calendar/router.dart' as router;
import 'pages/home_screen.dart';
import 'pages/setting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      /* Todo Cấu hình theme sáng tối theo system */
      // theme: CalendarThemeData.lightThemeData,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('vi') // Vietnamese
      ],
      initialRoute: '/',
      routes: {
        router.defaultRoute: (context) => const HomeScreen(),
        router.settingScreen: (context) => const SettingScreen()
      },
    );
  }
}
