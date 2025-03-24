import 'package:flutter/material.dart';
import 'navbar.dart';
import 'footer.dart';
import 'home_page.dart';
import 'profile.dart';
import 'membership.dart';

class BasePage extends StatefulWidget {
  final Widget body;
  final String title;
  final int selectedIndex;
  final String userName;
  final String membershipType;

  const BasePage({
    super.key,
    required this.body,
    this.title = '',
    this.selectedIndex = 0,
    this.userName = 'Kevin',
    this.membershipType = 'Regular Member',
  });

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MembershipPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        userName: widget.userName,
        membershipType: widget.membershipType,
      ),
      body: widget.body,
      bottomNavigationBar: Footer(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
