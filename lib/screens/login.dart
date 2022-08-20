import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:login/screens/HomeScreen.dart';
import 'package:login/screens/register.dart';
import 'package:login/services/authServices.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            loading
                ? CircularProgressIndicator()
                : Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          if (emailController.text == "" ||
                              passwordController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "All fields are Required",
                              ),
                              backgroundColor: Colors.red,
                            ));
                          } else {
                            User? result = await AuthServices().login(
                                emailController.text,
                                passwordController.text,
                                context);
                            if (result != null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "Login Succsessful",
                                ),
                                backgroundColor: Colors.green,
                              ));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomeScreen(result)));
                            }
                          }
                          setState(() {
                            loading = false;
                          });
                        },
                        child: Text(
                          "Login In",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                  ),
            SizedBox(
              height: 35,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: Text("Do Not Have An Account?? Register Here"))
          ],
        ),
      ),
    );
  }
}
