import 'package:best_people/screens/LoginScreen.dart';
import 'package:best_people/widgets/ListViewItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainAppScreen extends StatelessWidget {
  const MainAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Om bun'),
      ),
      drawer: ListView(
        children: [
          TextButton.icon(
            //todo: the logout is not workin?
            onPressed: () async {
              // Navigator.of(context).pop();
              // Navigator.of(context).pop();

              await FirebaseAuth.instance.signOut();
              //todo: see why doesn't go to login automatically,something with firebase.
            },
            label: Text(
              'Logout',
            ),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return const Listviewitem(imgUrl: "imgUrl",familyName: "Family Name",firstName: 'First Name',location: "Iasi, ro",rating: "3",);
          },
        ),
      ),
    );
  }
}
