import 'package:flutter/material.dart';
import 'package:readily/backend-requests/request.dart';
import 'package:readily/modules/class/class_page.dart';
import 'package:readily/modules/home/homepage.dart';
import 'package:readily/modules/login-sign-up/login_page.dart';
import 'package:readily/modules/login-sign-up/sign_up.dart';
import 'package:readily/modules/notes/note_slides.dart';

import 'appstate/app_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late AppState _appState;
  late BackendRequest _backendRequest;
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _appState = AppState();
    _backendRequest = BackendRequest();

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
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(
                appState: _appState,
                backendRequest: _backendRequest,
              ),
          '/signup': (context) => const SignUpPage(),
          '/homepage': (context) => const MyHomePage(title: 'Readily Notes'),
          '/class': (context) => const ClassPage(title: 'Readily Notes', classId: 2),
          '/note-slides': (context) => const NoteSlideShowPage(
                title: 'Readily Notes',
                noteIdList: [1, 2, 3, 4, 5, 6, 7],
                startingId: 5,
              )
        });
  }
}
