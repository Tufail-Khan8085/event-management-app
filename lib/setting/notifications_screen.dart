import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  /// 💡 Total 6 Notifications Boxes
  final List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "title": "Lorem ipsum dolor sit amet consectetur.",
      "image": "assets/images/Rectangle 15.png", // Box 1 Image
      "time": "4:00pm",
      "isRead": false,
    },
    {
      "id": 2,
      "title": "Lorem ipsum dolor sit amet consectetur.",
      "image": "assets/images/Rectangle 15.png", // Box 2 Image
      "time": "4:00pm",
      "isRead": false,
    },
    {
      "id": 3,
      "title": "Lorem ipsum dolor sit amet consectetur.",
      "image": "assets/images/Rectangle 15.png", // Box 3 Image
      "time": "4:00pm",
      "isRead": false,
    },
    {
      "id": 4,
      "title": "Lorem ipsum dolor sit amet consectetur.",
      "image": "assets/images/Rectangle 15.png", // Box 4 Image
      "time": "4:00pm",
      "isRead": true,
    },
    {
      "id": 5,
      "title": "Lorem ipsum dolor sit amet consectetur.",
      "image": "assets/images/Rectangle 15.png", // Box 5 Image
      "time": "4:00pm",
      "isRead": true,
    },
    {
      "id": 6,
      "title": "Lorem ipsum dolor sit amet consectetur.",

      // 👇 6th BOX KI PICTURE YAHAN ADD KAREIN:
      "image": "assets/images/Rectangle 15.png",

      "time": "4:00pm",
      "isRead": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Notification",
          style: TextStyle(
            color: isDark ? Colors.white : const Color(0xFF222222),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];

          final String title = item["title"]?.toString() ?? "Notification";
          final String imagePath = item["image"]?.toString() ?? "";
          final String time = item["time"]?.toString() ?? "";
          final bool isRead = item["isRead"] == true;

          return GestureDetector(
            onTap: () {
              setState(() {
                notifications[index]["isRead"] = true;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? theme.cardColor : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(14),
                border: isDark ? Border.all(color: Colors.white10) : null,
              ),
              child: Row(
                children: [
                  /// Har Box ki apni Specific Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: imagePath.isNotEmpty
                        ? Image.asset(
                      imagePath,
                      width: 52,
                      height: 52,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildFallbackIcon(isDark);
                      },
                    )
                        : _buildFallbackIcon(isDark),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black87,
                        height: 1.35,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  SizedBox(
                    height: 52,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!isRead)
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD32F2F),
                              shape: BoxShape.circle,
                            ),
                          )
                        else
                          const SizedBox(height: 10),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.white54 : Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFallbackIcon(bool isDark) {
    return Container(
      width: 52,
      height: 52,
      color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
      child: Icon(
        Icons.image_outlined,
        size: 26,
        color: isDark ? Colors.white38 : Colors.grey.shade600,
      ),
    );
  }
}