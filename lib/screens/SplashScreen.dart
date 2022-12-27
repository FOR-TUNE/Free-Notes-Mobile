// ignore_for_file: file_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:free_notes_mobile/constants/Colors.dart';
import 'package:free_notes_mobile/screens/HomeScreen.dart';
import '../constants/SizeConfigurations.dart';
import '../constants/styles.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = '/splash';
  final spinkit = const SpinKitThreeBounce(
    color: notesIconColor,
    size: 30,
  );
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 10),
        () => Navigator.of(context).pushReplacementNamed(HomeScreen.routeName));
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: lightBgColor,
      body: Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getPropWidth(25)),
              child: SizedBox(
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/notes-icon.svg',
                          height: getPropHeight(100),
                          width: getPropWidth(80),
                          color: notesIconColor,
                        ),
                        SizedBox(
                          height: getPropHeight(2),
                        ),
                        Text("FREE-NOTEZ", style: titleHeaderStyle),
                        SizedBox(
                          height: getPropHeight(10),
                        ),
                        SizedBox(child: spinkit),
                      ])))),
    );
  }
}
