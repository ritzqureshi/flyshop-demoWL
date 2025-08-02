import 'package:flutter/material.dart';

class MyColors {
  static const Color primary2ColorOfApp = Color(0xFF47b8dc); //Colors.red;47b8dc
  static const Color primaryColorOfApp = Color(0xFFffbb04); //Colors.red;
  static const Color greenColor = Color(0xFF00968A);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color amber = Colors.amber;
  static const Color yellowVeryDark = Color.fromRGBO(51, 51, 0, 1);
  static const Color yellow = Colors.yellow;
  static const Color skyBlue = Color.fromRGBO(0, 204, 255, 1);
  static const Color wheat = Color.fromRGBO(245, 222, 179, 1);
  static const Color orangePerfectDark = Color.fromRGBO(184, 63, 11, 1);
  static const Color accentLight = Color.fromRGBO(255, 192, 77, 0.9);
  static const Color grey = Colors.grey;
  static const Color greyDark = Color.fromRGBO(128, 128, 128, 0.9);
  static const Color greyLight = Color.fromRGBO(220, 220, 220, 0.9);
  static const Color greyVeryLight = Color.fromRGBO(220, 220, 220, 0.6);

  static const Color lightGrey = Color.fromRGBO(220, 220, 220, 0.4);
  static const Color lightBackSkyBlueBlue = Color.fromRGBO(159, 216, 251, 0.9);
  static const Color greenLight = Color.fromRGBO(166, 241, 166, 0.5);

  static const Color greenDark = Color.fromRGBO(56, 93, 56, 0.9);
  static const Color green = Colors.green;

  static const Color red = Colors.red;
  static const Color purple = Colors.purple;
  static const Color pink = Colors.pink;
  static const Color blue = Colors.blue;
  static const Color blueDark = Color.fromARGB(255, 7, 23, 245);
  static const Color transparent = Colors.transparent;

  static const Color magenta = Color.fromRGBO(139, 0, 139, 0.9);
  static const Color seaGreen = Color.fromRGBO(78, 191, 129, 0.9);
  static const Color navyBlue = Color.fromRGBO(0, 25, 102, 0.9);
  static const Color olive = Color.fromRGBO(167, 167, 0, 0.9);
  static const Color maroon = Color.fromRGBO(128, 0, 0, 0.9);
  static const Color steelBlue = Color.fromRGBO(59, 110, 152, 0.9);
  static const Color steelBlueLight = Color.fromRGBO(70, 130, 180, 0.9);
  static const Color userCircleBlackGround = Color(0xff2b2b33);
  static const Color onlineDotColor = Color(0xff46dc64);
  static const Color lightBlueColor = Color(0xff0077d7);
  static const Color separatorColor = Color(0xff272c35);

  static const Color gradientColorStart = Color(0xff00b6f3);
  static const Color gradientColorEnd = Color(0xff0184dc);

  static const Gradient mainGradientColour = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ Color.fromARGB(255, 0, 0, 0), // Very dark blue/green
    Color.fromARGB(255, 22, 39, 45), // Dark bluish-gray
    Color.fromARGB(255, 31, 57, 69),],
  );
}
