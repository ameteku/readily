import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({Key? key, required this.title}) : super(key: key);

  final String title;
  final String userName = 'Celina Lind';
  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  final _formKey = GlobalKey<FormState>();
  List<int> noteIdList = [1, 2, 3, 4, 5, 6, 7, 8, 6, 5, 4, 3, 33, 2, 2, 3];
  String topicName = 'Expensive';
  String className = 'Equation Time';
  List<int> topicIdList = [1, 3, 2, 4, 5, 6, 4, 2];

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
                    ? Wrap(spacing: 8.0, runSpacing: 4.0, children: myNotes(noteIds, screenSize))
                    : SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: myNotes(noteIds, screenSize)))),
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
                  // getImage(ImageSource.gallery);
                },
              ),
            ),
          ],
        ),
      )));
    });
    return topicList;
  }

  List<Widget> myNotes(List<int> noteIds, Size screenSize) {
    List<Widget> noteList = [];
    noteIds.forEach((id) {
      noteList.add(Container(
          height: 150,
          width: 110,
          child: ListTile(
              title: Container(
            color: Colors.lightGreenAccent,
          ))));
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
            const Text(
              'Classes:',
              style: TextStyle(color: Color(0xff133c55), fontSize: 23),
            ),
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
                                // getImage(ImageSource.gallery);
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
}
