import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flick_clips/controllers/auth_controller.dart';
import 'package:flick_clips/views/screens/add_video_screen.dart';
import 'package:flick_clips/views/screens/profile_screen.dart';
import 'package:flick_clips/views/screens/search_screen.dart';
import 'package:flick_clips/views/screens/video_screen.dart';
import 'package:flutter/material.dart';

//screens for bottom navigation bar
List pages=[
  VideoScreen(),
  SearchScreen(),
  const AddVideoScreen(),
  Text('Message Screen'),
  ProfileScreen(uid: authController.user.uid),
];


//COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//CONTROLLERS
var authController= AuthController.instance;