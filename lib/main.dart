import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/controllers/authcontroller.dart';
import 'package:fitness/controllers/signupcontroller.dart';
import 'package:fitness/controllers/usercontroller.dart';
import 'package:fitness/controllers/watercountController.dart';
import 'package:fitness/firebase_options.dart';
import 'package:fitness/services/appconstant.dart';
import 'package:fitness/views/auth/login.dart';
import 'package:fitness/views/auth/signup.dart';
import 'package:fitness/views/bottomnavigation/bottomnavigation.dart';
import 'package:fitness/views/onboarding/onboardingscreen.dart';
import 'package:fitness/views/uploadvideo/uploadvideo.dart';
import 'package:fitness/views/userdata/heightscreen.dart';
import 'package:fitness/views/userdata/timeScreen.dart';
import 'package:fitness/views/userdata/weightscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  Get.put(AuthController());
  Get.put(SignUpController());
  Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fitness',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
        ),
        scaffoldBackgroundColor:AppColors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => MainScreen()),
        GetPage(name: '/create-account', page: () => SignUpScreen()),
        GetPage(name: '/Login-account', page: () => LoginScreen()),
        GetPage(name: '/weight-Screen', page: () => WeightScreen()),
        GetPage(name: '/Height-Screen', page: () => HeightScreen()),
        GetPage(name: '/Time-Screen', page: () => TimeScreen()),
        GetPage(name: '/Bottom-Screen', page: () => const Bottomnavigation()),
        GetPage(name: '/Upload-Screen', page: () => const  Uploadvideo()),
      ],
      initialBinding: BindingsBuilder(() {
        Get.put(WaterLevelController()); // Initialize the controller here
      }),
    );
  }
}