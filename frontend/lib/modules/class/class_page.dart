import 'package:flutter/material.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({Key? key, required this.title}) : super(key: key);

  final String title;
  final String userName = 'Celina Lind';
  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  final _formKey = GlobalKey<FormState>();
  List<int> noteIdList = [1, 2, 3, 4, 5];
  String topicName = 'Expensive';
  String className = 'Equation Time';

  Widget imageList(int noteId, Size screenSize) {
    // List<Widget> noteList = [];
    // noteIds.forEach((id) {
    //   noteList.add(Container(
    //     width: screenSize.width > 400 ? screenSize.width / 2 : screenSize.width,
    //     color: Colors.lightGreenAccent,
    // ));
    // });
    // return noteList;
    return Container(
      width: screenSize.width > 400 ? screenSize.width / 2 : screenSize.width,
      color: Colors.lightGreenAccent,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    debugPrint('ScreenSizing:' + screenSize.toString());
    debugPrint('NOTE ID LENGTH: ' + noteIdList.length.toString());
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        ListTile(
            title: Text(className, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
            subtitle: ListView(children: [
              Card(
                  child: ListTile(
                title: Text(topicName),
                // subtitle: Container(
                //   width: screenSize.width > 400 ? screenSize.width / 2 : screenSize.width,
                //   color: Colors.lightGreenAccent,
                // ),
                subtitle: Row(children: [
                  ListView.builder(
                    itemCount: noteIdList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return imageList(noteIdList[index], screenSize);
                    },
                    scrollDirection: Axis.horizontal,
                  )
                ]),
              ))
            ])),
      ]),
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
                            child: ListTile(title: const Text('Enter Topic Name'), subtitle: TextFormField()),
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
                              child: Text("Create Topic"),
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
}
