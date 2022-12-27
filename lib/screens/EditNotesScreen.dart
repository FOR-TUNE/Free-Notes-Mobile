// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:free_notes_mobile/DatabaseHelper.dart';
import 'package:free_notes_mobile/model/Notes.dart';
import '../constants/Colors.dart';
import '../constants/Shared.dart';
import '../constants/SizeConfigurations.dart';
import '../constants/styles.dart';

class EditNotesScreen extends StatefulWidget {
  final Note? note;
  const EditNotesScreen({super.key, required this.noteId, this.note});
  static String routeName = "/EditNewNoteScreen";
  final int noteId;

  @override
  State<EditNotesScreen> createState() => _EditNotesScreenState();
}

class _EditNotesScreenState extends State<EditNotesScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  Color currentCategoryColor = Color(noCatColor.value);
  String currentCategoryName = '';
  final _formkey = GlobalKey<FormState>();
  final List category = [
    {'Color': workColor.value, 'Category': 'Work Notes'},
    {'Color': studyColor.value, 'Category': 'Study Notes'},
    {'Color': personalColor.value, 'Category': 'Personal Affairs'},
    {'Color': noCatColor.value, 'Category': 'Uncategorized'}
  ];

  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() {
      isLoading = true;
    });

    note = await DatabaseHelp.instance.readNote(widget.noteId);

    setState(() {
      isLoading = false;
    });
  }

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
        title: Text('Add Notes', style: titleHeaderStyle),
        centerTitle: false,
        actionsIconTheme: const IconThemeData(color: regTextColor),
        actions: [
          IconButton(
            onPressed: () async {
              await DatabaseHelp.instance.delete(note.id!);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.delete,
              color: notesIconColor,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () async {
              await updateNote();
              Navigator.pop(context);
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
                SizedBox(
                  height: getPropHeight(1),
                ),
                buildTitleField(),
                // Divider(
                //   color: primaryBgColor,
                //   thickness: getPropHeight(1.5),
                // ),
                buildCategoryField(),
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
      initialValue: note.title,
      style: noteTitleStyle,
      cursorColor: regTextColor,
      decoration: notesTitleFieldDecoration("Title"),
      controller: title,
    );
  }

  TextFormField buildContentField() {
    return TextFormField(
        initialValue: note.contentId,
        style: noteTitleStyle,
        cursorColor: regTextColor,
        controller: content,
        maxLines: null,
        // expands: true,
        decoration: notesContentFieldDecoration('Type Notes'));
  }

  DropdownButtonFormField buildCategoryField() {
    return DropdownButtonFormField(
      dropdownColor: lightBgColor,
      decoration: categoryFieldDecoration(),
      style: noteTitleStyle,
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
                      color: Color(note.categoryColorId.value),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: getPropWidth(5),
              ),
              Text(
                note.categoryId,
                style: hintTextStyle,
              )
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        // ignore: avoid_print
        print(value);
        setState(() {
          value['Color'] = currentCategoryColor;
          value['Category'] = currentCategoryName;
        });
      },
      onSaved: (newValue) {
        setState(() {
          newValue['Color'] = currentCategoryColor;
          newValue['Category'] = currentCategoryName;
        });
      },
    );
  }

  Future updateNote() async {
    _formkey.currentState?.save();
    final note = widget.note!.copy(
      title: title.text,
      contentId: content.text,
      categoryId: currentCategoryName,
      categoryColorId: currentCategoryColor,
      // createdTime: DateTime.now(),
    );

    await DatabaseHelp.instance.update(note.toJson());
  }
}
