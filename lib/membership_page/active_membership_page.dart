import 'package:flutter/material.dart';
import '../header_footer/base_page.dart';
import '../header_footer/profile_header.dart';
import '../psme_id_page/psme_id_page.dart';
import '../cogs_page/cogs_page.dart';

class ActiveMembershipPage extends StatefulWidget {
  const ActiveMembershipPage({super.key});

  @override
  State<ActiveMembershipPage> createState() => _ActiveMembershipPageState();
}

class _ActiveMembershipPageState extends State<ActiveMembershipPage> {
  int _selectedTabIndex = 0;

  void _navigateToTab(int index) {
    if (index == _selectedTabIndex) return;

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PsmeIdPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CogsPage()),
      );
    }
  }

  void _showComingSoonDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.hourglass_empty,
                  size: 80,
                  color: Colors.grey.shade400,
                ),

                const SizedBox(height: 24),

                Text(
                  'Coming Soon',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'The Certificate of Good Standing feature is currently under development and will be available soon.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      selectedIndex: 2,
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ProfileHeader(name: 'KEVIN PARK', email: 'kevin@gmail.com'),

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
                                    ? const Color(0xFF181F6C)
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
                                    ? const Color(0xFF181F6C)
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
                                    ? const Color(0xFF181F6C)
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

              const SizedBox(height: 24),

              // Membership Details Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Regular Membership',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF181F6C),
                                    ),
                                  ),
                                  Text(
                                    '(1 Year)',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF181F6C),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Active',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Membership Details
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 18,
                                color: Color(0xFF181F6C),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Registered Date',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Feb 12, 2025',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 18,
                                color: Color(0xFF181F6C),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Expiry Date',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Feb 26, 2026',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 18,
                                color: Color(0xFF181F6C),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Chapter',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Embo',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Certificate Buttons
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF181F6C),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Certificate of Membership',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    GestureDetector(
                      onTap: _showComingSoonDialog,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Certificate of Good Standing',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
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
