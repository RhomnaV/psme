import 'package:flutter/material.dart';
import 'base_page.dart';
import 'membership.dart';
import 'confirm_details.dart';

class PsmeIdPage extends StatefulWidget {
  const PsmeIdPage({super.key});

  @override
  State<PsmeIdPage> createState() => _PsmeIdPageState();
}

class _PsmeIdPageState extends State<PsmeIdPage> {
  // Selected delivery option
  String? _selectedOption;

  // Controllers for the shipping information fields
  final _provinceController = TextEditingController();
  final _cityController = TextEditingController();
  final _barangayController = TextEditingController();
  final _subdivisionController = TextEditingController();
  final _streetController = TextEditingController();
  final _unitController = TextEditingController();
  final _zipCodeController = TextEditingController();

  // Dropdown values
  String? _selectedProvince;
  String? _selectedCity;

  @override
  void dispose() {
    _barangayController.dispose();
    _subdivisionController.dispose();
    _streetController.dispose();
    _unitController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  // Check if all required fields are filled for door to door delivery
  bool _isShippingFormValid() {
    if (_selectedOption != 'Door to door delivery') return true;

    return _selectedProvince != null &&
        _selectedCity != null &&
        _barangayController.text.isNotEmpty &&
        _subdivisionController.text.isNotEmpty &&
        _streetController.text.isNotEmpty &&
        _unitController.text.isNotEmpty &&
        _zipCodeController.text.isNotEmpty;
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

                // PSME ID title
                const Text(
                  'PSME ID',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 24),

                // Pick up at PSME National Headquarters option
                _buildOptionCard(
                  title: 'Pick up at PSME National Headquarters',
                  isSelected:
                      _selectedOption ==
                      'Pick up at PSME National Headquarters',
                  onTap: () {
                    setState(() {
                      _selectedOption = 'Pick up at PSME National Headquarters';
                    });
                  },
                ),

                const SizedBox(height: 12),

                // Door to door delivery option
                _buildOptionCard(
                  title: 'Door to door delivery',
                  isSelected: _selectedOption == 'Door to door delivery',
                  onTap: () {
                    setState(() {
                      _selectedOption = 'Door to door delivery';
                    });
                  },
                ),

                // Shipping information fields (only shown when Door to door delivery is selected)
                if (_selectedOption == 'Door to door delivery')
                  _buildShippingInformation(),

                const SizedBox(height: 12),

                // Maybe next time option
                _buildOptionCard(
                  title: 'Maybe next time',
                  isSelected: _selectedOption == 'Maybe next time',
                  onTap: () {
                    setState(() {
                      _selectedOption = 'Maybe next time';
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
                        (_selectedOption != null && _isShippingFormValid())
                            ? () {
                              // Navigate to confirm details page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const ConfirmDetailsPage(),
                                ),
                              );
                            }
                            : null, // Disable if nothing selected or shipping form is invalid
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

  // Shipping information form
  Widget _buildShippingInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Shipping Information',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        // Province dropdown
        _buildFormLabel('Province', true),
        const SizedBox(height: 8),
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('Select Province'),
              ),
              value: _selectedProvince,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              items:
                  ['Metro Manila', 'Cavite', 'Laguna', 'Rizal', 'Bulacan'].map((
                    String value,
                  ) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedProvince = newValue;
                });
              },
            ),
          ),
        ),

        const SizedBox(height: 16),

        // City dropdown
        _buildFormLabel('City', true),
        const SizedBox(height: 8),
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('Select City'),
              ),
              value: _selectedCity,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              items:
                  [
                    'Makati',
                    'Mandaluyong',
                    'Manila',
                    'Pasig',
                    'Quezon City',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCity = newValue;
                });
              },
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Barangay field
        _buildFormLabel('Barangay', true),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _barangayController,
          hintText: 'Enter Barangay',
        ),

        const SizedBox(height: 16),

        // Subdivision or Village field
        _buildFormLabel('Subdivision or Village', true),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _subdivisionController,
          hintText: 'Enter Subdivision or Village',
        ),

        const SizedBox(height: 16),

        // Street or Block or Phase field
        _buildFormLabel('Street or Block or Phase', true),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _streetController,
          hintText: 'Enter Street or Block or Phase',
        ),

        const SizedBox(height: 16),

        // Unit or Lot field
        _buildFormLabel('Unit or Lot', true),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _unitController,
          hintText: 'Enter Unit or Lot',
        ),

        const SizedBox(height: 16),

        // Zip Code field
        _buildFormLabel('Zip Code', true),
        const SizedBox(height: 8),
        _buildTextField(
          controller: _zipCodeController,
          hintText: 'Enter Zip Code',
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  // Helper method to build form labels
  Widget _buildFormLabel(String label, bool isRequired) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        if (isRequired)
          const Text(
            ' *',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
      ],
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(fontSize: 14),
        textAlignVertical: TextAlignVertical.center,
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
