import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'psme_id_page.dart';

class PsmeIdUploadPreview extends StatefulWidget {
  final ApplicationStep currentStep;
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  const PsmeIdUploadPreview({
    super.key,
    required this.currentStep,
    required this.onBack,
    required this.onSubmit,
  });

  @override
  State<PsmeIdUploadPreview> createState() => _PsmeIdUploadPreviewState();
}

class _PsmeIdUploadPreviewState extends State<PsmeIdUploadPreview> {
  bool _isFlipped = false;
  bool _hasUploadedPhoto = false;
  bool _termsAccepted = false;
  bool _showSuccessScreen = false;
  bool _showDigitalIdScreen = false; // New state for Digital ID screen
  // Add a new state variable for tracking all statuses completed
  bool _allStatusesCompleted = false;

  void _toggleFlip() => setState(() => _isFlipped = !_isFlipped);

  void _simulatePhotoUpload() => setState(() => _hasUploadedPhoto = true);

  void _handleSubmit() {
    setState(() {
      _showSuccessScreen = true;
    });

    widget.onSubmit();
  }

  void _goToDigitalId() {
    setState(() {
      _showSuccessScreen = false;
      _showDigitalIdScreen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child:
          _showSuccessScreen
              ? _buildSuccessScreen()
              : _showDigitalIdScreen
              ? _buildDigitalIdScreen()
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPageTitle('PSME ID'),
                  const SizedBox(height: 24),
                  _buildApplicationSteps(),
                  const SizedBox(height: 24),
                  _buildPhotoUploadSection(),
                  const SizedBox(height: 24),
                  _buildIdPreview(isPreview: true),
                  const SizedBox(height: 24),
                  _buildTermsAndConditions(),
                  const SizedBox(height: 24),
                  _buildActionButtons(),
                  const SizedBox(height: 24),
                  _buildApplicationStatus(),
                  const SizedBox(height: 40),
                ],
              ),
    );
  }

  Widget _buildSuccessScreen() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showSuccessScreen = false;
          _showDigitalIdScreen = true;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildPageTitle('PSME ID'),
          const SizedBox(height: 16),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: _buildCardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStepItem('1', 'Application Form', isActive: false),
                const SizedBox(height: 16),
                _buildStepItem('2', 'Upload & Preview', isActive: true),
                const SizedBox(height: 16),
                _buildStepItem('3', 'Digital ID', isActive: false),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Success message
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: _buildCardDecoration(),
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
          const SizedBox(height: 24),

          // Application status
          _buildApplicationStatus(isSuccessScreen: true),

          // Hint text to tap for Digital ID
          const SizedBox(height: 16),
          Text(
            'Tap anywhere to view your Digital ID',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDigitalIdScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildPageTitle('PSME ID'),
        const SizedBox(height: 16),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: _buildCardDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStepItem('1', 'Application Form', isActive: false),
              const SizedBox(height: 16),
              _buildStepItem('2', 'Upload & Preview', isActive: false),
              const SizedBox(height: 16),
              _buildStepItem('3', 'Digital ID', isActive: true),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Digital ID preview
        _buildIdPreview(isPreview: false),
        const SizedBox(height: 16),

        // Digital ID message - made clickable to update status
        GestureDetector(
          onTap: () {
            setState(() {
              _allStatusesCompleted =
                  !_allStatusesCompleted; // Toggle all statuses completed
            });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: _buildCardDecoration(),
            child: const Text(
              'This is a digital copy of your PSME Membership ID.\nPlease wait for delivery or pick-up status update\nonce production is complete.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Application status with production queue completed and optional all completed
        _buildApplicationStatus(
          isDigitalIdScreen: true,
          allCompleted: _allStatusesCompleted,
        ),
      ],
    );
  }

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
            isActive: widget.currentStep == ApplicationStep.applicationForm,
          ),
          const SizedBox(height: 16),
          _buildStepItem(
            '2',
            'Upload & Preview',
            isActive: widget.currentStep == ApplicationStep.uploadPreview,
          ),
          const SizedBox(height: 16),
          _buildStepItem(
            '3',
            'Digital ID',
            isActive: widget.currentStep == ApplicationStep.digitalId,
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

  Widget _buildPhotoUploadSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'Photo Upload',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF181F6C),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Upload button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _simulatePhotoUpload,
              icon: const Icon(Icons.upload),
              label: const Text('Upload photo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF181F6C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Photo requirements - left aligned
          const Text(
            'Upload a clear photo of yourself',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),

          // Bullet points
          _buildBulletPoint('Image must be 1×1 in size.'),
          _buildBulletPoint('Background should be plain white.'),
          _buildBulletPoint('Accepted formats: JPG, PNG.'),
          _buildBulletPoint('Maximum file size: 2MB.'),

          // Photo preview
          if (_hasUploadedPhoto)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.person, size: 60, color: Colors.grey),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 14)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildIdPreview({required bool isPreview}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ID Card Preview
          AspectRatio(
            aspectRatio: 1.6,
            child: GestureDetector(
              onTap: _toggleFlip,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    // Card content
                    _isFlipped
                        ? _buildIdBack(isPreview: isPreview)
                        : _buildIdFront(isPreview: isPreview),

                    // Tap to flip hint
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Tap to flip',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdFront({required bool isPreview}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        image: const DecorationImage(
          image: AssetImage('assets/psme-id.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Watermark - only show if it's a preview
          if (isPreview)
            Center(
              child: Transform.rotate(
                angle: -0.5,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.red.shade600,
                        width: 2,
                      ),
                    ),
                    color: Colors.white.withOpacity(0.7),
                  ),
                  child: Text(
                    'For preview only',
                    style: TextStyle(
                      color: Colors.red.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),

          // Logo and header
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Row(
              children: [
                Image.asset('assets/logo.png', width: 60, height: 60),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'PHILIPPINE SOCIETY OF MECHANICAL ENGINEERS',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF181F6C),
                        ),
                      ),
                      const Text(
                        'INTEGRATED ASSOCIATION OF MECHANICAL ENGINEERS',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'PRC Accredited Integrated Professional Organization, Certificate No. AIPO-004',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Membership card title
          Positioned(
            top: 75,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF181F6C),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.amber, width: 1),
                ),
                child: const Text(
                  'MEMBERSHIP CARD',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Member name - use TESTI TESTI for Digital ID
          Positioned(
            top: 95,
            left: 20,
            child: Text(
              isPreview ? 'BLACKSHIP, BABLA' : 'TESTI, TESTI',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),

          // ID Photo
          Positioned(
            top: 120,
            right: 30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                color: Colors.grey.shade200,
              ),
              child: const Icon(Icons.person, size: 70, color: Colors.grey),
            ),
          ),

          // Member details
          Positioned(
            top: 130,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'REGISTERED MECHANICAL ENGINEER',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isPreview ? 'PRC No. 2141234' : 'PRC No. 0000123',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'REGULAR MEMBER',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF181F6C),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'PSME EMBO CHAPTER',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'valid until Feb 26, 2026',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          // ID Number
          Positioned(
            bottom: 20,
            right: 20,
            child: Text(
              isPreview ? 'R-014079' : 'R-075834',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdBack({required bool isPreview}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        image: const DecorationImage(
          image: AssetImage('assets/psme-id.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Watermark - only show if it's a preview
          if (isPreview)
            Center(
              child: Transform.rotate(
                angle: -0.5,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.red.shade600,
                        width: 2,
                      ),
                    ),
                    color: Colors.white.withOpacity(0.7),
                  ),
                  child: Text(
                    'For preview only.',
                    style: TextStyle(
                      color: Colors.red.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),

          // Certification text
          Positioned(
            top: 30,
            left: 20,
            right: 20,
            child: Text(
              'This is to certify that the person whose name and photograph appear herein is a bonafide member of the Philippine Society of Mechanical Engineers, Inc.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
                height: 1.3,
              ),
            ),
          ),

          // Secretary signature
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 30,
                    alignment: Alignment.center,
                    child: const Text(
                      'Signature',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const Text(
                    'ENGR. RODOLFO S. ALCORIZA',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Text(
                    'NATIONAL SECRETARY',
                    style: TextStyle(fontSize: 10, letterSpacing: 0.5),
                  ),
                ],
              ),
            ),
          ),

          // Return information
          Positioned(
            bottom: 50,
            left: 10,
            right: 10,
            child: Column(
              children: [
                const Text(
                  'If found, please return to PSME Headquarters:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '#19 Scout Bayoran, South Triangle, Quezon City, Philippines\n'
                  'Tel. 02 7752 2527 | Mob: +63 945877348779 | Email: membership@psmeinc.org.ph\n'
                  'www.psmeinc.org.ph',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          // Motto
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Text(
              '"The Home of Resilient Filipino Mechanical Engineers & CPMs"',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 8,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      children: [
        Checkbox(
          value: _termsAccepted,
          activeColor: const Color(0xFF181F6C),
          onChanged: (value) {
            setState(() {
              _termsAccepted = value ?? false;
            });
          },
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              children: [
                const TextSpan(text: 'I have read and agree to PSME '),
                TextSpan(
                  text: 'Terms and Conditions',
                  style: const TextStyle(
                    color: Color(0xFF181F6C),
                    decoration: TextDecoration.underline,
                  ),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          // Show terms and conditions
                        },
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(
                    color: Color(0xFF181F6C),
                    decoration: TextDecoration.underline,
                  ),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          // Show privacy policy
                        },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    // Only enable the submit button if both photo is uploaded and terms are accepted
    final bool isButtonEnabled = _hasUploadedPhoto && _termsAccepted;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isButtonEnabled ? _handleSubmit : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFD600), // Yellow color
          foregroundColor: Colors.black,
          disabledBackgroundColor: Colors.grey.shade300,
          disabledForegroundColor: Colors.grey.shade600,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ),
    );
  }

  // Change the _buildApplicationStatus method to only show Upload Images as completed when the success screen is shown
  Widget _buildApplicationStatus({
    bool isSuccessScreen = false,
    bool isDigitalIdScreen = false,
    bool allCompleted = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusItem('Application Form', true),
          const SizedBox(height: 8),
          _buildStatusItem('Payment', true),
          const SizedBox(height: 8),
          _buildStatusItem(
            'Upload Images',
            isSuccessScreen ||
                _showSuccessScreen ||
                _showDigitalIdScreen, // Only complete after submission
          ),
          const SizedBox(height: 8),
          _buildStatusItem(
            'On Production Queue',
            isDigitalIdScreen, // Only completed in Digital ID screen
          ),
          const SizedBox(height: 8),
          _buildStatusItem(
            'In Production',
            allCompleted, // Only completed when all statuses are toggled
          ),
          const SizedBox(height: 8),
          _buildStatusItem(
            'Ready for Pick-up/Delivery',
            allCompleted, // Only completed when all statuses are toggled
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(
    String title,
    bool isCompleted, {
    bool isSuccessScreen = false,
  }) {
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
          'Status: ${isCompleted ? (isSuccessScreen ? 'Success' : 'Completed') : 'Pending'}',
          style: TextStyle(
            fontSize: 12,
            color: isCompleted ? Colors.green : Colors.grey.shade600,
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
