import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String profileImage;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.profileImage = 'assets/profile.jpg', // Default profile image
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(profileImage),
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0), // Add bottom padding
          child: Text(
            email,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
