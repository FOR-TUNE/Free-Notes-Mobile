// ignore_for_file: file_names
import 'package:flutter/animation.dart';

const String tableName = 'myTableNotes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    columnId, title, contentId, categoryId, categoryColorId, time
  ];

  static const columnId = "_id";
  static const title = 'titleId';
  static const contentId = 'contentId';
  static const categoryId = 'categoryId';
  static const categoryColorId = 'categoryColorId';
  static const time = 'time';
}

class Note {
  final int? id;
  final String title;
  final String contentId;
  final String categoryId;
  final Color categoryColorId;
  final DateTime createdTime;

  Note(
      {this.id,
      required this.title,
      required this.contentId,
      required this.categoryId,
      required this.categoryColorId,
      required this.createdTime});

  // Now we create another method to copy all values of the current note object while modifying only the id,
  Note copy({
    int? id,
    String? title,
    String? contentId,
    String? categoryId,
    Color? categoryColorId,
    DateTime? createdTime,
  }) =>
      Note(
          id: id ?? this.id,
          title: title ?? this.title,
          contentId: contentId ?? this.contentId,
          categoryId: categoryId ?? this.categoryId,
          categoryColorId: categoryColorId ?? this.categoryColorId,
          createdTime: createdTime ?? this.createdTime);

  static Note fromJson(Map<String, Object?> json) => Note(
      id: json[NoteFields.columnId] as int?,
      title: json[NoteFields.title] as String,
      contentId: json[NoteFields.contentId] as String,
      categoryId: json[NoteFields.categoryId] as String,
      categoryColorId: Color(json[NoteFields.categoryColorId] as int),
      createdTime: DateTime.parse(json[NoteFields.time] as String));

  // Now we need to create a function that converts our note class to a Json file which is how sqflite can read it.
  Map<String, Object?> toJson() => {
        NoteFields.columnId: id,
        NoteFields.title: title,
        NoteFields.contentId: contentId,
        NoteFields.categoryId: categoryId,
        NoteFields.time: createdTime.toIso8601String(),
        NoteFields.categoryColorId: categoryColorId.value
      };
}
