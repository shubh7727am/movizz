import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lottie/lottie.dart';
import 'package:movizz/View/main_screen.dart';
import 'package:movizz/core/utils/colors.dart';
import 'package:movizz/core/utils/dimensions.dart';


import 'View/home_page.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    _startSplashScreenTimer();
  }

  void _startSplashScreenTimer() {
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF82AAFF),
        primaryColorDark: Color(0xFF4976C8),
        hintColor: Color(0xFFC792EA),
        scaffoldBackgroundColor: Color(0xFF011627),
        cardColor: Color(0xFF0D2538),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.poppins(
            color: Color(0xFFD6DEEB),
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.roboto(
            color: Color(0xFFD6DEEB),
            fontSize: 18,
          ),
          bodyLarge: GoogleFonts.inter(
            color: Color(0xFFD6DEEB),
            fontSize: 14,
          ),
          bodyMedium: GoogleFonts.nunito(
            color: Color(0xFF7E97AA),
            fontSize: 14,
          ),
        ),
        dividerColor: Color(0xFF607B96),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF82AAFF),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: _showSplash ? const SplashScreen() : const MainScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: Dimensions.screenWidth(context),
            height: Dimensions.screenHeight(context),
            child: LottieBuilder.asset(
              "assets/animations/splash.json",


            )),
      ),
    );
  }
}
