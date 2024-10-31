import 'package:best_people/screens/CreateAccountScreen.dart';
import 'package:best_people/screens/MainAppScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var inputEmail;

  var inputPassword;

  void loginFireBase() async
  {
    try {
        context.loaderOverlay.show();
        final userCredentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: inputEmail, password: inputPassword);

        context.loaderOverlay.hide();
        // Navigator.of(context).push(MaterialPageRoute(builder:(context) => const MainAppScreen(),));
      } on FirebaseException catch (error) {
        context.loaderOverlay.hide();
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error.message ?? 'Authentication   Failed')));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderOverlay(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              //invalid
                              return 'Introdu o adresa de email valida';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            inputEmail = newValue!;
                          },
                          onChanged: (value) {
                            inputEmail = value!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text('Parolă'),
                          ),
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 6) {
                              return 'Introdu o parola valida';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            inputPassword = newValue!;
                          },
                          onChanged: (value) {
                            inputPassword = value!;
                          },
                        ),
                        ElevatedButton(
                          onPressed: loginFireBase,
                          child: Text('Login'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Createaccountscreen(),
                              ),
                            );
                          },
                          child: Text('Crează cont'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
