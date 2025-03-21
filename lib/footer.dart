import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.green, // Adjust to your theme
      child: const Center(
        child: Text(
          "© 2025 PSME | All Rights Reserved",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}
