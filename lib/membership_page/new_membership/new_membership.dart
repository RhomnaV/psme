import 'package:flutter/material.dart';
import '../../header_footer/base_page.dart';
import 'profession_details.dart';
import '../../services/api_service.dart';
import '../../models/chapter.dart';

class NewMembershipPage extends StatefulWidget {
  const NewMembershipPage({super.key});

  @override
  State<NewMembershipPage> createState() => _NewMembershipPageState();
}

class _NewMembershipPageState extends State<NewMembershipPage> {
  final _membershipTypeController = TextEditingController();

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

  @override
  void dispose() {
    _membershipTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      selectedIndex: 2,
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                const Text(
                  'New Membership',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Membership Type',
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
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            border: InputBorder.none,
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          hint: const Text('Select membership type'),
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(
                              value: 'Regular Member',
                              child: Text('Regular Member'),
                            ),
                            DropdownMenuItem(
                              value: 'Student Member',
                              child: Text('Student Member'),
                            ),
                            DropdownMenuItem(
                              value: 'Senior Member',
                              child: Text('Senior Member'),
                            ),
                            DropdownMenuItem(
                              value: 'Life Member',
                              child: Text('Life Member'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _membershipTypeController.text = value ?? '';
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

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

                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Personal Information',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 16),

                _buildFormField(
                  label: 'Middle Name',
                  hintText: 'Enter your middle name',
                  required: true,
                ),

                _buildFormField(
                  label: 'Suffix',
                  hintText: 'E.g., Jr., Sr., III',
                  required: true,
                ),

                _buildDateField(
                  label: 'Birth Date',
                  hintText: 'MM/DD/YYYY',
                  required: true,
                ),

                _buildPhoneField(
                  label: 'Mobile Number',
                  hintText: 'Enter your mobile number',
                  required: true,
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_membershipTypeController.text.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfessionDetailsPage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a membership type'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD600),
                      foregroundColor: Colors.black,
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

  Widget _buildFormField({
    required String label,
    required String hintText,
    TextEditingController? controller,
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              if (required)
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                isDense: true,
              ),
              style: const TextStyle(fontSize: 14),
              textAlignVertical: TextAlignVertical.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required String hintText,
    TextEditingController? controller,
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              if (required)
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                suffixIcon: const Icon(Icons.calendar_today, size: 18),
              ),
              style: const TextStyle(fontSize: 14),
              readOnly: true,
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null && controller != null) {
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

  Widget _buildPhoneField({
    required String label,
    required String hintText,
    TextEditingController? controller,
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              if (required)
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 16,
                      margin: const EdgeInsets.only(left: 8),
                      color: Colors.red,
                    ),
                    const SizedBox(width: 4),
                    const Text('+62', style: TextStyle(fontSize: 14)),
                    const Icon(Icons.keyboard_arrow_down, size: 16),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: hintText,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const Text(
              ' *',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
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
          child:
              _isLoadingChapters
                  ? Center(child: CircularProgressIndicator())
                  : DropdownButtonFormField<String>(
                    value: value,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: InputBorder.none,
                    ),
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    hint: const Text('Select chapter'),
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
      ],
    );
  }
}
