import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Listviewitem extends StatelessWidget {
  const Listviewitem({super.key, required this.imgUrl,required this.familyName,required this.location, required this.rating, required this.firstName});

  final imgUrl;
  final firstName;
  final familyName;
  final location;
  final rating;

  @override
  Widget build(BuildContext context) {
    // FirebaseStorage.instance
            // .ref()
            // .child('user_images')
            // .child('${userCredentials.user!.uid}.jpg');
    return Center(
      child: Row(
        children: [
          imgUrl == null
              ? Image.network(imgUrl)
              : Icon(Icons.account_circle_outlined),
              Column(
                children: [
                  Text('${firstName} ${familyName}'),
                  Text(location),
                  Text(rating),
                ],
              ),
        ],
      ),
    );
  }
}
