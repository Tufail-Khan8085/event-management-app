import 'package:flutter/material.dart';
import 'package:event/core/widgets/custom_button.dart';
import 'package:event/core/widgets/custom_textfield.dart';
import 'package:event/core/widgets/image_placeholder.dart';
import 'package:event/screens/navigation/main_navigation.dart';

import '../../navigation/main_navigation.dart';

class VoteScreen extends StatelessWidget {
  const VoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Vote",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const CustomTextField(
                      label: "Question",
                      hintText: "Made in Melanin! Black History Month Social",
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "Options",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const CustomTextField(
                      label: "",
                      hintText: "Option 1",
                    ),
                    const SizedBox(height: 15),
                    const CustomTextField(
                      label: "",
                      hintText: "Option 2",
                    ),
                    const SizedBox(height: 25),
                    const ImagePlaceholder(label: "Upload Image"),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                text: "Vote",
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainNavigation()),
                        (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
