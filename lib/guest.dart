import 'package:flutter/material.dart';

class GuestPage extends StatelessWidget {
  const GuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Guest Mode")),
      body: const Center(
        child: Text(
          "Welcome, Guest!",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
