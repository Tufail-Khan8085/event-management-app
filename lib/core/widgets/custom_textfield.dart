import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData? suffixIcon;
  final bool isMultiline;
  final int? maxLines;
  final bool readOnly;
  final TextEditingController? controller;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.suffixIcon,
    this.isMultiline = false,
    this.maxLines,
    this.readOnly = false,
    this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          maxLines: isMultiline ? (maxLines ?? 8) : 1,

          // 1. Text saaf dikhega (Transparent nahi hoga)
          style: TextStyle(
            fontSize: 14,
            color: isDark ? Colors.white : Colors.black,
          ),

          decoration: InputDecoration(
            hintText: hintText,

            // 2. Sample text (Hint) halka grey saaf dikhega
            hintStyle: TextStyle(
              color: isDark ? Colors.white38 : Colors.grey.shade400,
              fontSize: 14,
            ),

            suffixIcon: suffixIcon != null
                ? Icon(
              suffixIcon,
              color: isDark ? Colors.white60 : Colors.grey.shade600,
              size: 20,
            )
                : null,

            // 3. Dabbe (Box) ka background transparent rahega
            filled: true,
            fillColor: Colors.transparent,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}