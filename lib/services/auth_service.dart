import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_app/services/database_service.dart';
import 'package:shopping_app/helpers/helper_functions.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future loginWithUserEmailAndPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password, String name ,String address, int phone) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        await DatabaseService(userId: user.uid).savingUserData(email, name, address, phone);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  Future signOut()async{
    try{
      await HelperFunctions.saveUserNameSP("");
      await HelperFunctions.saveUserEmailSP("");
      await HelperFunctions.saveUserAddressSP("");
      await HelperFunctions.saveUserPhoneSP(0);
      await HelperFunctions.saveUserLoggedInStatus(false);
    }catch(error){
      return null;
    }
  }
}
