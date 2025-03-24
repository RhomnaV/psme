import 'package:flutter/material.dart';

class ProfessionalTabContent extends StatefulWidget {
  const ProfessionalTabContent({super.key});

  @override
  State<ProfessionalTabContent> createState() => _ProfessionalTabContentState();
}

class _ProfessionalTabContentState extends State<ProfessionalTabContent> {
  bool _isEditingProfessional = false;

  // Professional information controllers
  final _organizationController = TextEditingController();
  final _professionIdController = TextEditingController();
  final _websiteController = TextEditingController();
  final _phoneController = TextEditingController();
  final _faxController = TextEditingController();
  final _divisionController = TextEditingController();
  final _jobController = TextEditingController();
  final _industryController = TextEditingController();
  final _schoolController = TextEditingController();
  final _highestDegreeController = TextEditingController();
  final _sssNumberController = TextEditingController();
  final _gsisNumberController = TextEditingController();
  final _tinNumberController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _postalCodeController = TextEditingController();

  // Dropdown values
  String? _selectedCountry;
  String? _selectedProvince;
  String? _selectedCity;
  String? _selectedJob;
  String? _selectedIndustry;
  String? _selectedDegree;
  String? _selectedPhoneCode = '+62';
  String? _selectedFaxCode = '+62';

  // Country code options
  final List<String> _countryCodes = [
    '+1',
    '+44',
    '+61',
    '+62',
    '+63',
    '+65',
    '+81',
    '+86',
  ];

  // License form controllers
  final _licenseTypeController = TextEditingController();
  final _licenseNumberController = TextEditingController();
  final _registrationDateController = TextEditingController();
  final _expiryDateController = TextEditingController();

  // Professional data - licenses
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

  @override
  void dispose() {
    _organizationController.dispose();
    _professionIdController.dispose();
    _websiteController.dispose();
    _phoneController.dispose();
    _faxController.dispose();
    _divisionController.dispose();
    _jobController.dispose();
    _industryController.dispose();
    _schoolController.dispose();
    _highestDegreeController.dispose();
    _sssNumberController.dispose();
    _gsisNumberController.dispose();
    _tinNumberController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _postalCodeController.dispose();
    _licenseTypeController.dispose();
    _licenseNumberController.dispose();
    _registrationDateController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }

  void _toggleProfessionalEditMode() {
    setState(() {
      _isEditingProfessional = !_isEditingProfessional;
    });
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
    return _isEditingProfessional
        ? _buildProfessionalEditForm()
        : _buildProfessionalView();
  }

  Widget _buildProfessionalView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Professional Information container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User profile image and name
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Color(0xFFF0F0FF),
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'KEVIN PARK',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'kevin@gmail.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Professional Information header with edit button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Professional Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Color(0xFF0A0F44),
                            ),
                            onPressed: _toggleProfessionalEditMode,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // PRC Licenses container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PRC Licenses section with add button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'PRC Licenses',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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

                const SizedBox(height: 16),

                // License cards - now clickable to edit with delete button
                ..._licenses.asMap().entries.map(
                  (entry) => _buildLicenseItem(entry.value, entry.key),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalEditForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Professional Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: _toggleProfessionalEditMode,
                  child: const Text('Cancel'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Organization field
            _buildFormField(
              label: 'Organization',
              controller: _organizationController,
              hintText: 'Enter your organization',
              required: true,
            ),

            // Profession ID field
            _buildFormField(
              label: 'Profession ID',
              controller: _professionIdController,
              hintText: 'Enter your profession ID',
              required: true,
            ),

            // Website field
            _buildFormField(
              label: 'Website',
              controller: _websiteController,
              hintText: 'Enter your website',
              keyboardType: TextInputType.url,
              required: true,
            ),

            // Country dropdown
            _buildDropdownField(
              label: 'Country',
              value: _selectedCountry,
              items: const [
                'Philippines',
                'United States',
                'Japan',
                'Singapore',
                'Australia',
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                });
              },
            ),

            // Province dropdown
            _buildDropdownField(
              label: 'Province',
              value: _selectedProvince,
              items: const [
                'Metro Manila',
                'Cavite',
                'Laguna',
                'Batangas',
                'Rizal',
                'Quezon',
              ],
              onChanged: (value) {
                setState(() {
                  _selectedProvince = value;
                });
              },
            ),

            // City dropdown
            _buildDropdownField(
              label: 'City',
              value: _selectedCity,
              items: const [
                'Makati',
                'Taguig',
                'Pasig',
                'Quezon City',
                'Manila',
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCity = value;
                });
              },
            ),

            // Address 1 field
            _buildFormField(
              label: 'Address 1',
              controller: _address1Controller,
              hintText: 'Enter your address',
            ),

            // Address 2 field
            _buildFormField(
              label: 'Address 2',
              controller: _address2Controller,
              hintText: 'Enter additional address information',
            ),

            // Postal Code field
            _buildFormField(
              label: 'Postal Code',
              controller: _postalCodeController,
              hintText: 'Enter your postal code',
              keyboardType: TextInputType.number,
            ),

            // Phone field with country code dropdown
            _buildPhoneFieldWithCountryCode(
              label: 'Phone',
              controller: _phoneController,
              hintText: 'Enter your phone number',
              selectedCode: _selectedPhoneCode,
              onCodeChanged: (value) {
                setState(() {
                  _selectedPhoneCode = value;
                });
              },
              required: true,
            ),

            // Fax field with country code dropdown
            _buildPhoneFieldWithCountryCode(
              label: 'Fax',
              controller: _faxController,
              hintText: 'Enter your fax number',
              selectedCode: _selectedFaxCode,
              onCodeChanged: (value) {
                setState(() {
                  _selectedFaxCode = value;
                });
              },
            ),

            // Division/Department/Area/Branch field
            _buildFormField(
              label: 'Division Department Area Branch',
              controller: _divisionController,
              hintText: 'Enter your division/department',
            ),

            // Job field
            _buildDropdownField(
              label: 'Job',
              value: _selectedJob,
              items: const [
                'Engineer',
                'Manager',
                'Director',
                'Consultant',
                'Other',
              ],
              onChanged: (value) {
                setState(() {
                  _selectedJob = value;
                });
              },
            ),

            // Industry field
            _buildDropdownField(
              label: 'Industry',
              value: _selectedIndustry,
              items: const [
                'Manufacturing',
                'Construction',
                'Energy',
                'Automotive',
                'Other',
              ],
              onChanged: (value) {
                setState(() {
                  _selectedIndustry = value;
                });
              },
            ),

            // School field
            _buildFormField(
              label: 'School',
              controller: _schoolController,
              hintText: 'Enter your school',
            ),

            // Highest Degree field
            _buildDropdownField(
              label: 'Highest Degree',
              value: _selectedDegree,
              items: const ['Bachelor', 'Master', 'PhD', 'Other'],
              onChanged: (value) {
                setState(() {
                  _selectedDegree = value;
                });
              },
            ),

            // SSS Number field
            _buildFormField(
              label: 'SSS Number',
              controller: _sssNumberController,
              hintText: 'Enter your SSS number',
            ),

            // GSIS Number field
            _buildFormField(
              label: 'GSIS Number',
              controller: _gsisNumberController,
              hintText: 'Enter your GSIS number',
            ),

            // TIN Number field
            _buildFormField(
              label: 'TIN Number',
              controller: _tinNumberController,
              hintText: 'Enter your TIN number',
            ),

            const SizedBox(height: 24),

            // Save button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Save the form data
                  setState(() {
                    _isEditingProfessional = false;
                  });

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Professional information updated successfully',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A0F44),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('SAVE'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLicenseItem(Map<String, String> license, int index) {
    return InkWell(
      onTap: () => _showEditLicenseDialog(index),
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
                    license['type'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${license['number']} • ${license['expiration']}',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
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
              onPressed: () => _deleteLicense(index),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
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

  Widget _buildFormField({
    required String label,
    TextEditingController? controller,
    required String hintText,
    bool required = false,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
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
          TextFormField(
            controller: controller,
            readOnly: readOnly,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              filled: readOnly,
              fillColor: readOnly ? Colors.grey.shade200 : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneFieldWithCountryCode({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required String? selectedCode,
    required Function(String?) onCodeChanged,
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Country code dropdown
              Container(
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      value: selectedCode,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      onChanged: onCodeChanged,
                      items:
                          _countryCodes.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                children: [
                                  // You can add a flag icon here if needed
                                  Text(value),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Phone number field
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    String? value,
    required List<String> items,
    required Function(String?) onChanged,
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
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
          DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            hint: Text('Select $label'),
            items:
                items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
