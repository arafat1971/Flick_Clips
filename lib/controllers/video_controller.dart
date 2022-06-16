import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flick_clips/constants.dart';
import 'package:flick_clips/models/video.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit(); //from GetX package--  state management, it runs when the class is first initialized
    _videoList.bindStream( //binding to stream so that things work real-time(displaying of videos as soon as some user uploads)
        firestore.collection('videos').snapshots().map((QuerySnapshot query) {
      List<Video> retVal = [];
      for (var element in query.docs) {
        retVal.add(
          Video.fromSnap(element),
        );
      }
      return retVal;
    }));
  }

  likeVideo(String id) async {
    DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
    var uid = authController.user.uid;

    //if the user has already liked the video and he again presses the 'like' button--> nullify his 'like' action
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]), //removing current user's 'like' from array
      });
    } 
    //else add the uid of the user in the array
    else {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}