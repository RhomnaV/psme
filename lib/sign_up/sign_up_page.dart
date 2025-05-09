import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'otp_verification_page.dart';
import '../log_in_page/login_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  Future<void> sendOTP() async {
    if (!mounted) return;

    final email = emailController.text.trim();
    if (email.isEmpty) {
      debugPrint("⚠️ No email entered!");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter an email.')));
      return;
    }

    debugPrint("📩 Sending OTP to: $email");
    setState(() => isLoading = true);

    try {
      final response = await ApiService.sendOTPUser(email);
      debugPrint("✅ OTP Response: $response");

      if (!mounted) return;

      if (response['resultKey'] == 1) {
        final resultValue = response['resultValue'];

        if (resultValue != null && resultValue['isexistmem'] == true) {
          debugPrint("❌ Email already in use.");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email already in use.')),
          );
          return;
        }

        if (resultValue != null && resultValue['isMailsend'] == false) {
          debugPrint("❌ OTP sending failed: OTP was not sent.");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('OTP sending failed. Please try again.'),
            ),
          );
          return;
        }

        debugPrint(
          "🚀 OTP Sent Successfully! Navigating to OTP Verification Page.",
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPVerificationPage(email: email),
          ),
        );
      } else {
        debugPrint("❌ OTP Sending Failed: ${response['message']}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? 'Failed to send OTP')),
        );
      }
    } catch (e) {
      if (!mounted) return;

      debugPrint("🔥 Error occurred while sending OTP: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Email TextField
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 14,
                ), // Adjust thickness here
              ),
            ),
            const SizedBox(height: 20),

            // Sign Up Button
            ElevatedButton(
              onPressed: () async {
                if (emailController.text.isNotEmpty) {
                  await sendOTP(); // Trigger sendOTP function
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter an email."),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF181F6C),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: const Text(
                'Sign up with Email',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),

            // Already have an account? Login
            GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
