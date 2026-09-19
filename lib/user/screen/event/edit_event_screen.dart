import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/core/widgets/custom_button.dart';
import 'package:event/core/widgets/custom_textfield.dart';

class EditEventScreen extends StatefulWidget {
  final String documentId;
  final String title;
  final String date;
  final String time;
  final String location;
  final String detail;

  const EditEventScreen({
    super.key,
    required this.documentId,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.detail,
  });

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late TextEditingController titleController;
  late TextEditingController dateController;
  late TextEditingController timeController;
  late TextEditingController locationController;
  late TextEditingController detailController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.title);
    dateController = TextEditingController(text: widget.date);
    timeController = TextEditingController(text: widget.time);
    locationController = TextEditingController(text: widget.location);
    detailController = TextEditingController(text: widget.detail);
  }

  Future<void> updateEvent() async {
    await FirebaseFirestore.instance
        .collection("events")
        .doc(widget.documentId)
        .update({
      "title": titleController.text.trim(),
      "date": dateController.text.trim(),
      "time": timeController.text.trim(),
      "location": locationController.text.trim(),
      "detail": detailController.text.trim(),
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Event Updated Successfully"),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Event"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(
              controller: titleController,
              label: "Title",
              hintText: "",
            ),
            const SizedBox(height: 15),

            CustomTextField(
              controller: dateController,
              label: "Date",
              hintText: "",
            ),
            const SizedBox(height: 15),

            CustomTextField(
              controller: timeController,
              label: "Time",
              hintText: "",
            ),
            const SizedBox(height: 15),

            CustomTextField(
              controller: locationController,
              label: "Location",
              hintText: "",
            ),
            const SizedBox(height: 15),

            CustomTextField(
              controller: detailController,
              label: "Detail",
              hintText: "",
              isMultiline: true,
              maxLines: 5,
            ),
            const SizedBox(height: 30),

            CustomButton(
              text: "Update Event",
              onPressed: updateEvent,
            ),
          ],
        ),
      ),
    );
  }
}