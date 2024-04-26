import 'dart:convert';

class DogModel {
  final String? dogName;
  final String? dogImageLink;
  final String? date;
  final String? id;
  final String? userName;
  final String? lastKey; // Add lastKey property

  DogModel({
    this.dogName,
    this.dogImageLink,
    this.date,
    this.id,
    this.userName,
    this.lastKey, // Include lastKey in the constructor
  });

  factory DogModel.fromJson(Map<String, dynamic> json) {
    return DogModel(
      dogName: json['dog_name'] ?? 'Unknown',
      dogImageLink: json['dog_image_link'] ?? 'No Image',
      date: json['date'] ?? 'Unknown Date',
      id: json['id'],
      userName: json['user_name'] ?? 'Unknown User',
      lastKey: json['last_key'] != null
          ? json['last_key'] as String
          : null, // Assign value to lastKey
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dog_name': dogName,
      'dog_image_link': dogImageLink,
      'date': date,
      'id': id,
      'user_name': userName,
      'last_key': lastKey, // Include lastKey in toJson method
    };
  }

  static List<DogModel> listFromJson(String jsonString) {
    final parsed = jsonDecode(jsonString);

    if (parsed is List && parsed.length >= 2) {
      final List<dynamic> dogList = parsed.first;
      String? lastKey;

      if (parsed[1] != null) {
        lastKey = (parsed[1] as Map<String, dynamic>)['last_key'];
      }

      return dogList.map<DogModel>((json) => DogModel.fromJson(json)).toList();
    } else if (parsed is List && parsed.length == 1) {
      return [];
    } else {
      throw FormatException('Invalid JSON format');
    }
  }
}
