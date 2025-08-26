import 'package:flutter/material.dart';
import 'submit_button.dart';

class ActionButtons extends StatelessWidget {
  final Color color;
  final VoidCallback onAddNote;
  final VoidCallback onSubmit;

  const ActionButtons({
    super.key,
    required this.color,
    required this.onAddNote,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(25),
        borderRadius: BorderRadius.circular(30),
        //  border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: onAddNote,
              style: TextButton.styleFrom(
                foregroundColor: color,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Add notes',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          Expanded(
            child: SubmitButton(
              onPressed: onSubmit,
              backgroundColor: color,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}
