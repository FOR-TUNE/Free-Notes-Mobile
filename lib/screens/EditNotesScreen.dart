// ignore_for_file: file_names, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:free_notes_mobile/DatabaseHelper.dart';
import 'package:free_notes_mobile/model/Notes.dart';
import 'package:free_notes_mobile/screens/HomeScreen.dart';
import '../constants/Colors.dart';
import '../constants/Shared.dart';
import '../constants/SizeConfigurations.dart';
import '../constants/styles.dart';

class EditNotesScreen extends StatefulWidget {
  final int noteId;
  const EditNotesScreen({super.key, required this.noteId});
  static String routeName = "/EditNewNoteScreen";

  @override
  State<EditNotesScreen> createState() => _EditNotesScreenState();
}

class _EditNotesScreenState extends State<EditNotesScreen> {
  late TextEditingController title;
  late TextEditingController content;
  late Map myCategory = {};
  final _formkey = GlobalKey<FormState>();
  final List category = [
    {'Color': workColor, 'Category': 'Work Notes'},
    {'Color': studyColor, 'Category': 'Study Notes'},
    {'Color': personalColor, 'Category': 'Personal Affairs'},
    {'Color': noCatColor, 'Category': 'Uncategorized'}
  ];

  Note? notes;
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

    notes = await DatabaseHelp.instance.readNote(widget.noteId);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (notes != null) {
      setState(() {
        title = TextEditingController(text: notes!.title);
      });
    }

    if (notes != null) {
      setState(() {
        content = TextEditingController(text: notes!.contentId);
      });
    }
    // if (notes != null) {
    //   setState(() {
    //     myCategory = {
    //       'Color': notes!.categoryColorId,
    //       'Category': notes!.categoryId
    //     };
    //   });
    // }
    return Scaffold(
      backgroundColor: lightBgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: lightBgColor,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: regTextColor),
        scrolledUnderElevation: 2.0,
        title: Text('Edit Notes', style: titleHeaderStyle),
        centerTitle: false,
        actionsIconTheme: const IconThemeData(color: regTextColor),
        actions: [
          IconButton(
            onPressed: () async {
              await DatabaseHelp.instance.deleteNotes(notes!.id!);
              Navigator.pushNamed(context, HomeScreen.routeName);
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
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getPropWidth(15)),
                    child: SingleChildScrollView(
                        child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: getPropHeight(1),
                          ),
                          buildTitleField(),
                          buildCategoryField(),
                          buildContentField(),
                        ],
                      ),
                    )),
                  ),
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
      onSaved: (value) {
        setState(() {
          title.text = value!;
        });
      },
    );
  }

  TextFormField buildContentField() {
    return TextFormField(
        style: noteTitleStyle,
        cursorColor: regTextColor,
        controller: content,
        maxLines: null,
        onSaved: (value) {
          setState(() {
            content.text = value!;
          });
        },
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
                style: hintTextStyle,
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

  Future updateNote() async {
    _formkey.currentState?.save();
    final note = notes!.copy(
      title: title.text,
      contentId: content.text,
      categoryId: myCategory['Category'],
      categoryColorId: myCategory['Color'],
      // createdTime: DateTime.now(),
    );

    await DatabaseHelp.instance.updateNotes(note);
  }
}
