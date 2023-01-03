// ignore_for_file: file_names, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:free_notes_mobile/DatabaseHelper.dart';
import 'package:free_notes_mobile/screens/HomeScreen.dart';
import '../constants/Colors.dart';
import '../constants/Shared.dart';
import '../constants/SizeConfigurations.dart';
import '../constants/styles.dart';
import '../model/Notes.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({
    super.key,
  });
  static String routeName = "/AddNewNoteScreen";
  // final int noteId;

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  late Map myCategory = {};
  final _formkey = GlobalKey<FormState>();
  final List category = [
    {'Color': workColor, 'Category': 'Work Notes'},
    {'Color': studyColor, 'Category': 'Study Notes'},
    {'Color': personalColor, 'Category': 'Personal Affairs'},
    {'Color': noCatColor, 'Category': 'Uncategorized'}
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: lightBgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: lightBgColor,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: regTextColor),
        scrolledUnderElevation: 2.0,
        title: Text('Add New Notes', style: titleHeaderStyle),
        centerTitle: false,
        actionsIconTheme: const IconThemeData(color: regTextColor),
        actions: [
          IconButton(
            onPressed: () async {
              await addNote();
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
            icon: const Icon(
              Icons.check,
              color: notesIconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getPropWidth(15)),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildCategoryField(),
                Divider(
                  color: primaryBgColor,
                  thickness: getPropHeight(1),
                ),
                buildTitleField(),
                Divider(
                  color: primaryBgColor,
                  thickness: getPropHeight(1),
                ),
                buildContentField(),
              ],
            )),
          ),
        ),
      ),
    );
  }

  TextFormField buildTitleField() {
    return TextFormField(
      style: noteTitleStyle,
      cursorColor: regTextColor,
      decoration: notesTitleFieldDecoration("Title"),
      controller: title,
    );
  }

  TextFormField buildContentField() {
    return TextFormField(
        style: noteTitleStyle,
        cursorColor: regTextColor,
        controller: content,
        maxLines: null,
        // expands: true,
        decoration: notesContentFieldDecoration('Type Notes'));
  }

  DropdownButtonFormField buildCategoryField() {
    return DropdownButtonFormField(
      focusColor: primaryBgColor.withOpacity(0.5),
      elevation: 15,
      key: _formkey,
      dropdownColor: primaryBgColor.withOpacity(0.5),
      hint: Text('Select Category', style: regTextStyle),
      decoration: categoryFieldDecoration(),
      style: categoryTextStyle,
      items: category.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: 12,
                    width: 12,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      color: primaryBgColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: item['Color'],
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: getPropWidth(5),
              ),
              Text(
                item['Category'],
                style: categoryTextStyle,
              )
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        // ignore: avoid_print
        print(value['Color']);
        setState(() => myCategory = value);
      },
      onSaved: (newValue) {
        newValue['Color'] = myCategory['Color'];
        newValue['Category'] = myCategory['Category'];
      },
    );
  }

  Future addNote() async {
    _formkey.currentState?.save();
    final note = Note(
      title: title.text,
      contentId: content.text,
      categoryId: myCategory['Category'],
      categoryColorId: myCategory['Color'],
      createdTime: DateTime.now(),
    );

    await DatabaseHelp.instance.create(note.copy());
  }
}
