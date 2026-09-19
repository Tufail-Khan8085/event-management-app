import 'package:flutter/material.dart';
import '../screen/auth/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_profile_screen.dart';
import 'notifications_screen.dart';
import 'placeholder_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  final User? user = FirebaseAuth.instance.currentUser;
  String userName = "User";
  Future<void> loadUserName() async {
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();

    if (doc.exists) {
      setState(() {
        userName = doc["name"] ?? "User";
      });
    }
  }

  bool isDarkMode = false;
  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : theme.appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false, // Back arrow hide kar diya
        title: Text(
          "Setting",
          style: TextStyle(
            color: isDarkMode ? Colors.white : const Color(0xFF222222),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),

            /// Profile Section (Avatar with Asset & Fallback, Name, Email)
            Center(
              child: Column(
                children: [
                  // Safe Profile Image Loading
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/Ellipse 12.png",
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person,
                            size: 45,
                            color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user?.email ?? "No Email",
                    style: TextStyle(
                      fontSize: 13,
                      color: isDarkMode ? Colors.white54 : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// Edit Profile Red Pill Button
                  SizedBox(
                    height: 42,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                        );
                      },
                      icon: const Icon(Icons.edit_outlined, color: Colors.white, size: 18),
                      label: const Text(
                        "Edit Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD32F2F),
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25), // Pill shape exact as UI
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// Settings Menu Items
            _buildMenuItem(
              context: context,
              icon: Icons.notifications_none_outlined,
              title: "Notifications",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              ),
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.description_outlined,
              title: "Privacy Policy",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
              ),
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.description_outlined,
              title: "Term & Conditions",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TermsConditionsScreen()),
              ),
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.help_outline_rounded,
              title: "Help & Support",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
              ),
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.share_outlined,
              title: "Invite Your Friend",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InviteFriendScreen()),
              ),
            ),

            /// Dark Mode Row
            _buildMenuItem(
              context: context,
              icon: Icons.nightlight_round_outlined,
              title: "Dark Mode",
              onTap: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
            ),

            /// Logout Row (Red)
            _buildMenuItem(
              context: context,
              icon: Icons.logout_rounded,
              title: "Logout",
              isLogout: true,
              onTap: () => _showLogoutDialog(context),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// Logout Confirmation Dialog Box
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  "Are you sure you want to logout?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white60 : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 46,
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);

                            await FirebaseAuth.instance.signOut();
                            await GoogleSignIn().signOut();

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                                  (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD32F2F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Settings Menu Item Widget
  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    final iconColor = isLogout ? const Color(0xFFD32F2F) : (isDarkMode ? Colors.white70 : Colors.black87);
    final textColor = isLogout ? const Color(0xFFD32F2F) : (isDarkMode ? Colors.white : Colors.black87);

    return Column(
      children: [
        ListTile(
          onTap: onTap,
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
          leading: Icon(
            icon,
            color: iconColor,
            size: 22,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right_rounded,
            size: 20,
            color: isDarkMode ? Colors.white38 : Colors.grey.shade400,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Divider(
            height: 1,
            color: isDarkMode ? Colors.white12 : Colors.grey.shade200,
          ),
        ),
      ],
    );
  }
}