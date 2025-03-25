import 'package:flutter/material.dart';
import 'home_page.dart'; // Ensure this import points to the correct file location

class GuestPage extends StatelessWidget {
  const GuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePage(); // Directly calling HomePage
  }
}
