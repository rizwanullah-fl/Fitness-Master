
import 'package:fitness/controllers/authcontroller.dart';
import 'package:fitness/controllers/usercontroller.dart';
import 'package:fitness/services/appconstant.dart';
import 'package:fitness/views/bottomnavigation/avtivityscreen/createStory.dart';
import 'package:fitness/views/userdata/heightscreen.dart';
import 'package:fitness/views/userdata/timeScreen.dart';
import 'package:fitness/views/userdata/weightscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
    final AuthController authController = Get.put(AuthController());
  final UserController userController = Get.put(UserController());
  SettingsScreen() {
    userController.fetchUserData(); // Call fetchUserData to refresh data on screen open
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Profile Section
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Obx(() {
      return CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey[300],
        backgroundImage: userController.user.value.profileImageUrl.isNotEmpty
            ? NetworkImage(userController.user.value.profileImageUrl)
            : null,
        child: userController.user.value.profileImageUrl.isEmpty
            ? const Icon(Icons.person, size: 60, color: Colors.white)
            : null,
      );
    }),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
        onTap: () {
          userController.pickImage();
        },
                        child:const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.camera_alt, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
               const SizedBox(height: 10),
              Obx(() => Text(
                  userController.user.value.fullName, // Dynamic fullName
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
                Obx(() => Text(
                  userController.user.value.username, // Dynamic username
                  style:const TextStyle(color: Colors.grey),
                )),
              ],
            ),
          ),
     const     SizedBox(height: 20),
          // Settings Options
          Expanded(
            child: ListView(
              children: [
                // Workout Reminder
          Obx(()=>     _buildSettingsItem(
  icon: Icons.access_time,
  title: 'Workout Reminder',
  value: userController.formattedWorkoutTime,
  valueColor: AppColors.accent,
  onTap: () {
    Get.to(() => TimeScreen(isEditMode: true));
  },
),),
Obx(()=>_buildSettingsItem(
  icon: Icons.fitness_center,
  title: 'Weight',
  value: '${userController.user.value.weight} kg',
  valueColor: AppColors.accent,
  onTap: () {
    Get.to(() => WeightScreen(isEditMode: true));
  },
),),
Obx(()=>_buildSettingsItem(
  icon: Icons.height,
  title: 'Height',
  value: '${userController.user.value.height} cm',
  valueColor: AppColors.accent,
  onTap: () {
    Get.to(() => HeightScreen(isEditMode: true));
  },
),),

                // Invite Friends
                _buildSettingsItem(
                  icon: Icons.share,
                  title: 'Invite Friends',
                ),

                // Contact Us
                _buildSettingsItem(
                  icon: Icons.support_agent,
                  title: 'Contact Us',
                ),
                _buildSettingsItem(
                  icon: Icons.create,
                  title: 'Create Story',
                  onTap: (){
                 Get.to(() => CreateStoryScreen());
                  }
                ),
                _buildSettingsItem(
                  icon: Icons.upload,
                  title: 'Upload Exercise Videos',
                  onTap: (){
                     Get.toNamed('/Upload-Screen');
                  }
                ),
                 _buildSettingsItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: (){
                    authController.signOut();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for individual settings items
  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    String? value,
    Color? valueColor,
    VoidCallback? onTap,

  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null)
            Text(
              value,
              style: TextStyle(
                color: valueColor ?? Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
         const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
        ],
      ),
      onTap: onTap
    );
  }
}
