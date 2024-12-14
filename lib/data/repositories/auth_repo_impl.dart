import 'package:atw_task/data/services/auth_firebase.dart';
import 'package:atw_task/domain/repositories/auth_repo.dart';
import 'package:atw_task/service_locater.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl extends AuthRepo {
  @override
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final user =
          await sl<AuthFirebase>().signInWithEmailAndPassword(email, password);
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw Exception('The email address is not valid.');
        case 'user-disabled':
          throw Exception(
              'The user corresponding to the given email has been disabled.');
        case 'user-not-found':
          throw Exception('There is no user corresponding to the given email.');
        case 'wrong-password':
          throw Exception('The password is invalid for the given email.');
        default:
          throw Exception('An undefined Error happened.');
      }
    } catch (e) {
      throw Exception('Failed to sign in with email and password');
    }
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) {
    try {
      final user =
          sl<AuthFirebase>().signUpWithEmailAndPassword(email, password);
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception(
              'The email address is already in use by another account.');
        case 'invalid-email':
          throw Exception('The email address is not valid.');
        case 'operation-not-allowed':
          throw Exception('Email & Password accounts are not enabled.');
        case 'weak-password':
          throw Exception('The password is not strong enough.');
        default:
          throw Exception('An undefined Error happened.');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
