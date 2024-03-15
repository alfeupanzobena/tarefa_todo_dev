import 'package:flutter/material.dart';
import 'package:tarefa_todo_dev/config/theme/app_theme.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    this.controller,
    this.hintText,
    this.maxLines,
    this.readOnly = false,
  });
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppThemeDark.dividerComent,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppThemeDark.dividerComent,
          width: 0.5,
        ),
      ),
      child: TextField(
        readOnly: readOnly,
        cursorColor: AppThemeDark.appBarTextColor,
        style: TextStyle(color: AppThemeDark.appBarTextColor),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        autocorrect: false,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppThemeDark.dividerComent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          iconColor: AppThemeDark.appBarTextColor,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        maxLines: maxLines,
      ),
    );
  }
}
