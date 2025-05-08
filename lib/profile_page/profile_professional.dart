import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/country.dart';

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

  // Country-related variables for phone and fax
  List<Country> _countries = [];
  String? _selectedPhoneCode;
  String? _selectedFaxCode;
  bool _isLoadingCountries = true;

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
  void initState() {
    super.initState();
    _loadCountries(); // Fetch the country list when the page loads
  }

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
        _selectedFaxCode = defaultCountry.mobileCode;
      });
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

  void _toggleProfessionalEditMode() {
    setState(() {
      _isEditingProfessional = !_isEditingProfessional;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child:
            _isEditingProfessional
                ? _buildProfessionalEditForm()
                : _buildProfessionalView(),
      ),
    );
  }

  Widget _buildProfessionalEditForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: _toggleProfessionalEditMode,
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

          const SizedBox(height: 20),

          // Save button
          SizedBox(
            width: double.infinity,
            height: 40,
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
                backgroundColor: const Color(0xFF181F6C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text('SAVE'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
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

  String countryCodeToEmoji(String countryCode) {
    return countryCode.toUpperCase().split('').map((char) {
      return String.fromCharCode(
        0x1F1E6 + char.codeUnitAt(0) - 'A'.codeUnitAt(0),
      );
    }).join();
  }

  Widget _buildProfessionalView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Professional Information container
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Professional Information header with edit button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Professional Information',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Color(0xFF181F6C),
                      size: 20,
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

        // PRC Licenses container
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

              const SizedBox(height: 12),

              // License cards - now clickable to edit with delete button
              ..._licenses.asMap().entries.map(
                (entry) => _buildLicenseItem(entry.value, entry.key),
              ),
            ],
          ),
        ),

        // Add some bottom padding
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildLicenseItem(Map<String, String> license, int index) {
    return InkWell(
      onTap: () => _showEditLicenseDialog(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(5),
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
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${license['number']} • ${license['expiration']}',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                  ),
                ],
              ),
            ),
            // Delete (trash can) icon
            IconButton(
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.grey,
                size: 18,
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

  Widget _buildLicenseDialog({
    required String title,
    required VoidCallback onSave,
  }) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 12),

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

            const SizedBox(height: 12),

            // License Number
            _buildDialogField(
              label: 'License Number',
              controller: _licenseNumberController,
              required: true,
            ),

            const SizedBox(height: 12),

            // Registration Date
            _buildDialogField(
              label: 'Registration Date',
              controller: _registrationDateController,
              required: true,
              isDate: true,
            ),

            const SizedBox(height: 12),

            // Expiry Date
            _buildDialogField(
              label: 'Expiry Date',
              controller: _expiryDateController,
              required: true,
              isDate: true,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF181F6C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
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
        if (isDropdown && dropdownItems != null)
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButtonFormField<String>(
              value: controller.text.isNotEmpty ? controller.text : null,
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
              style: const TextStyle(fontSize: 13),
              dropdownColor: Colors.white,
              hint: Text(
                'Select license type',
                style: const TextStyle(fontSize: 13),
              ),
              items:
                  dropdownItems.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(fontSize: 13)),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.text = newValue;
                }
              },
            ),
          )
        else if (isDate)
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
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
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
          )
        else
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: controller,
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Enter $label',
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
}
