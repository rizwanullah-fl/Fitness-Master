// story.dart
class Story {
  final String name;
  final String imageUrl;
  final String description;

  Story({
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  factory Story.fromJson(Map<String, dynamic> json, String id) {
    return Story(
      name: json['title'] ?? 'No Name', // Using 'title' from Firestore as 'name' in the model
      imageUrl: json['image'] ?? '',    // Using 'image' from Firestore as 'imageUrl' in the model
      description: json['description'] ?? '',
    );
  }
}
