import 'package:flutter/material.dart';
import 'base_page.dart';
import 'psme_id.dart';

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

  @override
  Widget build(BuildContext context) {
    return BasePage(
      selectedIndex: 2, // Membership tab
      body: Container(
        color: Colors.white, // Ensure white background
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Profession Details title
                const Text(
                  'Profession Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // PRC License section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'PRC License',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: _showAddLicenseDialog,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: Color(0xFF181F6C),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Subtitle text
                Text(
                  'You may add or edit multiple PRC License and check them below',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),

                const SizedBox(height: 16),

                // License cards
                ..._licenses.asMap().entries.map(
                  (entry) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () => _showEditLicenseDialog(entry.key),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
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
                                    entry.value['number'] ?? '',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${entry.value['registration']} - ${entry.value['expiration']}',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.content_copy,
                                color: Colors.grey,
                                size: 18,
                              ),
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Next button - yellow color
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to PSME ID page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PsmeIdPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD600), // Yellow color
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
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
        width: 350,
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // PRC License Type
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'PRC License Type',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      value:
                          _licenseTypeController.text.isNotEmpty
                              ? _licenseTypeController.text
                              : null,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        border: InputBorder.none,
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      hint: const Text('Select license type'),
                      isExpanded: true,
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
                          _licenseTypeController.text = value ?? '';
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // License Number
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'License Number',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextFormField(
                    controller: _licenseNumberController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 14),
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Registration Date
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'Registration Date',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextFormField(
                    controller: _registrationDateController,
                    decoration: const InputDecoration(
                      hintText: 'MM/DD/YYYY',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.calendar_today, size: 18),
                    ),
                    style: const TextStyle(fontSize: 14),
                    textAlignVertical: TextAlignVertical.center,
                    readOnly: true,
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _registrationDateController.text =
                              "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
                        });
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Expiry Date
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'Expiry Date',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextFormField(
                    controller: _expiryDateController,
                    decoration: const InputDecoration(
                      hintText: 'MM/DD/YYYY',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.calendar_today, size: 18),
                    ),
                    style: const TextStyle(fontSize: 14),
                    textAlignVertical: TextAlignVertical.center,
                    readOnly: true,
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _expiryDateController.text =
                              "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
                        });
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Add/Save License button
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF181F6C),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  title == 'Add New License' ? 'Add License' : 'Save License',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
