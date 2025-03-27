import 'package:flutter/material.dart';
import '../base_page.dart';
import '../navbar.dart';
import '../footer.dart';
import 'profile_professional.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _selectedTab = 'Personal'; // Default to Personal tab
  bool _isEditingPersonal = false;

  // Form controllers for personal editing mode
  final _firstNameController = TextEditingController(text: 'KEVIN');
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController(text: 'PARK');
  final _emailController = TextEditingController(text: 'kevin@gmail.com');
  final _alternativeAddressController = TextEditingController();
  final _phoneController = TextEditingController(text: '9267126759');
  final _mobileController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _socialMediaController = TextEditingController();
  final _socialMediaIdController = TextEditingController();
  final _birthDateController = TextEditingController(text: '01/15/1990');

  // Dropdown values
  String? _selectedSex = 'Male';
  String? _selectedTitle;
  String? _selectedSuffix;
  String? _selectedMaritalStatus;
  String? _selectedBloodType;
  String? _selectedChapter = 'Marinduque';
  String? _selectedCountry;
  String? _selectedProvince;
  String? _selectedCity;
  String? _selectedPhoneCode = '+62';
  String? _selectedMobileCode = '+62';
  String? _selectedSocialMedia = 'Facebook';

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

  // Social media platform options
  final List<String> _socialMediaPlatforms = [
    'Facebook',
    'Twitter',
    'Instagram',
    'LinkedIn',
    'YouTube',
  ];

  // User data for display mode
  final Map<String, String> _userData = {
    'Control No.': '5437812',
    'Date of Birth': '01/15/1990',
    'Phone Number': '09267126759',
    'Current Address': 'Marinduque City, Philippines',
    'Chapter': 'Marinduque',
    'Sex': 'Male',
  };

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _alternativeAddressController.dispose();
    _phoneController.dispose();
    _mobileController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _postalCodeController.dispose();
    _socialMediaController.dispose();
    _socialMediaIdController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  void _togglePersonalEditMode() {
    setState(() {
      _isEditingPersonal = !_isEditingPersonal;
    });
  }

  void _switchTab(String tabName) {
    setState(() {
      _selectedTab = tabName;
      _isEditingPersonal = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use BasePage for consistent layout
    return BasePage(
      selectedIndex: 1, // Profile tab
      body: Column(
        children: [
          // Profile tabs
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
              ),
            ),
            child: Row(
              children: [
                _buildProfileTab('Personal'),
                _buildProfileTab('Professional'),
              ],
            ),
          ),

          // Profile content based on selected tab
          Expanded(
            child:
                _selectedTab == 'Personal'
                    ? _isEditingPersonal
                        ? _buildPersonalEditForm()
                        : _buildPersonalInfoView()
                    : const ProfessionalTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab(String tabName) {
    final bool isSelected = _selectedTab == tabName;

    return Expanded(
      child: InkWell(
        onTap: () => _switchTab(tabName),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    isSelected ? const Color(0xFF181F6C) : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Center(
            child: Text(
              tabName,
              style: TextStyle(
                color: isSelected ? const Color(0xFF181F6C) : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Personal Information container
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
                        radius: 50,
                        backgroundColor: Color(0xFFF0F0FF),
                        backgroundImage: AssetImage('assets/profile.jpg'),
                        onBackgroundImageError:
                            null, // Add error handler if needed
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'KEVIN PARK',
                        style: TextStyle(
                          fontSize: 20,
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

                      // Personal Information header with edit button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Color(0xFF181F6C),
                            ),
                            onPressed: _togglePersonalEditMode,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // User details
                ..._userData.entries.map(
                  (entry) => _buildInfoItem(entry.key, entry.value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Divider(color: Colors.grey.shade300),
        ],
      ),
    );
  }

  Widget _buildPersonalEditForm() {
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
                  'Personal Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: _togglePersonalEditMode,
                  child: const Text('Cancel'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Member ID field (read-only)
            _buildFormField(label: 'Member ID', hintText: '01', readOnly: true),

            // First Name field
            _buildFormField(
              label: 'First Name',
              controller: _firstNameController,
              hintText: 'Enter your first name',
              required: true,
            ),

            // Middle Name field
            _buildFormField(
              label: 'Middle Name',
              controller: _middleNameController,
              hintText: 'Enter your middle name',
            ),

            // Last Name field
            _buildFormField(
              label: 'Last Name',
              controller: _lastNameController,
              hintText: 'Enter your last name',
              required: true,
            ),

            // Email Address field
            _buildFormField(
              label: 'Email Address',
              controller: _emailController,
              hintText: 'Enter your email address',
              required: true,
              keyboardType: TextInputType.emailAddress,
            ),

            // Alternative Address field
            _buildFormField(
              label: 'Alternative Address',
              controller: _alternativeAddressController,
              hintText: 'Enter alternative address (optional)',
            ),

            // Sex dropdown
            _buildDropdownField(
              label: 'Sex',
              value: _selectedSex,
              items: const ['Male', 'Female', 'Other'],
              onChanged: (value) {
                setState(() {
                  _selectedSex = value;
                });
              },
            ),

            // Title dropdown
            _buildDropdownField(
              label: 'Title',
              value: _selectedTitle,
              items: const ['Mr.', 'Mrs.', 'Ms.', 'Dr.', 'Engr.'],
              onChanged: (value) {
                setState(() {
                  _selectedTitle = value;
                });
              },
            ),

            // Suffix dropdown
            _buildDropdownField(
              label: 'Suffix',
              value: _selectedSuffix,
              items: const ['Jr.', 'Sr.', 'II', 'III', 'IV'],
              onChanged: (value) {
                setState(() {
                  _selectedSuffix = value;
                });
              },
            ),

            // Marital Status dropdown
            _buildDropdownField(
              label: 'Marital Status',
              value: _selectedMaritalStatus,
              items: const ['Single', 'Married', 'Divorced', 'Widowed'],
              onChanged: (value) {
                setState(() {
                  _selectedMaritalStatus = value;
                });
              },
            ),

            // Birth Date field
            _buildDateField(
              label: 'Birth Date',
              controller: _birthDateController,
              required: true,
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
            ),

            // Mobile field with country code dropdown
            _buildPhoneFieldWithCountryCode(
              label: 'Mobile',
              controller: _mobileController,
              hintText: 'Enter your mobile number',
              selectedCode: _selectedMobileCode,
              onCodeChanged: (value) {
                setState(() {
                  _selectedMobileCode = value;
                });
              },
            ),

            // Blood Type dropdown
            _buildDropdownField(
              label: 'Blood Type',
              value: _selectedBloodType,
              items: const ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
              onChanged: (value) {
                setState(() {
                  _selectedBloodType = value;
                });
              },
            ),

            // Chapter dropdown
            _buildDropdownField(
              label: 'Chapter',
              value: _selectedChapter,
              items: const ['Marinduque', 'Manila', 'Cebu', 'Davao', 'Iloilo'],
              onChanged: (value) {
                setState(() {
                  _selectedChapter = value;
                });
              },
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

            // Social Media dropdown with ID field
            _buildSocialMediaField(
              label: 'Social Media',
              controller: _socialMediaIdController,
              hintText: 'Enter your social media ID',
              selectedPlatform: _selectedSocialMedia,
              onPlatformChanged: (value) {
                setState(() {
                  _selectedSocialMedia = value;
                });
              },
            ),

            const SizedBox(height: 24),

            // Save button - using a custom button that works with BasePage
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Save the form data
                  setState(() {
                    _isEditingPersonal = false;
                  });

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF181F6C),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('SAVE CHANGES'),
              ),
            ),
          ],
        ),
      ),
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

  Widget _buildSocialMediaField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required String? selectedPlatform,
    required Function(String?) onPlatformChanged,
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
              // Social media platform dropdown
              Container(
                width: 140,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      value: selectedPlatform,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      onChanged: onPlatformChanged,
                      items:
                          _socialMediaPlatforms.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Social media ID field
              Expanded(
                child: TextFormField(
                  controller: controller,
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

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
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
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                controller.text =
                    "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
              }
            },
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
