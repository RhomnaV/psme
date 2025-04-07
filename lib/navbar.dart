import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String membershipType;

  const Navbar({
    super.key,
    this.userName = "Kevin",
    this.membershipType = "Regular Member",
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF181F6C),
      automaticallyImplyLeading: false,
      toolbarHeight: 90, // Increase height
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // PSME Logo
          Image.asset('assets/logo1.png', height: 60, fit: BoxFit.contain),

          Row(
            children: [
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
                      color: Color(0xFFFFD700),
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
