import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:universal_html/html.dart' as html5;

class ClassPage extends StatefulWidget {
  const ClassPage({Key? key, required this.title, required this.classId}) : super(key: key);
  final int classId;
  final String title;
  final String userName = 'Celina Lind';
  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  final _formKey = GlobalKey<FormState>();
  List<int> noteIdList = [1, 2, 3, 4, 5, 6, 7, 8, 6, 5, 4, 3, 33, 2, 2, 3];
  String topicName = 'Expensive';
  late List<Uint8List?> byteImageInfo = [];
  //classId retrieved get class name from id as well as topics list then note list
  String className = 'Equation Time';
  List<int> topicIdList = [1, 3, 2, 4, 5, 6, 4, 2];
  final FileType _pickingType = FileType.image;

  void getImage(pickingType) async {
    io.File? croppedImage;
    List<PlatformFile>? _paths = (await FilePicker.platform.pickFiles(
      type: pickingType,
      allowMultiple: true,
      onFileLoading: (FilePickerStatus status) => print(status),
    ))
        ?.files;

    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: pickingType);
    print('Results: $result');

    if (result?.files != null) {
      Uint8List? fileBytes;
      String fileName;
      // var fileBytes = result!.files.first.bytes;
      // var fileName = result!.files.first.name;
      result?.files.forEach((element) {
        fileBytes = element.bytes;
        fileName = element.name;
        setState(() {
          byteImageInfo.add(Uint8List.fromList(fileBytes!));
        });
        //todo upload to storage db
      });
    } else {
      throw "Cancelled File Picker";
    }
  }

  List<Widget> myTopics(List<int> noteIds, Size screenSize, List<int> topicIds, String topicName) {
    List<Widget> topicList = [];

    topicIds.forEach((id) {
      topicList.add(Container(
          child: ExpandablePanel(
        header: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            topicName,
            style: TextStyle(fontSize: 24, color: Color(0xff133c55)),
          ),
        ),
        collapsed: SizedBox(height: 10),
        expanded: Column(
          children: [
            PreferredSize(
                preferredSize: const Size.fromHeight(200),
                child: screenSize.width > 370
                    ? Wrap(spacing: 8.0, runSpacing: 4.0, children: myNotes(noteIds, screenSize, context))
                    : SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: myNotes(noteIds, screenSize, context)))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: Center(
                    child: Column(children: const [
                  Text('Upload New Note'),
                  Icon(
                    Icons.add_a_photo,
                    size: 24,
                  )
                ])),
                onPressed: () {
                  getImage(_pickingType);
                },
              ),
            ),
          ],
        ),
      )));
    });
    return topicList;
  }

  List<Widget> myNotes(List<int> noteIds, Size screenSize, BuildContext context) {
    List<Widget> noteList = [];
    // noteIds.forEach((id) {
    byteImageInfo.forEach((element) {
      noteList.add(byteImageInfo.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                // child: Image(image: MemoryImage(element!, scale: 2), width: 110, height: 150),
                child: Image.memory(element!, width: 110, height: 200),
                onTap: () {
                  Navigator.pushNamed(context, '/note-slides');
                },
              ),
            )
          : Container(
              color: Colors.lightGreenAccent,
              height: 150,
              width: 110,
            ));
    });
    return noteList;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Classes:',
                style: TextStyle(color: Color(0xff133c55), fontSize: 23),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  tooltip: 'Share Class',
                  iconSize: 20,
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    var data = {
                      "title": className,
                      "text": 'Checkout this class on Readily for some great notes!',
                    };
                    share(data);
                  },
                ),
              )
            ]),
            Column(children: myTopics(noteIdList, screenSize, topicIdList, topicName)),
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Stack(
                  children: <Widget>[
                    Positioned(
                      right: -40.0,
                      top: -40.0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(title: const Text('Enter Topic Name'), subtitle: TextFormField()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              child: Center(
                                  child: Column(children: const [
                                Text('Upload Note Images'),
                                Icon(
                                  Icons.add_a_photo,
                                  size: 24,
                                )
                              ])),
                              onPressed: () {
                                getImage(_pickingType);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: const Text("Create Topic"),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                }
                                //todo add api search here
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }, //this will bring up add class modal
        tooltip: 'Add Topic',
        child: const Icon(Icons.add),
      ),
    );
  }

  void share(Map data) async {
    try {
      await Share.share(data['text'], subject: data['title']);
      print('done');
    } catch (e) {
      print(e);
    }
  }
}
