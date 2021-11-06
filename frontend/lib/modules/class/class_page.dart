import 'package:flutter/material.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({Key? key, required this.title}) : super(key: key);

  final String title;
  final String userName = 'Celina Lind';
  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
          //Will be vertical list of topics then horizontal list of note images
          child: ListView()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, //this will bring up add class modal
        tooltip: 'Add Class',
        child: const Icon(Icons.add),
      ),
    );
  }
}
