import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flick_clips/constants.dart';
import 'package:get/get.dart';
import 'package:flick_clips/models/user.dart'
    as model; //since Firebas_auth package also gives us a 'User' so jsut to differentiate between these 2, import it as 'model'
import 'package:image_picker/image_picker.dart';

import '../views/screens/auth/login_screen.dart';
import '../views/screens/home_screen.dart';

class AuthController extends GetxController {

 static AuthController instance = Get.find(); //finds authController and returns an instance of this. Check--> it is used in constants.dart
 
 late Rx<User?> _user;
 late Rx<File?> _pickedImage; //watch video--> 53:10--
 //create a getter to get _pickedImage as it is a private field
 File? get profilePhoto => _pickedImage.value;
 
 User get user => _user.value!;


//for persisiting state
void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

 //to pick profile photo from gallery/camera
 void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture!');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

//upload image to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image); //upload image to DB
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //registering the user
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //save user to our authentication and firebase firestore(DB)
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);

        String downloadUrl = await _uploadToStorage(image);

        model.User user = model.User(
          email: email,
          uid: cred.user!.uid,
          name: username,
          profilePhoto: downloadUrl,
        );
         await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
            print('user registered');
      } else {
        Get.snackbar(
          'Error Creating Account',
          'Please enter all the fields',
        );
      }
      
    } catch(e) {
      Get.snackbar('Error creating Account',
          e.toString()); //this snackbar is given to us by 'get' flutter package
    }
  }

  //login user
   void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
            print('user logged in');
      } else {
        Get.snackbar(
          'Error Logging in',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Loggin gin',
        e.toString(),
      );
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }
}
