import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../user/screen/event/event_detail_screen.dart';

class FeatureEventCard extends StatefulWidget {
  final String title;
  final String date;
  final String time;
  final String location;
  final String detail;

  const FeatureEventCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.detail,
  });

  @override
  State<FeatureEventCard> createState() => _FeatureEventCardState();
}

class _FeatureEventCardState extends State<FeatureEventCard> {
  bool isFavourite = false;

  Future<void> _addToFavourite() async {
    await FirebaseFirestore.instance.collection("favorites").add({
      "title": widget.title,
      "date": widget.date,
      "time": widget.time,
      "location": widget.location,
      "detail": widget.detail,
      "createdAt": Timestamp.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Added to Favourite ❤️"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EventDetailsScreen(
              title: widget.title,
              date: widget.date,
              time: widget.time,
              location: widget.location,
              detail: widget.detail, documentId: '',
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: isDark ? theme.cardColor : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: isDark
              ? null
              : const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
          border: isDark ? Border.all(color: Colors.white12) : null,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  child: Image.asset(
                    "assets/images/Rectangle 4.png",
                    height: 190,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 15,
                  right: 15,
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        isFavourite = !isFavourite;
                      });

                      if (isFavourite) {
                        await _addToFavourite();
                      }
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.black45 : Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.headlineMedium?.color,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.red,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "${widget.date} • ${widget.time}",
                          style: TextStyle(
                            color: isDark
                                ? Colors.white70
                                : Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.location,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white70
                                : Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Add to My Calendar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}