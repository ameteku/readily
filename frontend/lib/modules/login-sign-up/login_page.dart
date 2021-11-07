import 'package:flutter/material.dart';
import 'package:readily/appstate/app_state.dart';
import 'package:readily/backend-requests/request.dart';
import 'package:readily/folder/user_model.dart';

class LoginPage extends StatefulWidget {
  final AppState appState;
  final BackendRequest backendRequest;
  const LoginPage({required this.appState, required this.backendRequest, Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Readily Notes"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * .7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              title: Text(
                "Login",
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListTile(
                            title: const Text('Email'),
                            subtitle: TextFormField(
                              controller: _emailController,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListTile(
                            title: const Text('Password'),
                            subtitle: TextFormField(
                              controller: _passwordController,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: const Text("Login"),
                          onPressed: () async {
                            String email = _emailController.text;
                            if (email.isNotEmpty) {
                              String password = _passwordController.text;
                              if (password.isNotEmpty) {
                                await loginUser(password, email);
                              }
                            }
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
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text("Or Sign Up"))
          ],
        ),
      ),
    );
  }

  loginUser(String password, String email) async {
    UserModel? user = await widget.backendRequest.loginUser(email, password);
    user = UserModel(id: "sometinh", classIds: [], firstName: "Michael", lastName: "Ameteku");
    if (user == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Try Signing in Again",
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
