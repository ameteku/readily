import 'dart:html';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/src/types/image_source.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:readily/modules/class/class_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final String userName = 'Celina Lind';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  int classId = 1;
  // todo this function will filter through all the class ids for the given user and create a listview of classes
  ListView myClasses() {
    return ListView(
      children: [
        ListTile(
          title: const Text('Engineering 101'),
          subtitle: Row(
            children: const [Text('Date Created'), Text('By: Username of Creator')],
          ),
          tileColor: Color(0xfffcbfb7),
          onTap: () {
            // Navigator.pushNamed(context, '/class', arguments: ClassPage(title: widget.title, classId: classId));
            Navigator.pushNamed(context, '/class');
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        leading: Text(
          widget.userName, style: TextStyle(color: Colors.white, fontSize: 23),
          //
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const ListTile(
              leading: Icon(
                Icons.search,
                color: Color(0xff133c55),
                size: 28,
              ),
              title: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for classes to join or topics of interest',
                  hintStyle: TextStyle(
                    color: Color(0xff133c55),
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff133c55))),
                ),
                style: TextStyle(
                  color: Color(0xff133c55),
                ),
              ),
            ),
            SizedBox(height: 24),
            const Text(
              'Classes:',
              style: TextStyle(color: Color(0xff133c55), fontSize: 23),
            ),
            Expanded(child: myClasses()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      right: -40.0,
                      top: -40.0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
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
                            padding: EdgeInsets.all(8.0),
                            child: ListTile(title: const Text('Enter Class Name'), subtitle: TextFormField()),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ListTile(title: const Text('Add First Topic'), subtitle: TextFormField()),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
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
                                // getImage(ImageSource.gallery);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              child: Text("Create Class"),
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
        tooltip: 'Add Class',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// void getImage(ImageSource source) async {
//   File? image;
//   File? croppedImage;
//   // todo add try catch
//   await ImagePicker().getImage(source: source).then((value) {
//     print("Gotten image: ${value!.path}");
//     image = File(value.path);
//     _cropImage(image!).then((image) {
//       if (image != null) {
//         croppedImage = image;
//         print("Cropped image ${croppedImage?.absolute}");
//       }
//     });
//   });
// }
