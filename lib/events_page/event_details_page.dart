import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../base_page.dart';
import 'event_registration_page.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({super.key});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  String? _selectedMembershipType;
  late YoutubePlayerController _youtubeController;

  // Map to store membership types and their prices
  final Map<String, Map<String, dynamic>> _membershipInfo = {
    "regular": {"display": "Regular Member", "price": 3500.00},
    "guest": {"display": "Guest / Non-member", "price": 4500.00},
    "life": {"display": "Life / Associate Member", "price": 3500.00},
  };

  @override
  void initState() {
    super.initState();
    // Initialize YouTube player with a sample video ID
    // Replace this with your actual YouTube video ID
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'dQw4w9WgXcQ', // Sample video ID
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      selectedIndex: 0, // Home tab
      body: _buildEventDetailsContent(context),
    );
  }

  Widget _buildEventDetailsContent(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Event title
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                ],
              ),
            ),

            // Date and Time row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  // Date column
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 16,
                          color: Color(0xFF0A0F44),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Date",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0A0F44),
                              ),
                            ),
                            Text(
                              "Oct 17-18, 2023",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Time column
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 16,
                          color: Color(0xFF0A0F44),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Time",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0A0F44),
                              ),
                            ),
                            Text(
                              "10 AM - 03 PM PM",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Location and Modality row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  // Location column
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Color(0xFF0A0F44),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Location",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0A0F44),
                                ),
                              ),
                              Text(
                                "SMX CONVENTION CENTER MANILA, PHILIPPINES",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Modality column
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.people_outline,
                          size: 16,
                          color: Color(0xFF0A0F44),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Modality",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0A0F44),
                              ),
                            ),
                            Text(
                              "Face-to-Face",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // About the Event section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Color(0xFF0A0F44),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "About the Event",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0A0F44),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "The 72nd National Convention of the Philippine Society of Mechanical Engineers (PSME) is a significant annual event where mechanical engineering professionals from across the Philippines gather to discuss industry trends, advancements, and best practices. The convention features a comprehensive program of technical sessions, workshops, and networking opportunities aimed at fostering professional growth, collaboration, and innovation within the field.",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Event logo/badge
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/logo.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // YouTube Video Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: YoutubePlayer(
                        controller: _youtubeController,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.red,
                        progressColors: const ProgressBarColors(
                          playedColor: Colors.red,
                          handleColor: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Other Events You May Like Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Other Events you may like",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A0F44),
                    ),
                  ),

                  const SizedBox(height: 16),
                  // Added SingleChildScrollView with horizontal scrolling
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        _buildEventCard(
                          title: "11th PSME Luzon Regional Conference",
                          date: "May 23 - 25, 2023",
                          location:
                              "Costa Palawan Resort, F. Ponce De Leon RD, Brgy. San Pedro, Puerto Princesa",
                          imageAsset: "assets/logo.png",
                        ),
                        const SizedBox(width: 12),
                        _buildEventCard(
                          title: "11th PSME Luzon Regional Conference",
                          date: "May 23 - 25, 2023",
                          location:
                              "Costa Palawan Resort, F. Ponce De Leon RD, Brgy. San Pedro, Puerto Princesa",
                          imageAsset: "assets/logo.png",
                        ),
                        const SizedBox(width: 12),
                        _buildEventCard(
                          title: "Empowering Tourism & Mechanical",
                          date: "May 27 - 28, 2023",
                          location:
                              "Costa Palawan Resort, F. Ponce De Leon RD, Brgy. San Pedro, Puerto Princesa",
                          imageAsset: "assets/logo.png",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Membership Type Selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Please choose one",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A0F44),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Regular Member option
                    _buildMembershipOption(
                      type: "regular",
                      display: "Regular Member",
                      price: "₱3,500.00",
                    ),

                    const Divider(),

                    // Life / Associate Member option
                    _buildMembershipOption(
                      type: "life",
                      display: "Life / Associate Member",
                      price: "₱3,500.00",
                    ),

                    const Divider(),

                    // Guest / Non-member option
                    _buildMembershipOption(
                      type: "guest",
                      display: "Guest / Non-member",
                      price: "₱4,500.00",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Register button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed:
                    _selectedMembershipType == null
                        ? null // Disable button if no membership type is selected
                        : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => EventRegistrationPage(
                                    membershipType: _selectedMembershipType!,
                                    membershipDisplay:
                                        _membershipInfo[_selectedMembershipType]!["display"],
                                    membershipPrice:
                                        _membershipInfo[_selectedMembershipType]!["price"],
                                  ),
                            ),
                          );
                        },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  disabledBackgroundColor: Colors.red.shade200,
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMembershipOption({
    required String type,
    required String display,
    required String price,
  }) {
    return Row(
      children: [
        Radio<String>(
          value: type,
          groupValue: _selectedMembershipType,
          onChanged: (String? value) {
            setState(() {
              _selectedMembershipType = value;
            });
          },
        ),
        Expanded(
          child: Text(
            display,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          price,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildEventCard({
    required String title,
    required String date,
    required String location,
    required String imageAsset,
  }) {
    // Changed from Expanded to Container with fixed width
    return Container(
      width: 200, // Fixed width for each card
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Image.asset(
              imageAsset,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Event details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 2),
                Text(
                  location,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
