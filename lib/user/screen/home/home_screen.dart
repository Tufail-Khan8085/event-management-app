import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/widgets/filter_dailog.dart';
import '../../../core/widgets/custom_event_card.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../screen/auth/login_screen.dart';
import '../../../setting/settings_screen.dart';
import '../favourite/favorite_screen.dart';
import '../features/feature_screen.dart';
import '../community/community_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
          (route) => false,
    );
  }

  final List<Widget> _screens = [
    const HomeContentView(),
    const FeatureScreen(),
    const CommunityScreen(),
    const FavouriteScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeContentView extends StatelessWidget {
  const HomeContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Stack(
        children: [
          /// 🖼️ BACKGROUND ASSET IMAGE (Yahan aap ki image fit hogi)
          Positioned.fill(
            child: Opacity(
              opacity: isDark ? 0.1 : 1.0,
              child: Image.asset(
                "assets/images/my_bg.png", // 👈 Apni image ka naam replace kar lein
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 15),

                /// Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Events",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.headlineMedium?.color,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => const FilterDialog(),
                          );
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: isDark ? theme.cardColor : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark ? Colors.white24 : Colors.grey.shade300,
                            ),
                          ),
                          child: Icon(
                            Icons.tune,
                            color: isDark ? Colors.white : Colors.black87,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                /// Calendar / List Toggle Switch
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white10 : const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: const Color(0xffE53935),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor: isDark ? Colors.white70 : Colors.black54,
                      dividerColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                      labelStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: const [
                        Tab(text: "Calendar View"),
                        Tab(text: "List View"),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// Tab Bar Views
                Expanded(
                  child: TabBarView(
                    children: [
                      const CalendarView(),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("events")
                            .orderBy("createdAt", descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Something went wrong"),
                            );
                          }

                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final events = snapshot.data!.docs;

                          if (events.isEmpty) {
                            return const Center(
                              child: Text("No Events Found"),
                            );
                          }

                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              final event = events[index];

                              return CustomEventCard(
                                documentId: event.id,
                                title: event["title"] ?? "",
                                date: event["date"] ?? "",
                                time: event["time"] ?? "",
                                location: event["location"] ?? "",
                                detail: event["detail"] ?? "",
                              );
                            },
                          );
                        },
                      )
                    ],
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

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final Map<int, List<Color>> eventDots = {
      2: [Colors.teal, Colors.blue, Colors.red],
      3: [Colors.blue, Colors.red],
      6: [Colors.teal],
      8: [Colors.red],
      10: [Colors.blue, Colors.teal, Colors.red],
      13: [Colors.blue, Colors.red],
      15: [Colors.red, Colors.teal],
      17: [Colors.teal],
      20: [Colors.teal, Colors.red],
      22: [Colors.blue, Colors.teal, Colors.red],
      23: [Colors.red],
      29: [Colors.teal, Colors.blue, Colors.red],
      30: [Colors.red],
      31: [Colors.teal, Colors.red, Colors.blue],
    };

    final daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Column(
                children: [
                  Text(
                    "September",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    "2025",
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white60 : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: daysOfWeek.map((day) {
              return SizedBox(
                width: 38,
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white60 : Colors.indigo.shade300,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 10),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 35,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 4,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              int dayNumber;
              bool isCurrentMonth = true;

              if (index == 0) {
                dayNumber = 31;
                isCurrentMonth = false;
              } else if (index == 1) {
                dayNumber = 30;
                isCurrentMonth = false;
              } else if (index >= 33) {
                dayNumber = index - 32;
                isCurrentMonth = false;
              } else {
                dayNumber = index - 1;
              }

              final dots = isCurrentMonth ? (eventDots[dayNumber] ?? []) : <Color>[];

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$dayNumber",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isCurrentMonth
                          ? (isDark ? Colors.white : Colors.black87)
                          : (isDark ? Colors.white24 : Colors.indigo.shade200),
                    ),
                  ),
                  const SizedBox(height: 3),
                  if (dots.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: dots.map((color) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        );
                      }).toList(),
                    )
                  else
                    const SizedBox(height: 4),
                ],
              );
            },
          ),

          const SizedBox(height: 20),

      Text(
        "Today Events",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),

      const SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("events")
                .orderBy("createdAt", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final today = DateFormat('dd/MM/yyyy').format(DateTime.now());

              final todayEvents = snapshot.data!.docs.where((event) {
                return event["date"] == today;
              }).toList();

              if (todayEvents.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "No Events Today",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return Column(
                children: todayEvents.map((event) {
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

      const SizedBox(height: 20),
        ],
      ),
    );
  }
}