import 'package:flutter/material.dart';
import 'base_page.dart';
import 'new_membership.dart';
import 'shared_state.dart';
import 'active_membership_page.dart';

class MembershipPage extends StatefulWidget {
  const MembershipPage({super.key});

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  @override
  Widget build(BuildContext context) {
    if (SharedState.isMembershipConfirmed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ActiveMembershipPage()),
        );
      });

      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return BasePage(
      selectedIndex: 2,
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),

                      const SizedBox(height: 16),
                      const Text(
                        'KEVIN PARK',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        'kevin@gmail.com',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),

                      const SizedBox(height: 30),

                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'New to our society?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Sign up for a membership and be part of us!',
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        width: 150,
                        height: 36,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NewMembershipPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF181F6C),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Text(
                            'New Membership',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        'If you already have a membership, you may activate',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                      const Text(
                        'it in our new system.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        width: 150,
                        height: 36,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE0E0E0),
                            foregroundColor: Colors.black87,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Text(
                            'Claim Membership',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
