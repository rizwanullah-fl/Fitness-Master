import 'package:fitness/controllers/logincontroller.dart';
import 'package:fitness/services/appconstant.dart';
import 'package:fitness/views/auth/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Log In',
          style: TextStyles.largeRegular.copyWith(color: AppColors.black),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 100),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: loginController.username,
                    labelText: 'Username (Email)',
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: loginController.password,
                    labelText: 'Password',
                    isPassword: true,
                  ),
                  SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        loginController.loginWithEmail(); // Call login function
                      },
                      child: Text(
                        'LOG IN',
                        style: TextStyles.largeBold.copyWith(color: AppColors.accentLight),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Loading Indicator Overlay
          Obx(() {
            if (loginController.isLoading.value) {
              return Container(
                color: Colors.transparent,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.accent,
                  ),
                ),
              );
            } else {
              return SizedBox.shrink(); // Return an empty container when not loading
            }
          }),
        ],
      ),
    );
  }
}