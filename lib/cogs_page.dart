import 'package:flutter/material.dart';
import 'base_page.dart';
import 'active_membership_page.dart';
import 'psme_id_page.dart';

class CogsPage extends StatefulWidget {
  const CogsPage({super.key});

  @override
  State<CogsPage> createState() => _CogsPageState();
}

class _CogsPageState extends State<CogsPage> {
  int _selectedTabIndex = 2;
  bool _applicationSubmitted = false;
  bool _membershipValidationSuccess = false;
  bool _chapterValidationSuccess = false;
  bool _showPaymentScreen = false;
  bool _paymentSuccess = false;
  bool _showDownloadScreen = false;
  int _currentStep = 1;

  void _navigateToTab(int index) {
    if (index == _selectedTabIndex) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ActiveMembershipPage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PsmeIdPage()),
      );
    }
  }

  void _showAddLicenseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add New License',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  children: const [
                    Text(
                      'PRC License Type',
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
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text('Select license type'),
                      value: null,
                      items:
                          [
                            'Mechanical Engineer',
                            'Professional Engineer',
                            'Associate Engineer',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (value) {},
                      icon: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: const [
                    Text(
                      'License Number',
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
                TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                Row(
                  children: const [
                    Text(
                      'Registration Date',
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
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: 'MM/DD/YYYY',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.calendar_today, size: 20),
                    ),
                    onTap: () async {},
                  ),
                ),

                const SizedBox(height: 16),
                Row(
                  children: const [
                    Text(
                      'Expiry Date',
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
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: 'MM/DD/YYYY',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.calendar_today, size: 20),
                    ),
                    onTap: () async {},
                  ),
                ),

                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF181F6C),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text('Add License'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submitApplication() {
    setState(() {
      _applicationSubmitted = true;
    });
  }

  void _navigateToPaymentPage() {
    setState(() {
      _currentStep = 2;
      _membershipValidationSuccess = true;
      _chapterValidationSuccess = true;
      _showPaymentScreen = true;
    });
  }

  void _completePayment() {
    setState(() {
      _currentStep = 3;
      _paymentSuccess = true;
      _showPaymentScreen = false;
      _showDownloadScreen = true;
    });
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
          child: Column(
            children: [
              const SizedBox(height: 24),
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              const SizedBox(height: 12),
              const Text(
                'KEVIN PARK',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                'kevinpark@gmail.com',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),

              const SizedBox(height: 24),
              _buildMembershipTabs(),
              _buildCogsContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMembershipTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          _buildTabItem(0, 'Membership', isLeftTab: true),
          _buildTabItem(1, 'PSME ID'),
          _buildTabItem(2, 'COGS', isRightTab: true),
        ],
      ),
    );
  }

  Widget _buildTabItem(
    int index,
    String label, {
    bool isLeftTab = false,
    bool isRightTab = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _navigateToTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color:
                _selectedTabIndex == index
                    ? const Color(0xFF181F6C)
                    : Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isLeftTab ? 4 : 0),
              bottomLeft: Radius.circular(isLeftTab ? 4 : 0),
              topRight: Radius.circular(isRightTab ? 4 : 0),
              bottomRight: Radius.circular(isRightTab ? 4 : 0),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: _selectedTabIndex == index ? Colors.white : Colors.black,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCogsContent() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'COGS',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF181F6C),
            ),
          ),
          const SizedBox(height: 24),
          _buildApplicationSteps(),
          const SizedBox(height: 24),

          if (_showDownloadScreen) ...[
            _buildDownloadScreen(),
          ] else if (_showPaymentScreen) ...[
            _buildPaymentInformation(),
          ] else if (!_applicationSubmitted) ...[
            _buildAddressInformationForm(),
            const SizedBox(height: 24),
            _buildLicenseInformationForm(),
            const SizedBox(height: 24),
            _buildAddNewLicenseButton(),
            const SizedBox(height: 16),
            _buildNextButton(),
          ] else ...[
            _buildApplicationSuccessful(),
          ],

          const SizedBox(height: 24),
          _buildApplicationStatus(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildApplicationSuccessful() {
    return GestureDetector(
      onTap: _navigateToPaymentPage,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            const Text(
              'Application Successful',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF181F6C),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'We\'re reviewing your application and verifying your uploaded photo. Check back here for updates.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            const Text(
              'Thank you!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.shade100,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicationSteps() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepItem('1', 'License Information', _currentStep == 1),
          const SizedBox(height: 16),
          _buildStepItem('2', 'Payment', _currentStep == 2),
          const SizedBox(height: 16),
          _buildStepItem('3', 'Download', _currentStep == 3),
        ],
      ),
    );
  }

  Widget _buildStepItem(String number, String title, bool isActive) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? const Color(0xFF181F6C) : Colors.grey.shade300,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                  color: isActive ? Colors.black : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddressInformationForm() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Address Information',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildFormField('Country', true, isDropdown: true),
          const SizedBox(height: 16),
          _buildFormField('Province', true, isDropdown: true),
          const SizedBox(height: 16),
          _buildFormField('City', true, isDropdown: true),
          const SizedBox(height: 16),
          _buildFormField('Address 1', true),
          const SizedBox(height: 16),
          _buildFormField('Address 2', false),
          const SizedBox(height: 16),
          _buildFormField('Postal Code', true),
        ],
      ),
    );
  }

  Widget _buildLicenseInformationForm() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'License Information',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildFormField(
            'Select existing PRC License',
            true,
            isDropdown: true,
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'License not in the list?',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewLicenseButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _showAddLicenseDialog,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF181F6C),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: const Text(
          'Add New PRC License',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitApplication,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFD600),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: const Text(
          'Next',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildApplicationStatus() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusItem('Request Form', _applicationSubmitted),
          const SizedBox(height: 8),
          _buildStatusItem(
            'Membership Validation',
            _membershipValidationSuccess,
          ),
          const SizedBox(height: 8),
          _buildStatusItem('Chapter Validation', _chapterValidationSuccess),
          const SizedBox(height: 8),
          _buildStatusItem('Payment', _paymentSuccess),
          const SizedBox(height: 8),
          _buildStatusItem('Download', _showDownloadScreen),
        ],
      ),
    );
  }

  Widget _buildStatusItem(String title, bool isCompleted) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? Colors.green : Colors.grey.shade300,
          ),
          child: Center(
            child: Icon(Icons.check, size: 16, color: Colors.white),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isCompleted ? Colors.black : Colors.grey.shade600,
            ),
          ),
        ),
        Text(
          isCompleted ? 'Status: Success' : 'Status: Pending',
          style: TextStyle(
            fontSize: 12,
            color: isCompleted ? Colors.green : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildFormField(
    String label,
    bool isRequired, {
    bool isDropdown = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        if (isDropdown)
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text('Select ${label.toLowerCase()}'),
                value: null,
                items:
                    ['Option 1', 'Option 2', 'Option 3'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (value) {},
              ),
            ),
          )
        else
          Container(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter ${label.toLowerCase()}',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPaymentInformation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Payment Information',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'We accept credit/debit cards, bank transfers, and e-wallets. A convenience fee may apply.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Certificate Fee', style: TextStyle(fontSize: 14)),
              Text(
                '₱300.00',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Total',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                '₱300.00',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _completePayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF181F6C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'Pay',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadScreen() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text(
                'Download Certificate',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF181F6C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Generated: Feb 18, 2025',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          const Text(
            'Valid Until: Feb 18, 2026',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
