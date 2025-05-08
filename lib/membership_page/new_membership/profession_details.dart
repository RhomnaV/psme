import 'package:flutter/material.dart';
import '../../header_footer/base_page.dart';
import 'prc_license.dart';
import 'psme_id.dart';

class ProfessionDetailsPage extends StatefulWidget {
  const ProfessionDetailsPage({super.key});

  @override
  State<ProfessionDetailsPage> createState() => _ProfessionDetailsPageState();
}

class _ProfessionDetailsPageState extends State<ProfessionDetailsPage> {
  // Selected option
  String? _selectedOption;

  // Series number controller for BSME Board Passer
  final _seriesNumberController = TextEditingController();

  @override
  void dispose() {
    _seriesNumberController.dispose();
    super.dispose();
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Profession Details title
                const Text(
                  'Profession Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 24),

                // With PRC License option
                _buildOptionCard(
                  title: 'With PRC License',
                  isSelected: _selectedOption == 'With PRC License',
                  onTap: () {
                    setState(() {
                      _selectedOption = 'With PRC License';
                    });
                  },
                ),

                const SizedBox(height: 12),

                // Most Recent BSME Board Passer option
                _buildOptionCard(
                  title: 'Most Recent BSME Board Passer',
                  isSelected:
                      _selectedOption == 'Most Recent BSME Board Passer',
                  onTap: () {
                    setState(() {
                      _selectedOption = 'Most Recent BSME Board Passer';
                    });
                  },
                ),

                // Series Number field (only shown when Most Recent BSME Board Passer is selected)
                if (_selectedOption == 'Most Recent BSME Board Passer')
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Series Number',
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
                            controller: _seriesNumberController,
                            decoration: const InputDecoration(
                              hintText: 'Enter series number',
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
                  ),

                const SizedBox(height: 12),

                // BSME Graduate option
                _buildOptionCard(
                  title: 'BSME Graduate',
                  isSelected: _selectedOption == 'BSME Graduate',
                  onTap: () {
                    setState(() {
                      _selectedOption = 'BSME Graduate';
                    });
                  },
                ),

                const SizedBox(height: 40),

                // Next button - yellow color
                SizedBox(
                  width: double.infinity,
                  height: 44, // Smaller height to match design
                  child: ElevatedButton(
                    onPressed:
                        _selectedOption != null
                            ? () {
                              // Validate if series number is required
                              if (_selectedOption ==
                                      'Most Recent BSME Board Passer' &&
                                  _seriesNumberController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter series number'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              // Navigate based on selected option
                              if (_selectedOption == 'With PRC License') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const PRCLicensePage(),
                                  ),
                                );
                              } else {
                                // For BSME Graduate or Most Recent BSME Board Passer
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PsmeIdPage(),
                                  ),
                                );
                              }
                            }
                            : null, // Disable if nothing selected
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD600), // Yellow color
                      foregroundColor: Colors.black,
                      disabledBackgroundColor:
                          Colors.grey.shade300, // Grey when disabled
                      disabledForegroundColor: Colors.grey.shade600,
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

  // Helper method to build option cards
  Widget _buildOptionCard({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFF181F6C) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            if (isSelected)
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.check_circle,
                  color: Color(0xFF181F6C),
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
