import 'package:best_people/widgets/ListViewItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

class MainAppScreen extends StatelessWidget {
  const MainAppScreen({super.key});

  getFireStoreData() {
    return FirebaseFirestore.instance.collection('users').orderBy('first_name');
  }

  @override
  Widget build(BuildContext context) {
    var userQuery = getFireStoreData();
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
        child: FirestoreListView<Map<String, dynamic>>(
          
          query: userQuery,
          itemBuilder: (context, doc) {
            Map<String, dynamic> user = doc.data();

            return Listviewitem(
              
              imgUrl: "imgUrl", familyName: user['family_name'], location: "location", rating: "rating", firstName: user['first_name']);
          },

          
        ),
      ),
    );
  }
}
