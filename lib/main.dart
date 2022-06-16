import 'package:firebase_core/firebase_core.dart';
import 'package:flick_clips/constants.dart';
import 'package:flick_clips/views/screens/auth/login_screen.dart';
import 'package:get/get.dart';
import 'package:flick_clips/views/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';

import 'controllers/auth_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController()); //written this for state management(persisting state--> agr user ne ek baar sign kiya aur app band kr dia, to dobara jab user app start kare to dobara credentials daalke sign-in na krna pade)
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: 'Flick Clips',
      debugShowCheckedModeBanner: false,
      theme:ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      // home:  Text( 'Flutter Demo Home Page'),
      home: SignupScreen(),
    );
  }
}
