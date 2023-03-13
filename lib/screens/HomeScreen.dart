// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:free_notes_mobile/DatabaseHelper.dart';
import 'package:free_notes_mobile/screens/AddNotesScreen.dart';
import 'package:free_notes_mobile/screens/EditNotesScreen.dart';
import 'package:intl/intl.dart';
import '../constants/Colors.dart';
import '../constants/SizeConfigurations.dart';
import '../constants/styles.dart';
import '../model/Notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note>? notes;
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

    notes = await DatabaseHelp.instance.readAllNotes();

    setState(() {
      isLoading = false;
    });
  }

  Future sortbyCat() async {
    setState(() {
      isLoading = true;
    });

    notes = await DatabaseHelp.instance.sortByCategory();

    setState(() {
      isLoading = false;
    });
  }

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final List<String> dropdownitem = [
    'Delete all Threads',
    'Sort by Category',
    'Sort by Date'
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: lightBgColor,
              title: const Text('Exit'),
              content: Text(
                'Are you sure you want to exit the app?',
                style: notesCardContentTextStyle,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    onWillPop(context, false);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          shadowColor: regTextColor.withOpacity(0.2),
          elevation: 0,
          backgroundColor: primaryBgColor,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 2.0,
          title: Text('Free-Notez', style: titleHeaderStyle),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () async {
                await refreshNotes();
              },
              icon: Icon(
                Icons.refresh,
                size: getPropWidth(20),
                color: notesIconColor,
              ),
            ),
            PopupMenuButton(
              position: PopupMenuPosition.under,
              padding: EdgeInsets.symmetric(horizontal: getPropWidth(10)),
              color: lightBgColor,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      value: dropdownitem[0],
                      child: Text(
                        dropdownitem[0],
                        style: noteTitleStyle,
                      )),
                  PopupMenuItem(
                      value: dropdownitem[1],
                      child: Text(
                        dropdownitem[1],
                        style: noteTitleStyle,
                      )),
                  PopupMenuItem(
                      value: dropdownitem[2],
                      child: Text(
                        dropdownitem[2],
                        style: noteTitleStyle,
                      )),
                ];
              },
              onSelected: (value) {
                if (value == dropdownitem[0]) {
                  deleteAllNotes();
                }
                if (value == dropdownitem[1]) {
                  sortbyCat();
                }
                if (value == dropdownitem[2]) {
                  refreshNotes();
                }
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/notes-icon.svg',
                    height: getPropHeight(30),
                    width: getPropWidth(20),
                    color: notesIconColor,
                  ),
                  SizedBox(
                    height: getPropHeight(2),
                  ),
                  Icon(
                    Icons.more_vert,
                    size: getPropWidth(20),
                    color: notesIconColor,
                  )
                ],
              ),
            ),
          ],
        ),
        backgroundColor: primaryBgColor.withOpacity(0.75),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : notes!.isEmpty
                  ? Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: getPropWidth(25)),
                        child: SizedBox(
                          width: getPropWidth(300),
                          height: getPropHeight(180),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AddNotesScreen.routeName);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/class-notes-icon.svg',
                                  color: notesIconColor,
                                  width: getPropWidth(80),
                                  height: getPropHeight(80),
                                ),
                                SizedBox(height: getPropHeight(5)),
                                Text(
                                  'Create New Note...',
                                  style: titleHeaderStyle,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: RoundedIcnBtn(
          press: () {
            Navigator.of(context).pushNamed(AddNotesScreen.routeName);
          },
        ),
      ),
    );
  }

  pushToEdit(id) async {
    await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => EditNotesScreen(noteId: id)));
  }

  deleteAllNotes() async {
    await DatabaseHelp.instance.deleteAllNotes();

    setState(() {
      refreshNotes();
    });
  }

  Widget buildNotes() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        itemCount: notes!.length,
        itemBuilder: (context, index) {
          final note = notes![index];
          return Dismissible(
            key: Key(notes![index].toString()),
            onDismissed: (direction) async {
              await DatabaseHelp.instance.deleteNotes(notes![index].id!);
              setState(() {
                refreshNotes();
              });
            },
            child: GestureDetector(
              onTap: () async {
                await pushToEdit(note.id!);
                refreshNotes();
              },
              child: NotesCard(
                currentTitle: note.title,
                currentContent: note.contentId,
                time: dateFormat.format(note.createdTime),
                categoryColor: note.categoryColorId,
                currentId: note.id,
                currentCategory: note.categoryId,
              ),
            ),
          );
        });
  }
}

onWillPop(context, bool toggle) async {
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  return toggle;
}

class RoundedIcnBtn extends StatelessWidget {
  const RoundedIcnBtn({
    Key? key,
    required this.press,
  }) : super(key: key);

  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: getPropHeight(60),
        width: getPropWidth(60),
        child: MaterialButton(
          padding: EdgeInsets.zero,
          color: notesIconColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
          onPressed: press,
          child: Icon(
            Icons.create,
            size: getPropHeight(30),
            color: secondaryBgColor,
          ),
        ));
  }
}

class NotesCard extends StatelessWidget {
  const NotesCard({
    Key? key,
    required this.currentTitle,
    required this.currentContent,
    this.categoryColor,
    this.time,
    this.currentId,
    this.currentCategory,
  }) : super(key: key);

  final String? currentTitle;
  final String? currentContent, currentCategory;
  final Color? categoryColor;
  final String? time;
  final int? currentId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getPropWidth(8), vertical: getPropHeight(7)),
      child: Container(
        decoration: BoxDecoration(
            color: lightBgColor.withOpacity(0.6),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(
                style: BorderStyle.solid,
                color: lightBgColor.withOpacity(0.3),
                strokeAlign: BorderSide.strokeAlignInside)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: getPropWidth(8), vertical: getPropHeight(0.2)),
          tileColor: primaryBgColor.withOpacity(0.75),
          isThreeLine: false,
          minLeadingWidth: 1.0,
          title:
              Text(currentTitle!.toUpperCase(), style: notesCardTitleTextStyle),
          subtitle: Text("${currentContent!.substring(0, 5)}...",
              style: notesCardContentTextStyle),
          trailing: SizedBox(
            height: getPropHeight(75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$time'.toUpperCase(),
                  style: notesTimeTextStyle,
                ),
                Text(
                  '$currentCategory',
                  style: TextStyle(
                      fontSize: getPropWidth(10.0),
                      color: categoryColor,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                      fontFamily: 'Lato'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CatColor extends StatelessWidget {
  const CatColor({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
