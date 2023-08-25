import 'package:ce_store/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthController {
  //Sign Out User

  static Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
    Logger().i("User SignOut");
  }

  //Sign In to user account

  static Future<void> signInToAccount(
      {required String emailAddress, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      Logger().i(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Logger().e('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Logger().e('Wrong password provided for that user.');
      }
    }
  }

  // Create User Account With Email And Password

  Future<void> createUserAccount(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        addUser(value.user!.uid, name, email);
      });

      Logger().i(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Logger().e('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Logger().e('The account already exists for that email.');
      } else if (e.code == "invalid-email") {
        Logger().e('Invalid Email');
      } else if (e.code == "operation-not-allowed") {
        Logger().e('Invalid Email');
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  //send Password reset email

  static Future<void> sedPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    Logger().i("Email Send");
  }

  // save user data

  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  Future<void> addUser(String uid, String name, String email) {
    return users.doc(uid).set({
      "name": name,
      "userImage": "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
      "uid": uid,
      "email": email,
    }).then((value) {
      Logger().i("User Added");
    }).catchError((e) {
      Logger().e(e);
    });
  }

  //fetch user data
  Future<UserModel?> getUserData(String uid) async {
    try {
      DocumentSnapshot userData = await users.doc(uid).get();
      return UserModel.fromMap(userData.data() as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }
}
