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
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            label: Text(
              'Logout',
            ),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text('content'),
      ),
    );
  }
}
