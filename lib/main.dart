import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'sign_up_page.dart';
import 'guest.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(), // Start on HomePage instead of IndexPage
    );
  }
}

/* 
// Original Code - Uncomment if needed
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IndexPage(),
    );
  }
}

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PSME',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.black, 
          ),
        ),
        centerTitle: true, 
        backgroundColor: Colors.transparent, 
        elevation: 0, 
      ),
      
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 0),
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 140,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported, size: 80, color: Colors.grey);
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Advancing Excellence in\nMechanical Engineering',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    height: 1.2, // Adjusts spacing between lines
                  ),
                ),

                //Sign-up button
                const SizedBox(height: 20),
                SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF181F6C),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3), // Less rounded corners
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),

                // Login button
                const SizedBox(height: 10),
                SizedBox(
                  width: 350,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF0A0F44)),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3), 
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 14, color: Color(0xFF0A0F44)),
                    ),
                  ),
                ),

                // Guest button
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GuestPage()), 
                    );
                  },
                  child: const Text(
                    'Continue as Guest',
                    style: TextStyle(fontSize: 14, color: Color.fromARGB(136, 6, 6, 6)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
