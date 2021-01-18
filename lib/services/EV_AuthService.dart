import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  User user = FirebaseAuth.instance.currentUser;

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return 'Signed in';
    } on FirebaseAuthException catch (e){
      throw e;
    }
  }

  // Future signUp(String email, String password) async 
  // {
  //   try 
  //   {
  //     await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  //     return "Signed up";
  //   }
  //   catch (e) 
  //   {
  //     print("$e");
  //   }
  // }

  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return "Signed out.";
    } on FirebaseAuthException catch (e){
      throw e;
    }
  }

  Future<String> verifyEmail() async {
    try{
      if (!user.emailVerified){
        await user.sendEmailVerification();
        return 'Verification email sent.';
      }
    } on FirebaseAuthException catch (e){
      throw e;
    }
    return 'E-mail already verified.';
  }
}