import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class FirebaseAuthDataSource {
  Future<UserModel> signUp(String email, String password);
  Future<UserModel> signIn(String email, String password);
  Future<void> updateFcmToken(String uid);
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseMessaging _messaging;

  FirebaseAuthDataSourceImpl(
      this._auth,
      this._firestore,
      this._messaging,
      );

  @override
  Future<UserModel> signUp(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user!;
      final userModel = UserModel(uid: user.uid, email: user.email!);

      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(userModel.toMap());
      await updateFcmToken(user.uid);

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Unknown Firebase error (signUp)');
    }
  }

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user!;

      final doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .get();

      if (!doc.exists) {
        throw ServerException('User record not found in Firestore');
      }
      await updateFcmToken(user.uid);
      return UserModel.fromMap(doc.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Unknown Firebase error (signIn)');
    }
  }

  @override
  Future<void> updateFcmToken(String uid) async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    try {
      final token = await _messaging.getToken();
      print("The token is $token");
      if (token == null) return;
      await _firestore
          .collection('users')
          .doc(uid)
          .update({'fcmToken': token});
    } catch (_) {
      throw ServerException('Failed to update FCM token');
    }
  }
}
