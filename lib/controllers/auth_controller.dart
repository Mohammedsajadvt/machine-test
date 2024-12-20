import 'package:get/get.dart';
import 'package:mimo/models/user_model.dart';
import 'package:mimo/services/auth_service.dart';


class AuthController extends GetxController {
  final AuthService authService = Get.put(AuthService());

  var isLoading = false.obs;

  UserModel? get currentUser => authService.currentUser.value;

  Future<void> signUp(String email, String password, String displayName) async {
    isLoading(true);
    await authService.signUp(email, password, displayName);
    isLoading(false);
  }

  Future<void> login(String email, String password) async {
    isLoading(true);
    await authService.login(email, password);
    isLoading(false);
  }

  Future<void> resetPassword(String email) async {
    isLoading(true);
    await authService.resetPassword(email);
    isLoading(false);
  }

  

  Future<void> checkUser() async {
    await authService.checkUser();
  }
}
