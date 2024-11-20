import 'package:fitness/controllers/signupcontroller.dart';
import 'package:fitness/services/appconstant.dart';
import 'package:fitness/views/auth/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignUpScreen extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Create Account',
                  style: TextStyles.largeRegular.copyWith(color: AppColors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30,top: 100),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: signUpController.fullName,
                labelText: 'Fullname',
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: signUpController.username,
                labelText: 'Username',
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: signUpController.password,
                labelText: 'Password',
                isPassword: true,
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                     signUpController.signUpWithEmail();
                  },
                  child: Text(
                    'SIGN UP',
                    style: TextStyles.largeBold.copyWith(color:AppColors.accentLight ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}