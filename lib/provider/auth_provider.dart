import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    auth.authStateChanges().listen((User? firebaseUser) async {
      if (firebaseUser != null) {
        _user = await userData(firebaseUser.uid);
      } else {
        _user = null;
      }
      notifyListeners();
    });
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _setLoading(true);

      UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        _user = await userData(result.user!.uid);
      }

      _setLoading(false);
      return _user != null;
    } catch (e) {
      SnackBar(content: Text('Error signing in: ${e.toString()}'));
      _setLoading(false);
      return false;
    }
  }

  Future<bool> signUp(String email, String password, String displayName) async {
    try {
      _setLoading(true);

      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        UserModel newUser = UserModel(
          uid: result.user!.uid,
          email: email,
          displayName: displayName,
          createdAt: DateTime.now(),
        );

        await firestore
            .collection('users')
            .doc(result.user!.uid)
            .set(newUser.toMap());

        _user = newUser;
      }

      _setLoading(false);
      return _user != null;
    } catch (e) {
      SnackBar(content: Text('Error signing in: ${e.toString()}'));
      _setLoading(false);
      return false;
    }
  }

  Future<UserModel?> userData(String uid) async {
    try {
      DocumentSnapshot doc = await firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
    _user = null;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
