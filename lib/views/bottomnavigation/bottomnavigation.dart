import 'package:fitness/services/appconstant.dart';
import 'package:fitness/views/bottomnavigation/allactivity.dart';
import 'package:fitness/views/bottomnavigation/heightweight.dart';
import 'package:fitness/views/bottomnavigation/homescreen.dart';
import 'package:fitness/views/bottomnavigation/settingscreen.dart';
import 'package:fitness/views/bottomnavigation/watercount.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
class Bottomnavigation extends StatelessWidget {
  const Bottomnavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavigationController controller = Get.put(BottomNavigationController());

    final List<Widget> screens = [
      VideoListScreen(),
      WaveWidget(),
      ActivityScreen(),
      Userheightweight(),
      SettingsScreen(),
    ];

    return Obx(() => Scaffold(
          body: screens[controller.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: AppColors.accent,
            onTap: controller.onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.badge_outlined,),
                activeIcon:Icon(Icons.badge_rounded,) ,
                label: ''
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.water_drop_outlined,),
                activeIcon: Icon(Icons.water_drop,),
                   label: ''
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.directions_run),
                   label: ''
              ),
              
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon:  Icon(Icons.person),
                   label: ''
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                   label: ''
              ),
            ],
          ),
        ));
  }
}



