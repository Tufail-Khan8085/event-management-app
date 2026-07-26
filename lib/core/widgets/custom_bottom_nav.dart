import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? theme.scaffoldBackgroundColor : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.white12 : const Color(0xFFE5E5E5),
          ),
        ),
      ),
      // 👈 SafeArea mobile ke niche wale system bar se icons ko bachatay hain
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _item(context, index: 0, icon: Icons.home, text: "Home"),
              _item(context, index: 1, icon: Icons.star, text: "Features"),
              _item(context, index: 2, icon: Icons.groups_outlined, text: "Community"),
              _item(context, index: 3, icon: Icons.favorite_border, text: "Favourite"),
              _item(context, index: 4, icon: Icons.settings_outlined, text: "Settings"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(
      BuildContext context, {
        required int index,
        required IconData icon,
        required String text,
      }) {
    final bool selected = currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: selected ? Colors.red : (isDark ? Colors.white60 : Colors.grey),
            ),
            const SizedBox(height: 3),
            // 👈 FittedBox ensure karta hai ke text screen se bahar na nikle
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                  text,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 11,
                    color: selected ? Colors.red : (isDark ? Colors.white60 : Colors.grey),
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
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