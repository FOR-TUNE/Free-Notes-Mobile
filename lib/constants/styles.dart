import 'package:flutter/material.dart';
import 'package:free_notes_mobile/constants/Colors.dart';
import 'package:free_notes_mobile/constants/SizeConfigurations.dart';

TextStyle titleHeaderStyle = TextStyle(
    fontSize: getPropWidth(32.0),
    color: notesIconColor,
    fontWeight: FontWeight.w900,
    letterSpacing: 2.5,
    fontFamily: 'Dancing Script');

TextStyle titleHeaderStyle2 = TextStyle(
    fontSize: getPropWidth(32.0),
    color: regTextColor,
    fontWeight: FontWeight.w900,
    letterSpacing: 2.5,
    fontFamily: 'Dancing Script');

TextStyle splashTextStyle = TextStyle(
    fontSize: getPropWidth(20.0),
    color: notesIconColor,
    fontWeight: FontWeight.w500,
    letterSpacing: 2.0,
    fontFamily: 'Dancing Script');

TextStyle appBariconTextStyle = TextStyle(
    fontSize: getPropWidth(14.0),
    color: primaryBgColor,
    fontWeight: FontWeight.w300,
    letterSpacing: 1.0,
    fontFamily: 'Dancing Script');

TextStyle textFieldStyle = TextStyle(
    fontSize: getPropWidth(14.0),
    color: regTextColor.withOpacity(0.3),
    fontWeight: FontWeight.w200,
    letterSpacing: 1.0,
    fontFamily: 'Lato');

TextStyle regTextStyle = TextStyle(
  color: regTextColor,
  fontFamily: 'Lato',
  fontSize: getPropWidth(16),
  fontWeight: FontWeight.w400,
);

TextStyle textHeaderStyle = TextStyle(
    fontSize: getPropWidth(24.0),
    color: regTextColor,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.5,
    fontFamily: 'Lato');

TextStyle noteTitleStyle = TextStyle(
    fontSize: getPropWidth(14.0),
    color: regTextColor.withOpacity(0.9),
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    fontFamily: 'Lato',
    fontStyle: FontStyle.italic);

TextStyle categoryTextStyle = TextStyle(
    fontSize: getPropWidth(14.0),
    color: regTextColor,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
    fontFamily: 'Lato',
    fontStyle: FontStyle.italic);

TextStyle hintTextStyle = TextStyle(
    fontSize: getPropWidth(14.0),
    color: regTextColor.withOpacity(0.3),
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    fontFamily: 'Lato');

TextStyle notesCardTitleTextStyle = TextStyle(
    fontSize: getPropWidth(18.0),
    color: regTextColor,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
    fontFamily: 'Lato');

TextStyle notesCardContentTextStyle = TextStyle(
    fontSize: getPropWidth(14.0),
    color: regTextColor,
    fontWeight: FontWeight.w400,
    letterSpacing: 1,
    fontFamily: 'Lato');

TextStyle notesTimeTextStyle = TextStyle(
    fontSize: getPropWidth(10.0),
    color: regTextColor,
    fontWeight: FontWeight.w400,
    letterSpacing: 1,
    fontFamily: 'Lato');
