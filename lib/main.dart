import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lunar_calendar/router.dart' as router;
import 'package:lunar_calendar/services/notification/notification_service.dart';
import 'pages/home_screen.dart';
import 'pages/setting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  await NotificationService().configureLocalTimeZone();
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
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Color(0xFFB93C5D),
          primaryContainer: Color(0xFF117378),
          secondary: Color(0xFFEFF3F3),
          secondaryContainer: Color(0xFFFAFBFB),
          background: Color(0xFFE6EBEB),
          surface: Color(0xFFFAFBFB),
          onBackground: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Color(0xFF322942),
          onSurface: Color(0xFF241E30),
          brightness: Brightness.light,
          error: Colors.redAccent,
          onError: Colors.redAccent,
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        // Locale('en'), // English
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
