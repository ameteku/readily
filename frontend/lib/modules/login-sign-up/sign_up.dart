import 'package:flutter/material.dart';
import 'package:readily/appstate/app_state.dart';
import 'package:readily/backend-requests/request.dart';
import 'package:readily/folder/user_model.dart';

class SignUpPage extends StatefulWidget {
  final BackendRequest backendRequest;
  final AppState appState;
  const SignUpPage({required this.appState, required this.backendRequest, Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  List<String> formFields = ["First Name", "Last Name", "Email", "Password"];
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    if (widget.appState.getStreamOfUserChanges().hasValue) {
      widget.appState.getStreamOfUserChanges().listen((event) {
        if (event != null) {
          String? currentRoute = ModalRoute.of(context)!.settings.name;
          if (currentRoute == "/login" || currentRoute == '/signup') {
            Navigator.pushNamed(context, "/homepage");
          }
        }
      });
    }

    for (var element in formFields) {
      controllers[element] = TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.appState.loggedInUser != null) {
      Navigator.pushNamed(context, "/homepage");
    }
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Readily Notes"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * .9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              title: const Text(
                "SignUp",
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ...formFields.map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              title: Text(e),
                              subtitle: TextFormField(
                                controller: controllers[e],
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: const Text("Sign Up"),
                          onPressed: () {
                            for (String element in formFields) {
                              if (controllers[element]!.text == "") {
                                return;
                              }
                            }

                            signUpUser(controllers['Password']!.text, controllers['Email']!.text, controllers["First Name"]!.text,
                                controllers["Last Name"]!.text);
                            //todo add api search here
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text("Log In"))
          ],
        ),
      ),
    );
  }

  signUpUser(String password, String email, String firstName, String lastName) async {
    UserModel newUser = UserModel(classIds: [], firstName: firstName, lastName: lastName, email: email, password: password);
    UserModel? user = await widget.backendRequest.signUpUser(newUser);

    user = newUser;
    if (user == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Try Signing Up Again",
            style: TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          actions: [
            SizedBox(
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Go Back"),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      widget.appState.loggedInUser = user;
      Navigator.pushNamed(context, '/homepage');
    }
  }
}
