import 'package:flutter/material.dart';
import 'package:event/core/widgets/custom_button.dart';

import '../../../core/widgets/custom_button.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

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
                  "assets/images/event1.png",
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
                    "Made in Melanin! Black History Month Social.....",
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
                        "28 October 2025 6:00pm GMT",
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
                          "1901 Thornridge Cir. Shiloh, Hawaii 81063",
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
                    child: Text(
                      "Lorem ipsum dolor sit amet consectetur. Sed volutpat euismod enim accumsan quam posuere. Tortor pretium lorem dui metus amet in sed. Sodales volutpat maecenas et quisque nibh ult Enim fames quam turpis pellentesque vivamus massa.Lorem ipsum dolor sit amet consectetur. Sed volutpat euismod enim accumsan",
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
                    onPressed: () {
                      // TODO: Add to Calendar Logic
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
