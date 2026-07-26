import 'package:flutter/material.dart';

import '../../../admin/vote/vote_screen.dart';
import '../../../create_event/create_event_screen.dart';
import 'group_profile_screen.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      /// 1️⃣ Top Red App Bar
      appBar: AppBar(
        backgroundColor: const Color(0xFFD32F2F),
        elevation: 0,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const GroupProfileScreen(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(30),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/images/Ellipse 5.png"),
              ),
              SizedBox(width: 12),
              Text(
                "Business group",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const GroupProfileScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      /// 2️⃣ Body with Full Brightness Background Image
      body: Stack(
        children: [
          /// 🖼️ Fixed Background Image (Opacity Removed for 100% Full Visibility)
          Positioned.fill(
            child: Image.asset(
              "assets/images/my_bg.png",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback container agar image asset load na ho
                return Container(
                  color: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
                );
              },
            ),
          ),

          /// Main Feed Content
          Column(
            children: [
              const SizedBox(height: 12),
              Center(
                child: Text(
                  "Today",
                  style: TextStyle(
                    color: isDark ? Colors.white60 : Colors.grey.shade600,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              /// Poll Feed Cards List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return const CommunityEventCard();
                  },
                ),
              ),
            ],
          ),
        ],
      ),

      /// 3️⃣ Dynamic Floating Action Buttons
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFAB(
              context: context,
              icon: Icons.how_to_vote,
              label: "Vote",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VoteScreen()),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildFAB(
              context: context,
              icon: Icons.add,
              label: "Event",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateEventScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Custom FAB Reusable Widget
  Widget _buildFAB({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: const Color(0xFFD32F2F),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 22),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dynamic Interactive Poll Card
class CommunityEventCard extends StatefulWidget {
  const CommunityEventCard({super.key});

  @override
  State<CommunityEventCard> createState() => _CommunityEventCardState();
}

class _CommunityEventCardState extends State<CommunityEventCard> {
  String _selectedOption = 'A';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isDark
            ? null
            : [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: isDark ? Border.all(color: Colors.white12) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Event Banner Image with Navigation
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GroupProfileScreen()),
              );
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.asset(
                "assets/images/Rectangle 555.png",
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                    child: const Icon(Icons.image, size: 50, color: Colors.grey),
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Card Header Title
                Text(
                  "Made in Melanin! Black History Month Social",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 14),

                /// Option A
                _buildPollOption(
                  letter: "A.",
                  text: "Made in Melanin! Black History Month Social",
                  votes: "12k Votes",
                  optionKey: "A",
                ),

                const SizedBox(height: 12),

                /// Option B
                _buildPollOption(
                  letter: "B.",
                  text: "Made in Melanin! Black History Month Social",
                  votes: "12k Votes",
                  optionKey: "B",
                ),

                const SizedBox(height: 14),

                /// Timestamp
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "12hr ago",
                    style: TextStyle(
                      color: isDark ? Colors.white54 : Colors.grey.shade600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper to render interactive poll options
  Widget _buildPollOption({
    required String letter,
    required String text,
    required String votes,
    required String optionKey,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _selectedOption == optionKey;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _selectedOption = optionKey;
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            letter,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(width: 8),

          /// Custom Radio Button Indicator
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFFD32F2F) : Colors.grey.shade400,
                width: 1.8,
              ),
            ),
            child: isSelected
                ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFD32F2F),
                  shape: BoxShape.circle,
                ),
              ),
            )
                : null,
          ),
          const SizedBox(width: 10),

          /// Option Title & Vote Count
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  votes,
                  style: TextStyle(
                    fontSize: 10,
                    color: isDark ? Colors.white54 : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}