import 'package:credit_card_using_bloc_pattern/ui/views/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        primaryColorBrightness: Brightness.light,
      ),
      home: SplashScreen(),
    ));
