import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String fullName;
  String username;
  int weight;
  int height;
  String workoutTime;
  String profileImageUrl;

  UserModel({
    required this.fullName,
    required this.username,
    required this.weight,
    required this.height,
    required this.workoutTime,
    required this.profileImageUrl,
  });

  // Modify the fromMap constructor to handle Timestamps
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'] ?? 'N/A',
      username: map['username'] ?? 'N/A',
      weight: map['weight'] ?? 0,
      height: map['height'] ?? 0,
      profileImageUrl: map['profileImageUrl'] ?? '',
      workoutTime: map['workoutTime'] is Timestamp 
          ? (map['workoutTime'] as Timestamp).toDate().toIso8601String() 
          : map['workoutTime'] ?? '0:00',
    );
  }
}
