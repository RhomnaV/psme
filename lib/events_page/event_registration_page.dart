import 'package:flutter/material.dart';
import '../header_footer/base_page.dart';
import 'event_registration_professional_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/country.dart';

class EventRegistrationPage extends StatefulWidget {
  final String membershipType;
  final String membershipDisplay;
  final double membershipPrice;
  final Map<String, dynamic> eventData;

  const EventRegistrationPage({
    super.key,
    required this.membershipType,
    required this.membershipDisplay,
    required this.membershipPrice,
    required this.eventData,
  });

  @override
  State<EventRegistrationPage> createState() => _EventRegistrationPageState();
}

class _EventRegistrationPageState extends State<EventRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _suffixController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _birthDateController = TextEditingController();

  String? _selectedSuffix;
  String? _selectedCountryCode;
  List<Country> _countries = [];
  bool _isLoading = true;
  bool _isPWD = false;
  DateTime? _selectedBirthDate;

  late Future<List<Country>> futureCountry;
  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    List<Country> fetchedCountries = await ApiService.fetchCountry();
    setState(() {
      _countries = fetchedCountries;
      _isLoading = false;

      // Ensure the default country code is in the list
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

      _selectedCountryCode = defaultCountry.code;
    });
  }

  String countryCodeToEmoji(String countryCode) {
    return countryCode.toUpperCase().split('').map((char) {
      return String.fromCharCode(
        0x1F1E6 + char.codeUnitAt(0) - 'A'.codeUnitAt(0),
      );
    }).join();
  }

  Uint8List? _pwdImageBytes;
  File? _pwdImageFile; // For Mobile/Desktop

  Future<void> _uploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (kIsWeb) {
        // Read image as bytes for Web
        Uint8List bytes = await image.readAsBytes();
        setState(() {
          _pwdImageBytes = bytes;
        });
      } else {
        // Use File for Mobile/Desktop
        setState(() {
          _pwdImageFile = File(image.path);
        });
      }
    }
  }

  void _proceedToNextStep() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => EventRegistrationProfessionalPage(
                membershipType: widget.membershipType,
                membershipDisplay: widget.membershipDisplay,
                membershipPrice: widget.membershipPrice,
                firstName: _firstNameController.text,
                middleName: _middleNameController.text,
                lastName: _lastNameController.text,
                suffix: _suffixController.text,
                email: _emailController.text,
                mobileNumber:
                    "${_selectedCountryCode ?? ''}${_mobileNumberController.text}",
                birthDate: _birthDateController.text,
                eventData: widget.eventData,
              ),
        ),
      );
    }
  }

  // Format date as MM/DD/YYYY without using intl package
  String _formatDate(DateTime date) {
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    String year = date.year.toString();
    return '$month/$day/$year';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedBirthDate ??
          DateTime.now().subtract(
            const Duration(days: 365 * 18),
          ), // Default to 18 years ago
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedBirthDate) {
      setState(() {
        _selectedBirthDate = picked;
        _birthDateController.text = _formatDate(picked);
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _suffixController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      selectedIndex: 0, // Home tab
      body: _buildRegistrationContent(context),
    );
  }

  Widget _buildRegistrationContent(BuildContext context) {
    if (widget.eventData == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Event title and info - centered
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      widget.eventData!["name"] ?? "Event Title",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF181F6C),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.eventData!["formattedDate"] ?? "TBA",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.eventData!["location"] ?? "N/A",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Membership type text - now dynamic
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.membershipDisplay,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 16),

              // Registration step indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const Text(
                      "Step 1: Personal Information",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF181F6C),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Let's start with your PRC ID",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Personal information form - centered fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First Name field
                    _buildFormField(
                      label: "First Name",
                      controller: _firstNameController,
                      hintText: "Enter your first name",
                      required: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Middle Name field
                    _buildFormField(
                      label: "Middle Name",
                      controller: _middleNameController,
                      hintText: "Enter your middle name",
                      required: false,
                    ),

                    const SizedBox(height: 16),

                    // Last Name field
                    _buildFormField(
                      label: "Last Name",
                      controller: _lastNameController,
                      hintText: "Enter your last name",
                      required: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Suffix dropdown
                    _buildDropdownField(
                      label: "Suffix",
                      value: _selectedSuffix,
                      items: const ["None", "Jr.", "Sr.", "II", "III", "IV"],
                      onChanged: (value) {
                        setState(() {
                          _selectedSuffix = value;
                          if (value != null && value != "None") {
                            _suffixController.text = value;
                          } else {
                            _suffixController.text = "";
                          }
                        });
                      },
                      required: true,
                    ),

                    const SizedBox(height: 16),

                    // Personal Email Address field
                    _buildFormField(
                      label: "Personal Email Address",
                      controller: _emailController,
                      hintText: "Enter your email address",
                      required: true,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Mobile Number field with country code - DYNAMIC
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: "Mobile Number",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: " *",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Country code dropdown - DYNAMIC
                              Container(
                                width: 110,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child:
                                    _isLoading
                                        ? Center(
                                          child: CircularProgressIndicator(),
                                        ) // Show loading
                                        : DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value:
                                                _selectedCountryCode, // Ensure this exists in the list
                                            items:
                                                _countries
                                                    .map(
                                                      (
                                                        country,
                                                      ) => DropdownMenuItem<
                                                        String
                                                      >(
                                                        value: country.code,
                                                        child: Text(
                                                          "${countryCodeToEmoji(country.code)} ${country.mobileCode}",
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                            onChanged: (String? value) {
                                              if (value != null &&
                                                  value !=
                                                      _selectedCountryCode) {
                                                setState(() {
                                                  _selectedCountryCode = value;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                              ),
                              // Phone number input
                              Expanded(
                                child: TextFormField(
                                  controller: _mobileNumberController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: "Enter mobile number",
                                    border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your mobile number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Birth Date field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: "Birth Date",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: " *",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "(MM/DD/YYYY)",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _birthDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "MM/DD/YYYY",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            suffixIcon: const Icon(
                              Icons.calendar_today,
                              size: 20,
                            ),
                          ),
                          onTap: () => _selectDate(context),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your birth date';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // PWD checkbox
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Are you a Person with Disability? (PWD)",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Checkbox(
                              value: _isPWD,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              onChanged: (bool? value) {
                                setState(() {
                                  _isPWD = value ?? false;
                                });
                              },
                            ),
                            const Text("Yes"),
                          ],
                        ),

                        if (_isPWD)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              const Text(
                                "Please provide a proof of PWD by uploading an image file "
                                "(recommended file size: 3MB)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton.icon(
                                onPressed: _uploadImage,
                                icon: const Icon(Icons.upload_file),
                                label: const Text("Upload Image"),
                              ),

                              // Display the uploaded image based on platform
                              if (_pwdImageBytes != null && kIsWeb)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Image.memory(
                                    _pwdImageBytes!,
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              else if (_pwdImageFile != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Image.file(
                                    _pwdImageFile!,
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Next button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: ElevatedButton(
                  onPressed: _proceedToNextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF181F6C),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "NEXT",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    bool required = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
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
                        text: " *",
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
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    String? value,
    required List<String> items,
    required Function(String?) onChanged,
    bool required = false,
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
                        text: " *",
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          hint: Text("Select $label"),
          items:
              items.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
