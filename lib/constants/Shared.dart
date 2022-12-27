// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:free_notes_mobile/constants/Colors.dart';
import 'package:free_notes_mobile/constants/styles.dart';

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: notesIconColor));
}

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.,]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String emailNullError = "Please enter your email address";
const String invalidEmailError = "Please enter a valid email";
const String passNullError = "Please enter your password";
const String shortPassError = "Password is too short";
const String passMatchError = "Password's does not match";
const String nameNullError = "Please enter your name";
const String phoneNumberNullError = "Please enter your phone number";
const String addressNullError = "Please enter your address";

InputDecoration textFieldDecoration(String fieldtext) {
  return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      hintText: fieldtext,
      hintStyle: textFieldStyle,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: notesIconColor,
          ),
          gapPadding: 10),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: notesIconColor,
          ),
          gapPadding: 10),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: notesIconColor,
          ),
          gapPadding: 10));
}

InputDecoration notesTitleFieldDecoration(String fieldtext) {
  return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 3),
      hintText: fieldtext,
      hintStyle: hintTextStyle,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            style: BorderStyle.none,
            color: notesIconColor,
          ),
          gapPadding: 5),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            style: BorderStyle.none,
            color: notesIconColor,
          ),
          gapPadding: 5),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            style: BorderStyle.none,
            color: notesIconColor,
          ),
          gapPadding: 5));
}

InputDecoration notesContentFieldDecoration(String fieldtext) {
  return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      hintText: fieldtext,
      hintStyle: hintTextStyle,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            style: BorderStyle.none,
            color: notesIconColor,
          ),
          gapPadding: 1),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            style: BorderStyle.none,
            color: notesIconColor,
          ),
          gapPadding: 1),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            style: BorderStyle.none,
            color: notesIconColor,
          ),
          gapPadding: 1));
}

InputDecoration categoryFieldDecoration() {
  return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 3),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            style: BorderStyle.none,
            color: notesIconColor,
          ),
          gapPadding: 5),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            style: BorderStyle.none,
            color: notesIconColor,
          ),
          gapPadding: 5),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            style: BorderStyle.none,
            color: notesIconColor,
          ),
          gapPadding: 5));
}
