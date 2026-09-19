import 'package:flutter/material.dart';
import 'package:event/core/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../calendar/my_calendar_screen.dart';
import 'edit_event_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventDetailsScreen extends StatelessWidget {

  final String title;
  final String date;
  final String time;
  final String location;
  final String detail;
  final String documentId;

  const EventDetailsScreen({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.detail,
    required this.documentId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Event Image
                Image.asset(
                  "assets/images/Rectangle 555.png",
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.cover,
                ),

                // Back and Favourite Buttons
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // TODO: Add to Favourite logic
                          },
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Event Content
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.headlineMedium?.color,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Date and Time
                  Row(
                    children: [
                      Icon(Icons.calendar_month, color: isDark ? Colors.white70 : Colors.black, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        "$date  $time",
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Location
                  Row(
                    children: [
                      Icon(Icons.location_on, color: isDark ? Colors.white70 : Colors.black, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Text(
                    "Event Detail",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.titleLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Description Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? theme.cardColor : const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05)),
                    ),
                    child:Text(
                      detail,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white70 : Colors.grey,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Add to Calendar Button
                  CustomButton(
                    text: "Add to my calendar",
                    onPressed: () async {
                      await FirebaseFirestore.instance.collection("my_calendar").add({
                        "userId": FirebaseAuth.instance.currentUser!.uid,
                        "title": title,
                        "date": date,
                        "time": time,
                        "location": location,
                        "detail": detail,
                        "createdAt": Timestamp.now(),
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Event added to My Calendar"),
                        ),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MyCalendarScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    text: "Edit Event",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditEventScreen(
                            documentId: documentId,
                            title: title,
                            date: date,
                            time: time,
                            location: location,
                            detail: detail,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 15),
                  CustomButton(
                    text: "Delete Event",
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("events")
                          .doc(documentId)
                          .delete();

                      if (context.mounted) {
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Event Deleted Successfully"),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
