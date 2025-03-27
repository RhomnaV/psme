import 'package:flutter/material.dart';
import 'base_page.dart';
import 'new_membership.dart';
import 'shared_state.dart';
import 'active_membership_page.dart'; // Import the new page

class MembershipPage extends StatefulWidget {
  const MembershipPage({super.key});

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  @override
  Widget build(BuildContext context) {
    // If membership is confirmed, navigate to the active membership page
    if (SharedState.isMembershipConfirmed) {
      // Use a post-frame callback to avoid build issues
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ActiveMembershipPage()),
        );
      });

      // Return a loading indicator while navigating
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Otherwise, show the default membership UI
    return BasePage(
      selectedIndex: 2, // Membership tab
      body: Container(
        color: Colors.white, // Explicit white background
        width: double.infinity,
        height: double.infinity, // Ensure it fills the entire height
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Main content with proper spacing
              Container(
                color:
                    Colors
                        .white, // Additional white background to ensure coverage
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      // Profile image - smaller size to match design
                      const CircleAvatar(
                        radius: 30, // Smaller radius
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),

                      const SizedBox(height: 16),

                      // User name - smaller font size
                      const Text(
                        'KEVIN PARK',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      // Email - smaller and lighter
                      const Text(
                        'kevin@gmail.com',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),

                      const SizedBox(height: 30),

                      // Society text - left aligned in the center column
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

                      // Membership text - left aligned in the center column
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Sign up for a membership and be part of us!',
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // New Membership button - smaller width
                      SizedBox(
                        width: 150, // Smaller width to match design
                        height: 36, // Explicit height
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
                            backgroundColor: const Color(
                              0xFF181F6C,
                            ), // Dark blue
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

                      // Already have membership text - center aligned
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

                      // Claim Membership button - smaller width
                      SizedBox(
                        width: 150, // Smaller width to match design
                        height: 36, // Explicit height
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle claim membership
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFFE0E0E0,
                            ), // Light gray
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

                      // Add extra space at the bottom to ensure white background extends
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
