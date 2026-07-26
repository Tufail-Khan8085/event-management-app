import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String? selectedCity;
  String? selectedState;
  String? selectedGroup;

  int selectedCategoryIndex = 1;

  final List<String> cities = ["New York", "Los Angeles", "Chicago", "Houston"];
  final List<String> states = ["California", "Texas", "New Jersey", "Florida"];
  final List<String> groups = ["Group 1", "Group 2", "Group 3"];

  // Types explicitly define kar di hain taake Dynamic casting ka error na aaye
  final List<Map<String, dynamic>> categories = <Map<String, dynamic>>[
    <String, dynamic>{"label": "Religious", "icon": Icons.nightlight_round},
    <String, dynamic>{"label": "Business", "icon": Icons.apartment},
    <String, dynamic>{"label": "Sports", "icon": Icons.directions_run},
    <String, dynamic>{"label": "Education", "icon": Icons.school},
    <String, dynamic>{"label": "Community", "icon": Icons.groups},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: isDark ? theme.cardColor : Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header (Close Icon & Title)
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        size: 22,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    "Filter Events",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// City Dropdown
              _buildLabel("City", isDark),
              const SizedBox(height: 6),
              _buildDropdown(
                hint: "Select City",
                value: selectedCity,
                items: cities,
                isDark: isDark,
                onChanged: (val) => setState(() => selectedCity = val),
              ),

              const SizedBox(height: 15),

              /// State Dropdown
              _buildLabel("State", isDark),
              const SizedBox(height: 6),
              _buildDropdown(
                hint: "Select State",
                value: selectedState,
                items: states,
                isDark: isDark,
                onChanged: (val) => setState(() => selectedState = val),
              ),

              const SizedBox(height: 15),

              /// Groups Dropdown
              _buildLabel("Groups", isDark),
              const SizedBox(height: 6),
              _buildDropdown(
                hint: "Group",
                value: selectedGroup,
                items: groups,
                isDark: isDark,
                onChanged: (val) => setState(() => selectedGroup = val),
              ),

              const SizedBox(height: 20),

              /// Category Chips
              Wrap(
                spacing: 8,
                runSpacing: 10,
                children: List.generate(categories.length, (index) {
                  final isSelected = selectedCategoryIndex == index;
                  final category = categories[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xffE53935)
                            : (isDark ? Colors.white10 : Colors.white),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xffE53935)
                              : (isDark ? Colors.white24 : Colors.grey.shade300),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            category['icon'] as IconData,
                            size: 18,
                            color: isSelected
                                ? Colors.white
                                : (isDark ? Colors.white70 : Colors.grey.shade700),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            category['label'].toString(),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : (isDark ? Colors.white70 : Colors.grey.shade800),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 25),

              /// Bottom Action Buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedCity = null;
                            selectedState = null;
                            selectedGroup = null;
                            selectedCategoryIndex = -1;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: isDark ? Colors.white38 : Colors.grey.shade400,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Clear Filter",
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffE53935),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Apply Filter",
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, bool isDark) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black87,
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required bool isDark,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? Colors.white24 : Colors.grey.shade300,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: TextStyle(
              color: isDark ? Colors.white38 : Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: isDark ? Colors.white60 : Colors.black54,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}