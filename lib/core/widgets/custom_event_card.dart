import 'package:flutter/material.dart';

class CustomEventCard extends StatelessWidget {
  const CustomEventCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: isDark ? Colors.white12 : Colors.grey.shade300),
      ),
      child: Column(
        children: [
          /// Top Row
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
                  // Agar image na mile toh app hide hone ki bajaye yeh icon dikhayega:
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 50,
                      height: 50,
                      color: isDark ? Colors.white12 : Colors.grey.shade200,
                      child: Icon(
                        Icons.person,
                        color: isDark ? Colors.white60 : Colors.grey,
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
                      "Tech Meetup",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Wed, 5 Nov 2025, 2:00PM - 3:00PM",
                      style: TextStyle(
                        color: isDark ? Colors.white60 : Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.favorite_border,
                color: isDark ? Colors.white60 : Colors.black54,
              ),
            ],
          ),
          const SizedBox(height: 12),

          /// Location Row
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
                  "2464 Royal Ln. Mesa, New Jersey 45463",
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.white70 : Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          /// Add to my calendar Button
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
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
    );
  }
}