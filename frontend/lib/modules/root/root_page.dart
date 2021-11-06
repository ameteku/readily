import 'package:flutter/material.dart';
import 'package:readily/modules/home/homepage.dart';
import 'package:readily/modules/class/class_page.dart';
import 'package:readily/modules/notes/note_slides.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key, required this.title}) : super(key: key);

  final String title;
  final String userName = 'Celina Lind';

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 8.0),
        //   child: TextButton(
        //     // style: ButtonStyle(minimumSize: MaterialStateProperty<Size>(3)),
        //     child: Text(
        //       widget.userName,
        //       style: TextStyle(color: Colors.white),
        //       // textAlign: TextAlign.center,
        //     ),
        //     onPressed: () {
        //       Navigator.popUntil(context, (route) => route.isFirst);
        //     },
        //   ),
        // ),
      ),
      body: MaterialApp(
          title: 'Readily',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const MyHomePage(),
            '/class': (context) => ClassPage(),
            '/note-slides': (context) => NoteSlideShowPage()
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, //this will bring up add class modal
        tooltip: 'Add Class',
        child: const Icon(Icons.add),
      ),
    );
  }
}
