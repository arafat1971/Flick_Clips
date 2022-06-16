import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

//create 'USER' model
class User {
  String name;
  String profilePhoto; // profilePhoto is taken here as string as instead of the image itself, we are storing the downloadURL of the image
  String email;
  String uid; //userID

  User(
      {required this.name,
      required this.email,
      required this.uid,
      required this.profilePhoto});

//this function will return a map of type Map<String,dynamic>
  Map<String, dynamic> toJson() => {
        "name": name,
        "profilePhoto": profilePhoto,
        "email": email,
        "uid": uid,
      };

//this funtion create a 'User' from the snapshot
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot['email'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      name: snapshot['name'],
    );
  }
}