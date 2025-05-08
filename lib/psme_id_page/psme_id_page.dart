import 'package:flutter/material.dart';
import '../header_footer/base_page.dart';
import '../header_footer/profile_header.dart';
import '../membership_page/active_membership_page.dart';
import '../cogs_page/cogs_page.dart';
import 'psme_id_upload_preview.dart';

class PsmeIdPage extends StatefulWidget {
  const PsmeIdPage({super.key});

  @override
  State<PsmeIdPage> createState() => _PsmeIdPageState();
}

enum PsmeIdPageState { initial, applicationForm, photoUpload, deliveryForm }

enum ApplicationStep { applicationForm, uploadPreview, digitalId }

enum PaymentStatus { pending, completed }

class _PsmeIdPageState extends State<PsmeIdPage> {
  int _selectedTabIndex = 1; // PSME ID tab is selected
  PsmeIdPageState _pageState = PsmeIdPageState.initial;
  String _deliveryMethod = 'Pick up at PSME National Headquarters';
  ApplicationStep _currentStep = ApplicationStep.applicationForm;
  PaymentStatus _paymentStatus = PaymentStatus.pending;

  // Shipping form controllers
  final TextEditingController _barangayController = TextEditingController();
  final TextEditingController _subdivisionController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
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

  void _navigateToTab(int index) {
    if (index == _selectedTabIndex) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ActiveMembershipPage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CogsPage()),
      );
    }
  }

  void _showApplicationForm() => setState(() {
    _pageState = PsmeIdPageState.applicationForm;
    _currentStep = ApplicationStep.applicationForm;
  });

  void _showPhotoUpload() => setState(() {
    _pageState = PsmeIdPageState.photoUpload;
    _currentStep = ApplicationStep.uploadPreview;
    _paymentStatus = PaymentStatus.completed;
  });

  void _proceedToPayment() => _showPhotoUpload();

  void _goBack() => setState(() {
    if (_pageState == PsmeIdPageState.photoUpload) {
      _pageState = PsmeIdPageState.applicationForm;
      _currentStep = ApplicationStep.applicationForm;
      _paymentStatus = PaymentStatus.pending;
    } else if (_pageState == PsmeIdPageState.deliveryForm) {
      _pageState = PsmeIdPageState.photoUpload;
    } else if (_pageState == PsmeIdPageState.applicationForm) {
      _pageState = PsmeIdPageState.initial;
    }
  });

  void _onPhotoSubmitted() => setState(() {
    _currentStep = ApplicationStep.digitalId;
  });

  @override
  Widget build(BuildContext context) {
    return BasePage(
      selectedIndex: 2, // Membership tab in bottom nav
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Reusable Profile Header
              const ProfileHeader(
                name: 'KEVIN PARK',
                email: 'kevinpark@gmail.com',
              ),

              // Membership tabs
              const SizedBox(height: 24),
              _buildMembershipTabs(),

              // PSME ID Content - Changes based on state
              _buildPageContent(),
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

  Widget _buildPageContent() {
    switch (_pageState) {
      case PsmeIdPageState.initial:
        return _buildInitialPage();
      case PsmeIdPageState.applicationForm:
        return _buildApplicationFormPage();
      case PsmeIdPageState.photoUpload:
        return PsmeIdUploadPreview(
          currentStep: _currentStep,
          onBack: _goBack,
          onSubmit: _onPhotoSubmitted,
        );
      case PsmeIdPageState.deliveryForm:
        return _buildDeliveryFormPage();
    }
  }

  Widget _buildInitialPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'Application for PSME\nMembership ID',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              'This membership ID will serve as your official\nidentification as a PSME member.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _showApplicationForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF181F6C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'Apply for PSME ID',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildApplicationFormPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageTitle('PSME ID'),
          const SizedBox(height: 24),
          _buildApplicationSteps(),
          const SizedBox(height: 24),
          _buildIdCardFeeSection(),
          const SizedBox(height: 24),
          _buildModeOfClaiming(),

          // Show shipping form directly if door to door delivery is selected
          if (_deliveryMethod == 'Door to door delivery')
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: _buildShippingAddressForm(),
            ),

          const SizedBox(height: 24),
          _buildActionButtons(
            primaryLabel: 'Pay',
            primaryAction: _proceedToPayment,
            showBackButton: true,
          ),
          const SizedBox(height: 24),
          _buildApplicationStatus(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildDeliveryFormPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageTitle('PSME ID'),
          const SizedBox(height: 24),
          _buildApplicationSteps(),
          const SizedBox(height: 24),
          _buildShippingAddressForm(),
          const SizedBox(height: 24),
          _buildActionButtons(
            primaryLabel: 'Pay',
            primaryAction: _proceedToPayment,
            showBackButton: true,
          ),
          const SizedBox(height: 24),
          _buildApplicationStatus(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Common UI Components
  Widget _buildPageTitle(String title) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF181F6C),
        ),
      ),
    );
  }

  Widget _buildApplicationSteps() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepItem(
            '1',
            'Application Form',
            isActive: _currentStep == ApplicationStep.applicationForm,
          ),
          const SizedBox(height: 16),
          _buildStepItem(
            '2',
            'Upload & Preview',
            isActive: _currentStep == ApplicationStep.uploadPreview,
          ),
          const SizedBox(height: 16),
          _buildStepItem(
            '3',
            'Digital ID',
            isActive: _currentStep == ApplicationStep.digitalId,
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(String number, String title, {required bool isActive}) {
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

  Widget _buildIdCardFeeSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFeeRow('ID Card Fee', '₱300.00'),
          const SizedBox(height: 8),
          _buildFeeRow('Shipping', '₱150.00'),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          _buildFeeRow('Total', '₱450.00'),
        ],
      ),
    );
  }

  Widget _buildFeeRow(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }

  Widget _buildModeOfClaiming() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mode of Claiming',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildClaimingOption('Pick up at PSME National Headquarters'),
          const SizedBox(height: 12),
          _buildClaimingOption('Door to door delivery'),
        ],
      ),
    );
  }

  Widget _buildClaimingOption(String option) {
    final bool isSelected = _deliveryMethod == option;

    return GestureDetector(
      onTap: () {
        setState(() {
          _deliveryMethod = option;
        });
      },
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
                option,
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

  Widget _buildActionButtons({
    required String primaryLabel,
    required VoidCallback primaryAction,
    bool isDisabled = false,
    bool showBackButton = false,
  }) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isDisabled ? null : primaryAction,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD600), // Yellow color
              foregroundColor: Colors.black,
              disabledBackgroundColor: Colors.grey.shade300,
              disabledForegroundColor: Colors.grey.shade600,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              primaryLabel,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
        ),
        if (showBackButton)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: _goBack,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildApplicationStatus() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusItem(
            'Application Form',
            _paymentStatus == PaymentStatus.completed,
          ),
          const SizedBox(height: 8),
          _buildStatusItem(
            'Payment',
            _paymentStatus == PaymentStatus.completed,
          ),
          const SizedBox(height: 8),
          _buildStatusItem(
            'Upload Images',
            _currentStep == ApplicationStep.digitalId,
          ),
          const SizedBox(height: 8),
          _buildStatusItem('On Production Queue', false),
          const SizedBox(height: 8),
          _buildStatusItem('In Production', false),
          const SizedBox(height: 8),
          _buildStatusItem('Ready for Pick-up/Delivery', false),
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
          'Status: ${isCompleted ? 'Completed' : 'Pending'}',
          style: TextStyle(
            fontSize: 12,
            color: isCompleted ? Colors.green : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildShippingAddressForm() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shipping Address',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildFormField('Province', true, isDropdown: true),
          const SizedBox(height: 16),
          _buildFormField('City', true, isDropdown: true),
          const SizedBox(height: 16),
          _buildFormField('Barangay', false, controller: _barangayController),
          const SizedBox(height: 16),
          _buildFormField(
            'Subdivision or Village',
            false,
            controller: _subdivisionController,
          ),
          const SizedBox(height: 16),
          _buildFormField(
            'Street or Block or Phase',
            true,
            controller: _streetController,
          ),
          const SizedBox(height: 16),
          _buildFormField('Unit or Lot', true, controller: _unitController),
          const SizedBox(height: 16),
          _buildFormField(
            'Zip Code',
            true,
            controller: _zipCodeController,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(
    String label,
    bool isRequired, {
    bool isDropdown = false,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
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
                value: label == 'Province' ? _selectedProvince : _selectedCity,
                items:
                    (label == 'Province'
                            ? [
                              'Metro Manila',
                              'Cavite',
                              'Laguna',
                              'Rizal',
                              'Bulacan',
                            ]
                            : [
                              'Makati',
                              'Mandaluyong',
                              'Manila',
                              'Pasig',
                              'Quezon City',
                            ])
                        .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    if (label == 'Province') {
                      _selectedProvince = value;
                    } else {
                      _selectedCity = value;
                    }
                  });
                },
              ),
            ),
          )
        else
          Container(
            height: 40,
            child: TextField(
              controller: controller,
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
              keyboardType: keyboardType,
              style: const TextStyle(fontSize: 14),
            ),
          ),
      ],
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    );
  }
}
