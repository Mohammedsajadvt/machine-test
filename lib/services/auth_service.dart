import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mimo/models/user_model.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  Future<void> signUp(String email, String password, String displayName) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      await userCredential.user?.updateDisplayName(displayName);

      currentUser.value =UserModel.fromFirebaseUser(userCredential.user!);
    } on FirebaseAuthException catch (e) {
     Get.snackbar("Error", e.message ?? "An error occurred during sign up");
    }
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      currentUser.value =UserModel.fromFirebaseUser(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      // Handle error
      Get.snackbar("Error", e.message ?? "An error occurred during login");
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Password reset email sent!");
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "An error occurred while sending reset email");
    }
  }


  Future<void> checkUser() async {
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      currentUser.value = UserModel.fromFirebaseUser(firebaseUser);
    }
  }
}
