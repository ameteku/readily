import 'package:flutter/material.dart';

class NoteSlideShowPage extends StatefulWidget {
  const NoteSlideShowPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _NoteSlideShowPageState createState() => _NoteSlideShowPageState();
}

class _NoteSlideShowPageState extends State<NoteSlideShowPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: screenSize.width > 360
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text('Hello there'),
              )
            : Text('Too small'));
  }
}
