import 'package:flutter/material.dart';
import 'package:readily/appstate/app_state.dart';
import 'package:readily/backend-requests/request.dart';
import 'package:readily/folder/class_model.dart';

class MyHomePage extends StatefulWidget {
  final AppState appState;
  final BackendRequest backendRequest;

  const MyHomePage({Key? key, required this.title, required this.backendRequest, required this.appState}) : super(key: key);

  final String title;
  final String userName = 'Celina Lind';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

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
            Navigator.pushNamed(context, '/class');
          },
        )
      ],
    );
  }

  late Future<List<ClassModel>?> classModels;

  @override
  void initState() {
    classModels = widget.backendRequest.getClasses(widget.appState.loggedInUser!.classIds, "temporary");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
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
            Expanded(
              child: FutureBuilder(
                future: classModels,
                builder: (context, AsyncSnapshot<List<ClassModel>?> snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: snapshot.data!
                          .map((e) => ListTile(
                                title: Text(e.title),
                                subtitle: Row(
                                  children: [const Text('Date Created'), Text(e.permissions['admin']?[0] ?? "")],
                                ),
                                tileColor: const Color(0xfffcbfb7),
                                onTap: () {
                                  Navigator.pushNamed(context, '/class');
                                },
                              ))
                          .toList(),
                    );
                  } else {
                    return const Text("Loading your Class...");
                  }
                },
              ),
            ),
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
