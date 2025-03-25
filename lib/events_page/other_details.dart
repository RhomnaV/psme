import 'package:flutter/material.dart';
import '../base_page.dart';
import '../home_page.dart';

class OtherDetailsPage extends StatefulWidget {
  final String membershipType;
  final String membershipDisplay;
  final double membershipPrice;

  const OtherDetailsPage({
    super.key,
    required this.membershipType,
    required this.membershipDisplay,
    required this.membershipPrice,
  });

  @override
  State<OtherDetailsPage> createState() => _OtherDetailsPageState();
}

class _OtherDetailsPageState extends State<OtherDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  // Selected values
  String? _selectedSector;

  // Checkbox states
  bool _dataPrivacyConsent = false;
  bool _verificationConsent = false;

  void _submitRegistration() {
    if (_formKey.currentState!.validate()) {
      if (!_dataPrivacyConsent || !_verificationConsent) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please check all required checkboxes'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

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

                // Membership type display
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

                // Other Details header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Other Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0A0F44),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),

                // Form fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Company Sector type
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Company Sector type",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
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
                                value: _selectedSector,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  border: InputBorder.none,
                                ),
                                hint: const Text("Select Sector"),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                isExpanded: true,
                                items: const [
                                  DropdownMenuItem(
                                    value: "Government",
                                    child: Text("Government"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Private",
                                    child: Text("Private"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Academic",
                                    child: Text("Academic"),
                                  ),
                                  DropdownMenuItem(
                                    value: "NGO",
                                    child: Text("NGO"),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSector = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Organization Name/Company Name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Organization Name/Company Name",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            decoration: InputDecoration(
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

                      // Data Privacy Consent
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _dataPrivacyConsent,
                            onChanged: (bool? value) {
                              setState(() {
                                _dataPrivacyConsent = value ?? false;
                              });
                            },
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "All personal data collected herein shall be processed according to the principle and provisions of the Data Privacy Act of 2012 (DPA) its Implementing Rule and Regulation, and other relevant laws, rules, and Commission(NPC) issuances. I hereby agree and consent to collection and processing of my personal data,as provided through this form,for the purpose of registration.",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(50, 20),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "Data Privacy Notice",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue.shade700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Verification Consent
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _verificationConsent,
                            onChanged: (bool? value) {
                              setState(() {
                                _verificationConsent = value ?? false;
                              });
                            },
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "Verification will be conducted after registration. Please ensure that all the information provided on this form, including your membership status and attachments, is true and accurate. You will be notified if any discrepancies are found in your data. Certificates related to this event may not be issued until any discrepancies are resolved.",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Payment amount - dynamic based on membership type
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Payable Amount: ₱${widget.membershipPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Submit button
                      SizedBox(
                        width: double.infinity,
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
                            "Proceed to pay",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
