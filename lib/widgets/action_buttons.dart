import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constants.dart';
import 'submit_button.dart';

/// Bottom action bar with Add notes and Submit actions.
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
      margin: EdgeInsets.symmetric(horizontal: 50.w),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(25),
        borderRadius: BorderRadius.circular(AppDimens.rPill),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: onAddNote,
              style: TextButton.styleFrom(
                foregroundColor: color,
                padding: EdgeInsets.symmetric(vertical: AppDimens.medium),
              ),
              child: const Text(
                AppStrings.addNotes,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          Expanded(
            child: SubmitButton(
              onPressed: onSubmit,
              backgroundColor: color,
              padding: EdgeInsets.symmetric(vertical: AppDimens.medium),
            ),
          ),
        ],
      ),
    );
  }
}
