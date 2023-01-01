import 'package:flutter/material.dart';
import 'package:free_notes_mobile/screens/AddNotesScreen.dart';
import 'package:free_notes_mobile/screens/EditNotesScreen.dart';
import 'package:free_notes_mobile/screens/HomeScreen.dart';
import 'package:free_notes_mobile/screens/SplashScreen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  AddNotesScreen.routeName: (context) => const AddNotesScreen(),
};
