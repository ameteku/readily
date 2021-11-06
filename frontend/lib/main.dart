import 'package:flutter/material.dart';
import 'package:readily/modules/home/homepage.dart';
import 'package:readily/modules/class/class_page.dart';
import 'package:readily/modules/notes/note_slides.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        // home: RootApp(title: 'Readily Notes'),
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(title: 'Readily Notes'),
          '/class': (context) => ClassPage(title: 'Readily Notes'),
          '/note-slides': (context) => NoteSlideShowPage()
        });
  }
}
