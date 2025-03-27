import 'package:flutter/material.dart';
import 'dart:convert';
import 'base_page.dart';
import 'events_page/events_page.dart';
import 'sign_up_page.dart';
import '../services/api_service.dart';
import '../models/event.dart';
import '../events_page/event_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Future<List<Event>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = ApiService.fetchEvents();
  }


  @override
  Widget build(BuildContext context) {
    return BasePage(
      selectedIndex: 0, // Home tab
      body: _buildHomeContent(context),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Grid of images
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildImageCard('assets/psme-overview.png'),
                _buildImageCard('assets/psme-overview2.png'),
              ],
            ),

            const SizedBox(height: 20),

            // Join PSME Community Section
            _buildCommunitySection(context),

            const SizedBox(height: 20),

            // Upcoming Events Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Upcoming Events',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to Events page when View All is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EventsPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Colors.amber, fontSize: 12),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Use FutureBuilder to display dynamic event cards
            FutureBuilder<List<Event>>(
              future: futureEvents,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Failed to load events'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No upcoming events'));
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: snapshot.data!.map((event) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: _buildEventCard(context, event.id, event.title, event.formattedDate, event.imageUrl),
                      );
                    }).toList(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunitySection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/community_bg.jpg',
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.6),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Join the PSME community',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Access exclusive resources to events and contents',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A0F44),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                  child: const Text('BE A MEMBER NOW'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(String imagePath) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }

Widget _buildEventCard(BuildContext context, int id, String title, String date, String imageUrl) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EventDetailsPage(eventId: id),
        ),
      );
    },
    child: Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    width: 150,
                    height: 100,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        width: 150,
                        height: 100,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      print("Error loading image: $error"); // Debugging
                      return Image.asset(
                        'assets/logo.png', // Fallback image
                        width: 150,
                        height: 100,
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.asset(
                    'assets/logo.png', // Fallback for empty URL
                    width: 150,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

}
