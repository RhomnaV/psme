import 'package:flutter/material.dart';
import 'navbar.dart';
import 'membership.dart';

class PRCLicensePage extends StatefulWidget {
  const PRCLicensePage({super.key});

  @override
  State<PRCLicensePage> createState() => _PRCLicensePageState();
}

class _PRCLicensePageState extends State<PRCLicensePage> {
  // List of licenses
  final List<Map<String, String>> _licenses = [
    {
      'type': 'Professional Mechanical Engineer',
      'number': '5512',
      'registration': '02/18/2024',
      'expiration': '02/18/2025',
    },
    {
      'type': 'Registered Mechanical Engineer',
      'number': '2341',
      'registration': '02/18/2024',
      'expiration': '02/18/2025',
    },
    {
      'type': 'Certified Plant Mechanic',
      'number': '56334',
      'registration': '02/18/2024',
      'expiration': '02/18/2025',
    },
  ];

  // Form controllers for adding/editing licenses
  final _licenseTypeController = TextEditingController();
  final _licenseNumberController = TextEditingController();
  final _registrationDateController = TextEditingController();
  final _expiryDateController = TextEditingController();

  @override
  void dispose() {
    _licenseTypeController.dispose();
    _licenseNumberController.dispose();
    _registrationDateController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }

  void _showAddLicenseDialog() {
    // Clear form fields
    _licenseTypeController.clear();
    _licenseNumberController.clear();
    _registrationDateController.clear();
    _expiryDateController.clear();

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder:
          (context) => _buildLicenseDialog(
            title: 'Add New License',
            onSave: () {
              // Add new license
              setState(() {
                _licenses.add({
                  'type': _licenseTypeController.text,
                  'number': _licenseNumberController.text,
                  'registration': _registrationDateController.text,
                  'expiration': _expiryDateController.text,
                });
              });
              Navigator.pop(context);
            },
          ),
    );
  }

  void _showEditLicenseDialog(int index) {
    // Pre-fill form fields with existing license data
    final license = _licenses[index];
    _licenseTypeController.text = license['type'] ?? '';
    _licenseNumberController.text = license['number'] ?? '';
    _registrationDateController.text = license['registration'] ?? '';
    _expiryDateController.text = license['expiration'] ?? '';

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder:
          (context) => _buildLicenseDialog(
            title: 'Edit License',
            onSave: () {
              // Update existing license
              setState(() {
                _licenses[index] = {
                  'type': _licenseTypeController.text,
                  'number': _licenseNumberController.text,
                  'registration': _registrationDateController.text,
                  'expiration': _expiryDateController.text,
                };
              });
              Navigator.pop(context);
            },
          ),
    );
  }

  void _deleteLicense(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Delete License'),
            content: const Text(
              'Are you sure you want to delete this license?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _licenses.removeAt(index);
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
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

              // PRC License title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'PRC Licenses',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: _showAddLicenseDialog,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0A0F44),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // License cards
              ..._licenses.asMap().entries.map(
                (entry) => InkWell(
                  onTap: () => _showEditLicenseDialog(entry.key),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.value['type'] ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${entry.value['number']} • ${entry.value['expiration']}',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Delete (trash can) icon
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onPressed: () => _deleteLicense(entry.key),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Submit button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Show success message and navigate back to membership page
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Membership application submitted successfully',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // Navigate back to membership page
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MembershipPage(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A0F44),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('SUBMIT'),
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

  Widget _buildLicenseDialog({
    required String title,
    required VoidCallback onSave,
  }) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: 400, // Match Figma width
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // PRC License Type
            _buildDialogField(
              label: 'PRC License Type',
              controller: _licenseTypeController,
              required: true,
              isDropdown: true,
              dropdownItems: const [
                'Professional Mechanical Engineer',
                'Registered Mechanical Engineer',
                'Certified Plant Mechanic',
                'ME Graduate',
              ],
            ),

            const SizedBox(height: 16),

            // License Number
            _buildDialogField(
              label: 'License Number',
              controller: _licenseNumberController,
              required: true,
            ),

            const SizedBox(height: 16),

            // Registration Date
            _buildDialogField(
              label: 'Registration Date',
              controller: _registrationDateController,
              required: true,
              isDate: true,
            ),

            const SizedBox(height: 16),

            // Expiry Date
            _buildDialogField(
              label: 'Expiry Date',
              controller: _expiryDateController,
              required: true,
              isDate: true,
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A0F44),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  title == 'Add New License' ? 'Add License' : 'Save License',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogField({
    required String label,
    required TextEditingController controller,
    bool required = false,
    bool isDate = false,
    bool isDropdown = false,
    List<String>? dropdownItems,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children:
                required
                    ? const [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                    : [],
          ),
        ),
        const SizedBox(height: 8),
        if (isDropdown && dropdownItems != null)
          DropdownButtonFormField<String>(
            value: controller.text.isNotEmpty ? controller.text : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            hint: const Text('Select license type'),
            items:
                dropdownItems.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                controller.text = newValue;
              }
            },
          )
        else if (isDate)
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'MM/DD/YYYY',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              suffixIcon: const Icon(Icons.calendar_today, size: 20),
            ),
            readOnly: true,
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                controller.text =
                    "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
              }
            },
          )
        else
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter $label',
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
    );
  }
}
