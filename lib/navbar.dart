import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String membershipType;

  const Navbar({
    super.key,
    this.userName =
        "Kevin", // Default value, should be replaced with actual user name
    this.membershipType =
        "Regular Member", // Default value, should be replaced with actual membership
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0A0F44), // Dark blue background
      automaticallyImplyLeading: false, // Remove back button
      toolbarHeight: 70, // Increase height
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // PSME Logo
          Image.asset('assets/logo.png', height: 50, fit: BoxFit.contain),

          // User greeting and profile picture
          Row(
            children: [
              // User greeting and membership type
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Hi, $userName!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    membershipType,
                    style: const TextStyle(
                      color: Color(
                        0xFFFFD700,
                      ), // Gold color for membership text
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              // Profile picture
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
