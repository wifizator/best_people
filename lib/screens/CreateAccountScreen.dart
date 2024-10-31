import 'package:best_people/screens/MainAppScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';

final _firebase = FirebaseAuth.instance;

class Createaccountscreen extends StatefulWidget {
  const Createaccountscreen({super.key});

  @override
  State<Createaccountscreen> createState() => _CreateaccountscreenState();
}

class _CreateaccountscreenState extends State<Createaccountscreen> {
  var inputEmail = "";

  var inputPhoneNumber = "";

  var inputFirstName = "";

  var inputFamilyName = "";

  var inputPassword = "";

  final inputFormKey = GlobalKey<FormState>();

  void createFireBaseAccount() async {
    final isValid = inputFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    inputFormKey.currentState!.save();

    context.loaderOverlay.show();
    try {
      //sign in
      var _userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: inputEmail, password: inputPassword);

      //create new doc with uid as name
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userCredentials.user!.uid)
          .set({
        // 'username': _enteredUsername,
        'email': inputEmail,
        'first_name': inputFirstName,
        'family_name': inputFamilyName,
        'phone_number': inputPhoneNumber,
        // 'image_url': imageUrl,
      });

      //workarround, go back, this way the streambuilder gets the handling.
      Navigator.of(context).pop();

    } on Exception catch (error) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString() ?? 'Eroare creare cont')));
    }
    context.loaderOverlay.hide();
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
                    key: inputFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Nume de familie',
                          ),
                          keyboardType: TextInputType.name,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              //invalid
                              return 'Introdu un nume de familie valid';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            inputFamilyName = newValue!;
                          },
                          onChanged: (value) {
                            inputFamilyName = value!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Prenume',
                          ),
                          keyboardType: TextInputType.name,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              //invalid
                              return 'Introdu un prenume valid';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            inputFirstName = newValue!;
                          },
                          onChanged: (value) {
                            inputFirstName = value!;
                          },
                        ),
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
                          decoration: const InputDecoration(
                            label: Text('Telefon'),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !RegExp("^(?:[+0]9)?[0-9]{10}")
                                    .hasMatch(value)) {
                              //invalid
                              return 'Introdu un numar de telefon valid';
                            }
                            return null;
                          },
                          autocorrect: false,
                          keyboardType: TextInputType.phone,
                          onSaved: (newValue) {
                            inputPhoneNumber = newValue!;
                          },
                          onChanged: (value) {
                            inputPhoneNumber = value!;
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
                              return 'Introdu o parola valida, min. 6 caractere';
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
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text('Repeta parola'),
                          ),
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 6 ||
                                value != inputPassword) {
                              return 'Parolele nu coincid';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: createFireBaseAccount,
                          child: Text('Crează cont'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Ai deja cont? Logheaza-te'),
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
