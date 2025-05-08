import 'package:flutter/material.dart';
import '../header_footer/base_page.dart';
import '../header_footer/navbar.dart';
import '../header_footer/footer.dart';
import 'profile_professional.dart';
import '../services/api_service.dart';
import '../models/country.dart';
import '../models/chapter.dart';
import '../header_footer/profile_header.dart';

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
  String? _selectedChapter;
  String? _selectedCountry;
  String? _selectedProvince;
  String? _selectedCity;
  String? _selectedPhoneCode;
  String? _selectedMobileCode;
  String? _selectedSocialMedia = 'Facebook';

  // Country-related variables
  List<Country> _countries = [];
  bool _isLoadingCountries = true;

  // Chapter-related variables
  List<Chapter> _chapters = [];
  bool _isLoadingChapters = true;

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
    'Control No.': '54970',
    'Date of Birth': '02/12/1990',
    'Phone Number': '09267126759',
    'Current Address': 'Mandaluyong City Philippines',
    'Chapter': 'Mandaluyong',
    'Sex': 'Male',
  };

  @override
  void initState() {
    super.initState();
    _loadCountries(); // Fetch the country list when the page loads
    _loadChapters(); // Fetch the chapter list
  }

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

  Future<void> _loadCountries() async {
    try {
      List<Country> fetchedCountries = await ApiService.fetchCountry();

      // Remove duplicates based on `mobileCode`
      List<Country> uniqueCountries = fetchedCountries.toSet().toList();

      setState(() {
        _countries = uniqueCountries;
        _isLoadingCountries = false;

        // Set a default country (e.g., Philippines)
        Country? defaultCountry = _countries.firstWhere(
          (country) => country.mobileCode == "63",
          orElse:
              () =>
                  _countries.isNotEmpty
                      ? _countries.first
                      : Country(
                        id: 174,
                        name: "Philippines",
                        mobileCode: "63",
                        code: "PH",
                      ),
        );
        _selectedPhoneCode = defaultCountry.mobileCode;
        _selectedMobileCode = defaultCountry.mobileCode;
      });

      print(_countries.map((country) => country.mobileCode).toList());
    } catch (e) {
      setState(() {
        _isLoadingCountries = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load countries: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _loadChapters() async {
    try {
      List<Chapter> fetchedChapters = await ApiService.fetchChapters();

      setState(() {
        _chapters = fetchedChapters;
        _isLoadingChapters = false;

        // Set a default chapter if available
        if (_chapters.isNotEmpty) {
          _selectedChapter =
              _chapters.first.description; // Use the `name` field for display
        }
      });
    } catch (e) {
      setState(() {
        _isLoadingChapters = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load chapters: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              // User profile section
              const ProfileHeader(name: 'KEVIN PARK', email: 'kevin@gmail.com'),

              // Personal/Professional tabs - using the format you provided
              _buildTabSwitcher(),

              const SizedBox(height: 16),

              // Profile content based on selected tab
              _selectedTab == 'Personal'
                  ? _isEditingPersonal
                      ? _buildPersonalEditForm()
                      : _buildPersonalInfoView()
                  : const ProfessionalTabContent(),

              // Add some bottom padding
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Column(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundColor: Color(0xFFF0F0FF),
            backgroundImage: AssetImage('assets/profile.jpg'),
          ),
          const SizedBox(height: 10),
          const Text(
            'KEVIN PARK',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            'kevin@gmail.com',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _switchTab('Personal'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color:
                      _selectedTab == 'Personal'
                          ? const Color(0xFF181F6C)
                          : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Personal',
                  style: TextStyle(
                    color:
                        _selectedTab == 'Personal'
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
              onTap: () => _switchTab('Professional'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color:
                      _selectedTab == 'Professional'
                          ? const Color(0xFF181F6C)
                          : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Professional',
                  style: TextStyle(
                    color:
                        _selectedTab == 'Professional'
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
    );
  }

  Widget _buildPersonalInfoView() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Personal Information container
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Personal Information header with edit button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Color(0xFF181F6C),
                        size: 20,
                      ),
                      onPressed: _togglePersonalEditMode,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // User details in a more compact format
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
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 5),
          Divider(color: Colors.grey.shade300, height: 1),
        ],
      ),
    );
  }

  Widget _buildPersonalEditForm() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Personal Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: _togglePersonalEditMode,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Cancel'),
              ),
            ],
          ),
          const SizedBox(height: 12),

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
          _buildChapterDropdownField(
            label: 'Chapter',
            value: _selectedChapter,
            items: _chapters,
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
            items: const ['Makati', 'Taguig', 'Pasig', 'Quezon City', 'Manila'],
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

          const SizedBox(height: 20),

          // Save button
          SizedBox(
            width: double.infinity,
            height: 40,
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
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text('SAVE CHANGES'),
            ),
          ),
        ],
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
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(
                fontSize: 12,
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
          const SizedBox(height: 5),
          Container(
            color: Colors.white,
            child: TextFormField(
              controller: controller,
              readOnly: readOnly,
              keyboardType: keyboardType,
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(fontSize: 13),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                filled: true,
                fillColor: readOnly ? Colors.grey.shade200 : Colors.white,
              ),
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
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(
                fontSize: 12,
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
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Country code dropdown with flags
              Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(5),
                ),
                child:
                    _isLoadingCountries
                        ? Center(child: CircularProgressIndicator())
                        : DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedCode,
                            isExpanded: true,
                            alignment:
                                Alignment.center, // Center the dropdown items
                            icon: const Icon(Icons.arrow_drop_down, size: 20),
                            iconSize:
                                24, // Adjust the size of the dropdown icon
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                            dropdownColor: Colors.white,
                            onChanged: onCodeChanged,
                            items:
                                _countries
                                    .map(
                                      (country) => DropdownMenuItem<String>(
                                        value: country.mobileCode,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center, // Center the contents
                                          children: [
                                            Text(
                                              countryCodeToEmoji(country.code),
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              "+${country.mobileCode}",
                                              style: const TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
              ),
              const SizedBox(width: 8),
              // Phone number field
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontSize: 13),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(fontSize: 13),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      filled: true,
                      fillColor: Colors.white,
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
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(
                fontSize: 12,
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
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Social media platform dropdown
              Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      value: selectedPlatform,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down, size: 20),
                      style: const TextStyle(color: Colors.black, fontSize: 13),
                      dropdownColor: Colors.white,
                      onChanged: onPlatformChanged,
                      items:
                          _socialMediaPlatforms.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Social media ID field
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: controller,
                    style: const TextStyle(fontSize: 13),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(fontSize: 13),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      filled: true,
                      fillColor: Colors.white,
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
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(
                fontSize: 12,
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
          const SizedBox(height: 5),
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: controller,
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                hintText: 'MM/DD/YYYY',
                hintStyle: const TextStyle(fontSize: 13),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                suffixIcon: const Icon(Icons.calendar_today, size: 18),
                filled: true,
                fillColor: Colors.white,
              ),
              readOnly: true,
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: Color(0xFF181F6C),
                        ),
                        dialogBackgroundColor: Colors.white,
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  controller.text =
                      "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
                }
              },
            ),
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
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(
                fontSize: 12,
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
          const SizedBox(height: 5),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButtonFormField<String>(
              value: value,
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              dropdownColor: Colors.white,
              isExpanded: true,
              hint: Text('Select $label', style: const TextStyle(fontSize: 13)),
              items:
                  items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: const TextStyle(fontSize: 13)),
                    );
                  }).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterDropdownField({
    required String label,
    String? value,
    required List<Chapter> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child:
                _isLoadingChapters
                    ? Center(child: CircularProgressIndicator())
                    : DropdownButtonFormField<String>(
                      value: value,
                      style: const TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      hint: const Text(
                        'Select Chapter',
                        style: TextStyle(fontSize: 13),
                      ),
                      items:
                          items.map((Chapter chapter) {
                            return DropdownMenuItem<String>(
                              value: chapter.description,
                              child: Text(
                                chapter.description ?? 'Unknown',
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                      onChanged: onChanged,
                    ),
          ),
        ],
      ),
    );
  }

  String countryCodeToEmoji(String countryCode) {
    return countryCode.toUpperCase().split('').map((char) {
      return String.fromCharCode(
        0x1F1E6 + char.codeUnitAt(0) - 'A'.codeUnitAt(0),
      );
    }).join();
  }
}
