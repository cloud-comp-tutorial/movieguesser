import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:guessthemovie/screens/home.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Questrial',
      ),
      routes: {
        'home': (context) => Home(),
      },
      home: AnimatedSplashScreen(
        splash: Text(
          'MOVIE GUESSER',
          style: TextStyle(fontSize: 40, fontFamily: 'Questrial'),
        ),
        animationDuration: Duration(milliseconds: 600),
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: Home(),
      ),
    ),
  );
}
