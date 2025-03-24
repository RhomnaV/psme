import 'package:flutter/material.dart';
import 'base_page.dart';
import 'home_page.dart';

class EventRegistrationProfessionalPage extends StatefulWidget {
  const EventRegistrationProfessionalPage({super.key});

  @override
  State<EventRegistrationProfessionalPage> createState() =>
      _EventRegistrationProfessionalPageState();
}

class _EventRegistrationProfessionalPageState
    extends State<EventRegistrationProfessionalPage> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _regionController = TextEditingController();
  final _chapterController = TextEditingController();
  final _prcLicenseNumberController = TextEditingController();
  final _prcLicenseExpirationController = TextEditingController();

  // Selected values
  String? _selectedLicenseType;
  String? _selectedRegion;
  String? _selectedChapter;

  // File upload
  bool _fileUploaded = false;

  void _submitRegistration() {
    if (_formKey.currentState!.validate()) {
      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Registration Successful"),
            content: const Text(
              "Your registration for the 72ND PSME National Convention has been submitted successfully. You will receive a confirmation email shortly.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _regionController.dispose();
    _chapterController.dispose();
    _prcLicenseNumberController.dispose();
    _prcLicenseExpirationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      selectedIndex: 0, // Home tab
      body: _buildProfessionalContent(),
    );
  }

  Widget _buildProfessionalContent() {
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
                    const Text(
                      "72ND PSME National Convention",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A0F44),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "OCT 17-18, 2023",
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
                          "SMX CONVENTION CENTER MANILA, PHILIPPINES",
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

              // Regular Member text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Regular Member",
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
                      "Step 2: Professional Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A0F44),
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

              // Professional information form - centered fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PRC License Type dropdown
                    _buildLicenseTypeField(),

                    const SizedBox(height: 16),

                    // Conditional fields based on license type
                    if (_selectedLicenseType ==
                        "Professional Mechanical Engineer")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Region dropdown
                          _buildDropdownField(
                            label: "Region",
                            value: _selectedRegion,
                            items: const [
                              "NCR",
                              "Region I",
                              "Region II",
                              "Region III",
                              "Region IV-A",
                              "Region IV-B",
                              "Region V",
                              "Region VI",
                              "Region VII",
                              "Region VIII",
                              "Region IX",
                              "Region X",
                              "Region XI",
                              "Region XII",
                              "CAR",
                              "CARAGA",
                              "BARMM",
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedRegion = value;
                              });
                            },
                            required: true,
                          ),

                          const SizedBox(height: 16),

                          // Chapter dropdown
                          _buildDropdownField(
                            label:
                                "Chapter (if none, please select one nearest to your residence or work)",
                            value: _selectedChapter,
                            items: const [
                              "Manila",
                              "Quezon City",
                              "Makati",
                              "Pasig",
                              "Taguig",
                              "Pasay",
                              "Caloocan",
                              "Malabon",
                              "Navotas",
                              "Valenzuela",
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedChapter = value;
                              });
                            },
                            required: true,
                          ),

                          _selectedChapter == null
                              ? Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  "Chapter Required.",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.red.shade700,
                                  ),
                                ),
                              )
                              : const SizedBox.shrink(),

                          const SizedBox(height: 16),

                          // PRC License Number field
                          _buildFormField(
                            label: "PRC License Number",
                            controller: _prcLicenseNumberController,
                            hintText: "",
                            required: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your PRC license number';
                              }
                              return null;
                            },
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              "PRC License Number Required.",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red.shade700,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // PRC License Expiration Date field
                          _buildDateField(
                            label: "PRC License expiration Date",
                            controller: _prcLicenseExpirationController,
                            required: true,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              "PRC License expiration date Required.",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red.shade700,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // File upload section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Please provide a proof of Professional Mechanical Engineer by uploading PRC ID (recommended file size: 3MB)",
                                style: TextStyle(
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
                                  backgroundColor: Colors.blue,
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
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Submit button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: ElevatedButton(
                  onPressed: _submitRegistration,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A0F44),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "SUBMIT",
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

  Widget _buildLicenseTypeField() {
    return Column(
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
              hint: const Text("Professional Mechanical Engineer"),
              icon: const Icon(Icons.keyboard_arrow_down),
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: "Professional Mechanical Engineer",
                  child: Text("Professional Mechanical Engineer"),
                ),
                DropdownMenuItem(
                  value: "Registered Mechanical Engineer",
                  child: Text("Registered Mechanical Engineer"),
                ),
                DropdownMenuItem(
                  value: "Certified Plant Mechanic",
                  child: Text("Certified Plant Mechanic"),
                ),
                DropdownMenuItem(value: "Other", child: Text("Other")),
                DropdownMenuItem(
                  value: "ME Graduate",
                  child: Text("ME Graduate"),
                ),
                DropdownMenuItem(
                  value: "Not Applicable",
                  child: Text("Not Applicable"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedLicenseType = value;
                });
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

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
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
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "MM/DD/YYYY",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              setState(() {
                controller.text =
                    "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
              });
            }
          },
          validator: (value) {
            if (required && (value == null || value.isEmpty)) {
              return 'Please enter the date';
            }
            return null;
          },
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
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              value: value,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: InputBorder.none,
              ),
              hint: Text("Select ${label.split(' ')[0]}"),
              icon: const Icon(Icons.keyboard_arrow_down),
              isExpanded: true,
              items:
                  items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
              onChanged: onChanged,
              validator: (value) {
                if (required && (value == null || value.isEmpty)) {
                  return 'Please make a selection';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}
