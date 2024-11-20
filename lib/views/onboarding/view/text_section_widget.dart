import 'package:fitness/services/appconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TextSectionWidget extends StatelessWidget {
  final PageController pageController = PageController();

  final List<String> pages = [
    "Receive Daily Workouts that will maximise Fat Burning and Toning in time effective sessions",
    "Personalized Meal Plans to complement your workouts",
    "Track Your Progress with detailed statistics"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       const Text('Daily Workouts',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
       const SizedBox(height: 8),
        SizedBox(
          height: 70, // Set a fixed height for text area
          child: PageView.builder(
            controller: pageController,
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    pages[index],
                    textAlign: TextAlign.center,
                    style:const TextStyle(fontSize: 16),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        SmoothPageIndicator(
          controller: pageController,  // PageView controller
          count: pages.length,
          effect: const WormEffect(
            activeDotColor: AppColors.accentLight,  // Active dot color
            dotColor: Colors.grey,        // Inactive dot color
            dotHeight: 8,spacing: 3,
            dotWidth: 8,
          ),
        ),
      ],
    );
  }
}
