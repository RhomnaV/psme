import 'package:flutter/material.dart';
import 'base_page.dart';
import 'active_membership_page.dart';
import 'psme_id_page.dart';

class CogsPage extends StatefulWidget {
  const CogsPage({super.key});

  @override
  State<CogsPage> createState() => _CogsPageState();
}

class _CogsPageState extends State<CogsPage> {
  int _selectedTabIndex = 2; // COGS tab is selected

  void _navigateToTab(int index) {
    if (index == _selectedTabIndex) return;

    if (index == 0) {
      // Navigate to Membership page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ActiveMembershipPage()),
      );
    } else if (index == 1) {
      // Navigate to PSME ID page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PsmeIdPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      selectedIndex: 2, // Membership tab in bottom nav
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile section
              const SizedBox(height: 24),
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              const SizedBox(height: 12),
              const Text(
                'KEVIN PARK',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                'kevinpark@gmail.com',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),

              // Membership tabs
              const SizedBox(height: 24),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _navigateToTab(0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color:
                                _selectedTabIndex == 0
                                    ? const Color(0xFF1A237E)
                                    : Colors.transparent,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Membership',
                            style: TextStyle(
                              color:
                                  _selectedTabIndex == 0
                                      ? Colors.white
                                      : Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _navigateToTab(1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color:
                                _selectedTabIndex == 1
                                    ? const Color(0xFF1A237E)
                                    : Colors.transparent,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'PSME ID',
                            style: TextStyle(
                              color:
                                  _selectedTabIndex == 1
                                      ? Colors.white
                                      : Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _navigateToTab(2),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color:
                                _selectedTabIndex == 2
                                    ? const Color(0xFF1A237E)
                                    : Colors.transparent,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'COGS',
                            style: TextStyle(
                              color:
                                  _selectedTabIndex == 2
                                      ? Colors.white
                                      : Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // COGS Content
              const SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Coming Soon Icon
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.hourglass_empty,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),

                          const SizedBox(height: 24),

                          // Coming Soon Text
                          Text(
                            'Coming Soon',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Description
                          Text(
                            'The Certificate of Good Standing feature is currently under development and will be available soon.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Notification Button
                    SizedBox(
                      width: 250,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Handle notification setup
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'You will be notified when this feature becomes available.',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.notifications),
                        label: const Text(
                          'Notify me when available',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A237E),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
