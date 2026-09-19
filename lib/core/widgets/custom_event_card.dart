import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../user/screen/event/event_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomEventCard extends StatefulWidget {
  final String title;
  final String date;
  final String time;
  final String location;
  final String detail;
  final String documentId;

  const CustomEventCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.detail,
    required this.documentId,
  });

  @override
  State<CustomEventCard> createState() => _CustomEventCardState();
}

class _CustomEventCardState extends State<CustomEventCard> {
  bool isFavourite = false;

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
              documentId: widget.documentId,
              title: widget.title,
              date: widget.date,
              time: widget.time,
              location: widget.location,
              detail: widget.detail,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? theme.cardColor : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDark ? Colors.white12 : Colors.grey.shade300,
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "assets/images/Rectangle 4.png",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 50,
                        height: 50,
                        color: isDark
                            ? Colors.white12
                            : Colors.grey.shade200,
                        child: Icon(
                          Icons.person,
                          color: isDark
                              ? Colors.white60
                              : Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.titleLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${widget.date}, ${widget.time}",
                        style: TextStyle(
                          color: isDark
                              ? Colors.white60
                              : Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isFavourite = !isFavourite;
                    });

                    if (isFavourite) {
                      await FirebaseFirestore.instance.collection("favorites").add({
                        "userId": FirebaseAuth.instance.currentUser!.uid,
                        "eventId": widget.documentId,
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
                    } else {
                      final fav = await FirebaseFirestore.instance
                          .collection("favorites")
                          .where("userId",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .where("eventId", isEqualTo: widget.documentId)
                          .get();

                      for (var doc in fav.docs) {
                        await doc.reference.delete();
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Removed from Favourite"),
                        ),
                      );
                    }
                  },
                  child: Icon(
                    isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: isFavourite
                        ? Colors.red
                        : (isDark ? Colors.white60 : Colors.black54),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                        widget.location,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? Colors.white70
                          : Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("my_calendar")
                        .add({
                      "userId": FirebaseAuth.instance.currentUser!.uid,
                      "title": widget.title,
                      "date": widget.date,
                      "time": widget.time,
                      "location": widget.location,
                      "detail": widget.detail,
                      "createdAt": Timestamp.now(),
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Added to My Calendar"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffE53935),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Add to my calendar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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