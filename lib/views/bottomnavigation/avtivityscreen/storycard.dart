// story_card.dart
import 'package:flutter/material.dart';

class StoryCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  StoryCard({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error), // Fallback if image fails to load
            ),
          ),
          

Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 35,
                                width: double.infinity,
                                decoration:const BoxDecoration(
                                  color: Color.fromARGB(100, 22, 44, 33),
                          
                                ),
                                child: Center(
                                  child: Text(
                                    name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Roboto-Regular',
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ), 
        ],
      ),
    );
  }
}
