import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../base_page.dart';
import 'event_registration_page.dart';
import '../models/event.dart';
import '../services/api_service.dart';
import '../utils/constants.dart';

class EventDetailsPage extends StatefulWidget {
  final int eventId;
  const EventDetailsPage({required this.eventId, super.key});

  @override
  State<EventDetailsPage> createState() => EventDetailsPageState();
}

class EventDetailsPageState extends State<EventDetailsPage> {
  String? _selectedMembershipType;
  late YoutubePlayerController _youtubeController;
   Map<String, dynamic> eventData = {};
   

   late Future<List<Event>> futureEvents;

  
  // Membership types mapping
  final Map<int, String> _membershipLabels = {
    1: "Regular Member",
    2: "Life / Associate Member",
    3: "Guest / Non-member",
  };

  Map<String, Map<String, dynamic>> _membershipInfo = {}; // Empty initially

  @override
  void initState() {
    super.initState();
    _fetchEventDetails();
     futureEvents = ApiService.fetchEvents();

    _youtubeController = YoutubePlayerController(
      initialVideoId: 'dQw4w9WgXcQ',
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }


Future<void> _fetchEventDetails() async {
  try {
    Event? event = await ApiService.fetchEventByID(widget.eventId);

    if (event != null) {
      Map<String, Map<String, dynamic>> membershipPricing = {};

      if (event.eventPricing.isNotEmpty) {
        for (var pricing in event.eventPricing) {
          int memberTypeId = pricing.memberTypeId;
          String? label;

          // Match membership type logic from Angular
          switch (memberTypeId) {
            case 0:
              label = "Guest / Non-member";
              break;
            case 1:
              label = "Regular Member";
              break;
            case 2:
              label = "Life / Associate Member";
              break;
            default:
              label = "Unknown"; // Fallback for unknown types
          }

          if (label != "Unknown") {
            membershipPricing[label.toLowerCase()] = {
              "display": label,
              "price": double.tryParse(pricing.amount) ?? 0.0,
              "early_bird_price": double.tryParse(pricing.earlyBirdAmount) ?? 0.0,
              "pwd_senior_price": double.tryParse(pricing.pwdSeniorAmount) ?? 0.0,
              "new_board_passer_price": double.tryParse(pricing.newBoardPasserAmt) ?? 0.0,
            };
          }
        }
      }

      setState(() {
        eventData = event.toJson(); // ✅ Store event data
        _membershipInfo = membershipPricing; // ✅ Update membership info
      });

      print("_membershipInfo: $_membershipInfo"); // Debugging output
    } else {
      print("Error: No event data found");
    }
  } catch (e) {
    print("Error fetching event: $e");
  }
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
    if (eventData == null) {
    return const Center(child: CircularProgressIndicator());
    }

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
              child: Text(
                  eventData!["name"] ?? "Event Title",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A0F44),
                  ),
                  textAlign: TextAlign.center,
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
                          color: Color(0xFF181F6C),
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
                                color: Color(0xFF181F6C),
                              ),
                            ),
                            Text(
                              eventData!["formattedDate"] ?? "TBA",
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
                          color: Color(0xFF181F6C),
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
                                color: Color(0xFF181F6C),
                              ),
                            ),
                            Text(
                              eventData!["formattedTime"] ?? "TBA",
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
                          color: Color(0xFF181F6C),
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
                                  color: Color(0xFF181F6C),
                                ),
                              ),
                              Text(
                                eventData!["location"] ?? "N/A",
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
                          color: Color(0xFF181F6C),
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
                                color: Color(0xFF181F6C),
                              ),
                            ),
                        Text(
                            eventData!["type"] == 1 ? "Face-to-Face" : "Virtual",
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
                    color: Color(0xFF181F6C),
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
                            color: Color(0xFF181F6C),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                            eventData!["shortdescription"] ?? "N/A",
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
                child: (eventData?.containsKey("eventimageurl") == true && eventData?["eventimageurl"]?.isNotEmpty == true)
                    ? Image.network(
                      
                        eventData!["eventimageurl"],
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SizedBox(
                            width: 150,
                            height: 150,
                            child: const Center(child: CircularProgressIndicator()),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          print("Error loading image: $error"); // Debugging
                          return Image.asset(
                            'assets/logo.png', // Fallback image
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        'assets/logo.png', // Fallback for empty or null URL
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

                  // Fetch and display events dynamically
                  FutureBuilder<List<Event>>(
                    future: futureEvents,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text("Failed to load events"));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("No events available"));
                      }

                      List<Event> events = snapshot.data!;

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            ...events.map((event) => Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: _buildEventCard(
                                    title: event.title,
                                    date: event.formattedDate,
                                    location: event.location,
                                    imageAsset: event.imageUrl ?? "assets/logo.png",
                                  ),
                                )),
                          ],
                        ),
                      );
                    },
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
                        color: Color(0xFF181F6C),
                      ),
                    ),
                    const SizedBox(height: 16),

                    _buildMembershipOption("regular member"),
                    const Divider(),
                    _buildMembershipOption("life / associate member"),
                    const Divider(),
                    _buildMembershipOption("guest / non-member"),
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

  Widget _buildMembershipOption(String type) {
    final membership = _membershipInfo[type] ?? {
      "display": "Unknown",
      "price": 0.0,
    };

    return ListTile(
      title: Text(
        membership["display"],
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "₱${membership["price"].toStringAsFixed(2)}", // Format as currency
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      leading: Radio<String>(
        value: type,
        groupValue: _selectedMembershipType,
        onChanged: (String? value) {
          setState(() {
            _selectedMembershipType = value;
          });
        },
      ),
    );
  }

  Widget _buildEventCard({
  required String title,
  required String date,
  required String location,
  required String imageAsset,
}) {
  return Container(
    width: 200, // Fixed width for each card
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Event image (Supports both network & local assets)
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          child: imageAsset.startsWith("http") // Check if it's a network image
              ? Image.network(
                  imageAsset,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/logo.png", // Fallback image if network fails
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                )
              : Image.asset(
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
