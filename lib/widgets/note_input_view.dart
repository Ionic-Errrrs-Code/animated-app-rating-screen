// lib/widgets/note_input_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constants.dart';
import 'submit_button.dart';

/// Notes input area shown when user chooses to add additional feedback.
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
      padding: AppDimens.pageHPadding,
      child: Container
      (
        padding: EdgeInsets.all(AppDimens.medium),
        height: 200.h,
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(25), // Corrected deprecated method
          borderRadius: BorderRadius.circular(AppDimens.rLarge),
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
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: AppStrings.noteHint,
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
                padding: EdgeInsets.all(AppDimens.medium),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
