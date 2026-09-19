import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:event/core/widgets/custom_event_card.dart';


class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Month Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDark ? theme.cardColor : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: isDark ? Border.all(color: Colors.white12) : null,
                ),
                child: Icon(Icons.chevron_left, color: isDark ? Colors.white : Colors.black),
              ),
              Column(
                children: [
                  Text(
                    "September",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.headlineMedium?.color,
                    ),
                  ),
                  const Text(
                    "2025",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDark ? theme.cardColor : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: isDark ? Border.all(color: Colors.white12) : null,
                ),
                child: Icon(Icons.chevron_right, color: isDark ? Colors.white : Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 30),

          /// Days
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"
            ].map((day) => Text(
              day,
              style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
            )).toList(),
          ),
          const SizedBox(height: 20),

          /// Calendar Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 35,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final isSelected = index == 10;
              return Container(
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(
                      color: isSelected ? Colors.white : (isDark ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 30),
          Text(
            "Today's Events",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.titleLarge?.color,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 100,
            width: double.infinity,
            color: Colors.red,
          ),

          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("my_calendar")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final events = snapshot.data!.docs;
              print("Events Count = ${events.length}");

              if (events.isEmpty) {
                return const Text("No Events Found");
              }

              return Column(
                children: events.map((event) {
                  return CustomEventCard(
                    documentId: event.id,
                    title: event["title"] ?? "",
                    date: event["date"] ?? "",
                    time: event["time"] ?? "",
                    location: event["location"] ?? "",
                    detail: event["detail"] ?? "",
                  );
                }).toList(),
              );
            },
          ),

          /// Temporary Event Card
        ],
      ),
    );
  }
}
