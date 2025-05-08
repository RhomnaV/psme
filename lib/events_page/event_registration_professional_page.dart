import 'package:flutter/material.dart';
import '../base_page.dart';
import '../services/api_service.dart';
import '../models/chapter.dart';
import 'other_details.dart';

class EventRegistrationProfessionalPage extends StatefulWidget {
  final String membershipType;
  final String membershipDisplay;
  final double membershipPrice;
  final String firstName;
  final String middleName;
  final String lastName;
  final String suffix;
  final String email;
  final String mobileNumber;
  final String birthDate;
  final Map<String, dynamic> eventData;

  const EventRegistrationProfessionalPage({
    super.key,
    required this.membershipType,
    required this.membershipDisplay,
    required this.membershipPrice,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.suffix,
    required this.email,
    required this.mobileNumber,
    required this.birthDate,
    required this.eventData,
  });

  @override
  State<EventRegistrationProfessionalPage> createState() =>
      _EventRegistrationProfessionalPageState();
}

class _EventRegistrationProfessionalPageState
    extends State<EventRegistrationProfessionalPage> {
  final _formKey = GlobalKey<FormState>();

  // Selected license type with default value
  String _selectedLicenseType = "Professional Mechanical Engineer";

  // Checkbox states
  bool _isBSMEGraduate = false;
  bool _isBSMENewBoardPasser = false;

  // File upload
  bool _fileUploaded = false;

  // Chapter-related variables
  List<Chapter> _chapters = [];
  String? _selectedChapter;
  bool _isLoadingChapters = true;

  @override
  void initState() {
    super.initState();
    _loadChapters(); // Fetch the chapter list
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
              _chapters.first.name; // Use the `name` field for display
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

  void _navigateToNextPage() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => OtherDetailsPage(
                membershipType: widget.membershipType,
                membershipDisplay: widget.membershipDisplay,
                membershipPrice: widget.membershipPrice,
              ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      selectedIndex: 0,
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Event header
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

                // Member status - now dynamic
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

                // Step indicator
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const Text(
                        "Step 2: Professional Details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF181F6C),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "(as seen on your PRC ID)",
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

                // Form fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // License type dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              text:
                                  "PRC License Type (if multiple profession, select the highest profession; i.e. PME over RME)",
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
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                value: _selectedLicenseType,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  border: InputBorder.none,
                                ),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                isExpanded: true,
                                items: const [
                                  DropdownMenuItem(
                                    value: "Professional Mechanical Engineer",
                                    child: Text(
                                      "Professional Mechanical Engineer",
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Registered Mechanical Engineer",
                                    child: Text(
                                      "Registered Mechanical Engineer",
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Certified Plant Mechanic",
                                    child: Text("Certified Plant Mechanic"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Other",
                                    child: Text("Other"),
                                  ),
                                  DropdownMenuItem(
                                    value: "ME Graduate",
                                    child: Text("ME Graduate"),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedLicenseType = value;
                                    });
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select your license type';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Professional Mechanical Engineer / Registered Mechanical Engineer fields
                      if (_selectedLicenseType ==
                              "Professional Mechanical Engineer" ||
                          _selectedLicenseType ==
                              "Registered Mechanical Engineer")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Region dropdown
                            _buildLabeledField(
                              label: "Region",
                              required: true,
                              field: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    hint: const Text("Select Region"),
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    isExpanded: true,
                                    items: const [
                                      DropdownMenuItem(
                                        value: "NCR",
                                        child: Text("NCR"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Region I",
                                        child: Text("Region I"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Region II",
                                        child: Text("Region II"),
                                      ),
                                    ],
                                    onChanged: (value) {},
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Chapter dropdown
                            _buildChapterDropdownField(
                              label:
                                  "Chapter (if none, please select one nearest to your residence or work)",
                              value: _selectedChapter,
                              items: _chapters,
                              onChanged: (value) {
                                setState(() {
                                  _selectedChapter = value;
                                });
                              },
                              errorText: "Chapter Required.",
                            ),

                            const SizedBox(height: 16),

                            // PRC License Number
                            _buildLabeledField(
                              label: "PRC License Number",
                              required: true,
                              field: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "0",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              errorText: "PRC License Number Required.",
                            ),

                            const SizedBox(height: 16),

                            // PRC License expiration Date
                            _buildLabeledField(
                              label: "PRC License expiration Date",
                              required: true,
                              field: TextFormField(
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
                                readOnly: true,
                                onTap: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                  );
                                  // Date selected
                                },
                              ),
                              errorText:
                                  "PRC License expiration date Required.",
                            ),

                            const SizedBox(height: 16),

                            // File upload
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Please provide a proof of ${_selectedLicenseType} by uploading PRC ID (recommended file size: 3MB)",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      _fileUploaded = true;
                                    });
                                  },
                                  icon: const Icon(Icons.add),
                                  label: const Text("Choose"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF181F6C),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                if (_fileUploaded)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      "File uploaded successfully",
                                      style: TextStyle(
                                        color: Colors.green.shade700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),

                      // Certified Plant Mechanic fields
                      if (_selectedLicenseType == "Certified Plant Mechanic")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Region dropdown
                            _buildLabeledField(
                              label: "Region",
                              required: true,
                              field: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    hint: const Text("Select Region"),
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    isExpanded: true,
                                    items: const [
                                      DropdownMenuItem(
                                        value: "NCR",
                                        child: Text("NCR"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Region I",
                                        child: Text("Region I"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Region II",
                                        child: Text("Region II"),
                                      ),
                                    ],
                                    onChanged: (value) {},
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Chapter dropdown
                            _buildChapterDropdownField(
                              label:
                                  "Chapter (if none, please select one nearest to your residence or work)",
                              value: _selectedChapter,
                              items: _chapters,
                              onChanged: (value) {
                                setState(() {
                                  _selectedChapter = value;
                                });
                              },
                              errorText: "Chapter Required.",
                            ),

                            const SizedBox(height: 16),

                            // PRC License Number
                            _buildLabeledField(
                              label: "PRC License Number",
                              required: true,
                              field: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "0",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              errorText: "PRC License Number Required.",
                            ),

                            const SizedBox(height: 16),

                            // PRC License expiration Date
                            _buildLabeledField(
                              label: "PRC License expiration Date",
                              required: true,
                              field: TextFormField(
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
                                readOnly: true,
                                onTap: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                  );
                                  // Date handling
                                },
                              ),
                              errorText:
                                  "PRC License expiration date Required.",
                            ),

                            const SizedBox(height: 16),

                            // BSME graduate checkbox
                            Row(
                              children: [
                                Checkbox(
                                  value: _isBSMEGraduate,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isBSMEGraduate = value ?? false;
                                    });
                                  },
                                ),
                                const Text("BSME graduate?"),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Graduated Info
                            _buildLabeledField(
                              label: "Graduated Info",
                              required: true,
                              field: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Course graduated other than BSME",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                              errorText: "Graduated required.",
                            ),

                            const SizedBox(height: 16),

                            // 2025 BSME New Board Passer checkbox
                            Row(
                              children: [
                                Checkbox(
                                  value: _isBSMENewBoardPasser,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isBSMENewBoardPasser = value ?? false;
                                    });
                                  },
                                ),
                                const Text("2025 BSME New Board Passer?"),
                              ],
                            ),
                          ],
                        ),

                      // ME Graduate fields
                      if (_selectedLicenseType == "ME Graduate")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Region dropdown
                            _buildLabeledField(
                              label: "Region",
                              required: true,
                              field: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    hint: const Text("Select Region"),
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    isExpanded: true,
                                    items: const [
                                      DropdownMenuItem(
                                        value: "NCR",
                                        child: Text("NCR"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Region I",
                                        child: Text("Region I"),
                                      ),
                                    ],
                                    onChanged: (value) {},
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Chapter dropdown
                            _buildChapterDropdownField(
                              label:
                                  "Chapter (if none, please select one nearest to your residence or work)",
                              value: _selectedChapter,
                              items: _chapters,
                              onChanged: (value) {
                                setState(() {
                                  _selectedChapter = value;
                                });
                              },
                              errorText: "Chapter Required.",
                            ),

                            const SizedBox(height: 16),

                            // Graduated field
                            _buildLabeledField(
                              label: "Graduated",
                              required: true,
                              field: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "School Graduated",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                              errorText: "Graduated required.",
                            ),
                          ],
                        ),

                      // Other fields
                      if (_selectedLicenseType == "Other")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Profession text field (not required)
                            _buildLabeledField(
                              label: "Profession",
                              required: false,
                              field: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Enter your profession",
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
                ),

                const SizedBox(height: 32),

                // Next button (replaced Submit)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: ElevatedButton(
                    onPressed: _navigateToNextPage,
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build labeled form fields with error text
  Widget _buildLabeledField({
    required String label,
    required Widget field,
    bool required = false,
    String? errorText,
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
        field,
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              errorText,
              style: TextStyle(fontSize: 12, color: Colors.red.shade700),
            ),
          ),
      ],
    );
  }

  Widget _buildChapterDropdownField({
    required String label,
    String? value,
    required List<Chapter> items,
    required Function(String?) onChanged,
    String? errorText,
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
            children: const [
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
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child:
              _isLoadingChapters
                  ? Center(child: CircularProgressIndicator())
                  : DropdownButtonFormField<String>(
                    value: value,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: InputBorder.none,
                    ),
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    hint: const Text("Select Chapter"),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items:
                        items.map((Chapter chapter) {
                          return DropdownMenuItem<String>(
                            value: chapter.name,
                            child: Text(chapter.description ?? 'Unknown'),
                          );
                        }).toList(),
                    onChanged: onChanged,
                  ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              errorText,
              style: TextStyle(fontSize: 12, color: Colors.red.shade700),
            ),
          ),
      ],
    );
  }
}
