import 'package:best_people/screens/PersonDetails.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Listviewitem extends StatelessWidget {
  const Listviewitem(
      {super.key,
      required this.imgUrl,
      required this.familyName,
      required this.location,
      required this.rating,
      required this.firstName});

  final imgUrl;
  final firstName;
  final familyName;
  final location;
  final rating;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Center(
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
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Persondetails(
                familyName: familyName,
                firstName: firstName,
                imgUrl: "",
                location: location,
                rating: rating)));
      },
    );
  }
}
