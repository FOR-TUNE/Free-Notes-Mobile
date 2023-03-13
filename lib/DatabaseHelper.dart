// ignore_for_file: file_names
import 'dart:io';
import 'package:free_notes_mobile/model/Notes.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelp {
  static final _dbName =
      'myDatabase.db'; // note .db is the extension ensures the we're specifying the database file
  static final _dbVersion = 1;
  static final _tableName = 'myTable';
  static final columnId = "_id";
  static final title = '_titleId';
  static final contentId = 'contentId';
  static final categoryId = 'categoryId';
  static final categoryColorId = 'categoryColorId';

  // Make it a singleton class, by creating a private constructor
  // This is because we desire only one instance of the Database
  DatabaseHelp._privateConst();
  static final DatabaseHelp instance = DatabaseHelp._privateConst();

  // Now we need to initialize the database
  // This is created using static so that these values can only be accessed using the class name.

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initiateDatabase();
    return _database!;
  }

  _initiateDatabase() async {
    // specify which directory into which the database would be stored.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    // Next stop is to open the database
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
    // Note that we can also upgrade the structure of the table created to include other fields/tables,
    // This can be done using the onUpgrade: method in the function above.
  }

  // Now we create the table used in the database
  Future<dynamic>? _onCreate(Database db, int version) {
    db.execute(
        // Here we use 3 single quote to allow writing of any string in multiple lines, treating it as a single string.
        ''' 
    CREATE TABLE $tableName
    (${NoteFields.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${NoteFields.title} TEXT NOT NULL, 
    ${NoteFields.contentId} TEXT NOT NULL,
    ${NoteFields.categoryId} TEXT NOT NULL,
    ${NoteFields.time} TEXT NOT NULL,
    ${NoteFields.categoryColorId} INTEGER NOT NULL
    )
    ''');
  }

  Future<Note> create(Note note) async {
    Database db = await instance.database;
    // We need to persist this note within our sqflite database,
    final id = await db.insert(tableName, note.toJson());
    return note.copy();
  }

  Future<Note> readNote(int id) async {
    Database db = await instance.database;
    final maps = await db.query(tableName,
        columns: NoteFields.values,
        where: '${NoteFields.columnId} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Note>> readAllNotes() async {
    Database db = await instance.database;
    const orderby = '${NoteFields.time} ASC';
    final result = await db.query(tableName, orderBy: orderby);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<List<Note>> sortByCategory() async {
    Database db = await instance.database;
    const orderby = '${NoteFields.categoryId} ASC';
    final result = await db.query(tableName, orderBy: orderby);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> updateNotes(Note note) async {
    Database db = await instance.database;
    return db.update(
      tableName,
      note.toJson(),
      where: '${NoteFields.columnId} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNotes(int id) async {
    Database db = await instance.database;
    return await db.delete(
      tableName,
      where: '${NoteFields.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future deleteAllNotes() async {
    Database db = await instance.database;
    return await db.rawDelete("delete from $tableName");
  }

  Future close() async {
    Database db = await instance.database;
    db.close();
  }

  /// NOTE ALL OPERATIONS BELOW ARE INITIAL TUTORIAL CODES AND ARE NOT UTILIZED

  // we use the int type because when we create a new value to the database,
  // we intend to make the id autogenerated and incremented by 1 once we insert a new table,
  // this will ensure that all the values are unique.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    // We use this to simply get all the rows from the database.
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    // Below we are using the where function to specify as to which row, column id has to be updated.
    return await db
        .update(_tableName, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    // Below we are using the where function to specify as to which row, column id has to be updated.
    return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}

// Structure of the values we will get in return for the query values is given below.
// {
// "_id": 1, note; this _id would be made to increase automatically and auto generated
//   "title": "title today",
//   "contentId": "Today's content",
//   'categoryId': "Today's category",
//   "categoryColorId": Colors.red
// }
