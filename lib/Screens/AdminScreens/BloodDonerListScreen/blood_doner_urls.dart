import 'package:cloud_firestore/cloud_firestore.dart';

class BloodDonor {
  final String name;
  final String bloodGroup;
  final String location;
  final String contact;
  final String image_url;
  final int age;
  final String id;
  final bool availability; // Change this to bool

  BloodDonor({
    required this.name,
    required this.bloodGroup,
    required this.location,
    required this.contact,
    required this.image_url,
    required this.age,
    required this.id,
    required this.availability,
  });

  factory BloodDonor.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return BloodDonor(
      id: doc.id,
      name: data['name'] ?? '',
      bloodGroup: data['bloodGroup'] ?? '',
      location: data['location'] ?? '',
      contact: data['contact'] ?? '',
      image_url: data['image_url'] ?? '',
      age: data['age'] ?? 0,
      availability: data['availability'] == 'Available', // Convert to bool
    );
  }
}
