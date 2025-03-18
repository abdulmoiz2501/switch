import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/repository/auth_repository.dart';
import '../models/user_model.dart';
import '../source/firebase_auth_data_source.dart';


class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<UserModel> signUp(String email, String password) async {
    try {
      print("The email is $email and the password is while signup $password");
      final user = await dataSource.signUp(email, password);
      return user;
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      print("The email is $email and the password is while signin $password");
      final user = await dataSource.signIn(email, password);
      return user;
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> updateFcmToken(String uid) async {

    try {
      print("the uid is $uid");
      await dataSource.updateFcmToken(uid);
      print("The fcm token is updated");
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
