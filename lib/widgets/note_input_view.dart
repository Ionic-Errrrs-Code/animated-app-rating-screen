// lib/widgets/note_input_view.dart

import 'package:flutter/material.dart';
import 'submit_button.dart';

class NoteInputView extends StatelessWidget {
  final Color darkColor;
  final FocusNode focusNode;
  final VoidCallback onSubmit;

  const NoteInputView({
    super.key,
    required this.darkColor,
    required this.focusNode,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 200,
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(25), // Corrected deprecated method
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                focusNode: focusNode,
                maxLines: null, // Allows multiline input
                keyboardType: TextInputType.multiline,
                cursorColor: darkColor,
                style: TextStyle(
                    color: darkColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: 'Add note...',
                  hintStyle: TextStyle(
                      color: darkColor.withAlpha(153),
                      fontWeight:
                          FontWeight.w600), // Corrected deprecated method
                  border: InputBorder.none,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SubmitButton(
                onPressed: onSubmit,
                backgroundColor: darkColor,
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
