import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


// Authentication service deployment
class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser user;

  Future<FirebaseUser> signOut() async {
    FirebaseUser user = await _auth.currentUser();
    if(user.providerData[1].providerId == 'google.com'){
      await _googleSignIn.disconnect();
    }
    await _auth.signOut();

  }


  //Google SignIn deployment

  Future<FirebaseUser> googleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );




    FirebaseUser user = await _auth.signInWithCredential(credential);

    print("Sign in " + user.displayName);
    print("Sign in " + user.email);

    return user;
  }


// Login using firebase authentication

  Future login(String email, String password)async{
    try{
      FirebaseUser user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return user;


    }catch(e){
      print(e.toString());
    }
  }

  //Reset password using firebase authentication

  Future resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }





}