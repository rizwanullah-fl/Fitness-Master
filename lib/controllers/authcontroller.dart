import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/services/appconstant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);
  RxBool isOnboardingComplete = false.obs;

  @override
  void onReady() async {
    super.onReady();
    
    // Check onboarding completion status
    await _checkOnboardingCompletion();

    // Check if user is logged in when app starts
    firebaseUser.value = _auth.currentUser;

    if (firebaseUser.value != null && isOnboardingComplete.value) {
      // If logged in and onboarding is complete, navigate to BottomNavigation screen
      Get.offAllNamed('/Bottom-Screen');
    } else if (isOnboardingComplete.value) {
      // If not logged in but onboarding is complete, go to main screen
      Get.offAllNamed('/');
    } else {
      // If onboarding is not complete, go to onboarding screen
      Get.offAllNamed('/onboarding');
    }

    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      firebaseUser.value = user;
      if (user != null) {
        Get.offAllNamed('/Bottom-Screen');
      } else {
        Get.offAllNamed('/');
      }
    });
  }

  Future<void> _checkOnboardingCompletion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isOnboardingComplete.value = prefs.getBool('onboardingComplete') ?? false;
  }

  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
    isOnboardingComplete.value = true;
  }



  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed('/'); // Navigate to MainScreen on sign out
     Get.snackbar('Success', 'Logout Successfully!',
        backgroundColor: AppColors.warning, colorText: AppColors.white);
  }
}
