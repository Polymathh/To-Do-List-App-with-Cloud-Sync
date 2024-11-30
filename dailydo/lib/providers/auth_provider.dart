import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle()  async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if(googleUser != null){
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);
    }
    return null;
  }

  Future<User?> signUpWithEmail(String email, String password) async{
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<User?> signInWithEmail(String email, String password) async{
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<void> signOut() async{
    await _auth.signOut();
  }
}

