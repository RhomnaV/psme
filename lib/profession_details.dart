import 'package:flutter/material.dart';
import 'navbar.dart';
import 'prc_license.dart'; // We'll create this file next

class ProfessionDetailsPage extends StatefulWidget {
  const ProfessionDetailsPage({super.key});

  @override
  State<ProfessionDetailsPage> createState() => _ProfessionDetailsPageState();
}

class _ProfessionDetailsPageState extends State<ProfessionDetailsPage> {
  // Form controllers
  final _prcLicenseController = TextEditingController();
  final _boardExamController = TextEditingController();
  final _sideNumberController = TextEditingController();

  @override
  void dispose() {
    _prcLicenseController.dispose();
    _boardExamController.dispose();
    _sideNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(userName: "Kevin", membershipType: "Regular Member"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Profile image
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFFF0F0FF),
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),

              const SizedBox(height: 16),

              // User name and email
              const Text(
                'KEVIN PARK',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'kevin@gmail.com',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 30),

              // Profession Details title
              const Text(
                'Profession Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 24),

              // PRC License dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'PRC License',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    hint: const Text('Select PRC license'),
                    items: const [
                      DropdownMenuItem(
                        value: 'Professional Mechanical Engineer',
                        child: Text('Professional Mechanical Engineer'),
                      ),
                      DropdownMenuItem(
                        value: 'Registered Mechanical Engineer',
                        child: Text('Registered Mechanical Engineer'),
                      ),
                      DropdownMenuItem(
                        value: 'Certified Plant Mechanic',
                        child: Text('Certified Plant Mechanic'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _prcLicenseController.text = value ?? '';
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Board Exam dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Board Exam',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    hint: const Text('Select board exam'),
                    items: const [
                      DropdownMenuItem(
                        value: 'Mechanical Engineering Board Exam',
                        child: Text('Mechanical Engineering Board Exam'),
                      ),
                      DropdownMenuItem(
                        value: 'Plant Mechanic Licensure Exam',
                        child: Text('Plant Mechanic Licensure Exam'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _boardExamController.text = value ?? '';
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // SISE Graduate field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SISE Graduate',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter SISE graduate details',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Side Number field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Side Number',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _sideNumberController,
                    decoration: InputDecoration(
                      hintText: 'Enter side number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Validate form
                    if (_prcLicenseController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PRCLicensePage(),
                        ),
                      );
                    } else {
                      // Show error
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a PRC license'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A0F44),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('CONTINUE'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back', style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
