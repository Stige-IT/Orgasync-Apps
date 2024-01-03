import 'package:flutter/material.dart';

class FieldInput extends StatelessWidget {
  final String? title;
  final TextAlign? textAlign;
  final String? hintText;
  final Icon? prefixIcons;
  final TextEditingController controllers;
  final TextInputType? keyboardType;
  final bool obsecureText;
  final IconButton? suffixIcon;
  final bool? enable;
  final bool? isRounded;
  final String? prefixText;
  final String? suffixText;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool borderActive;

  const FieldInput({
    super.key,
    this.title,
    required this.hintText,
    this.prefixIcons,
    required this.controllers,
    this.keyboardType = TextInputType.text,
    this.obsecureText = false,
    this.suffixIcon,
    this.enable,
    this.prefixText,
    this.onChanged,
    this.onEditingComplete,
    this.isRounded = false,
    this.validator,
    this.suffixText,
    this.onTap,
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.borderActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 5),
            child: Text(
              title ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          child: TextFormField(
            textAlign: textAlign!,
            minLines: keyboardType == TextInputType.multiline ? null : 1,
            maxLines:
                (keyboardType == TextInputType.multiline && maxLines == null)
                    ? null
                    : maxLines ?? 1,
            obscureText: obsecureText,
            controller: controllers,
            keyboardType: keyboardType,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            validator: validator ??
                (String? value) {
                  if (value!.isEmpty || value == "0") {
                    return;
                  }
                  return null;
                },
            onSaved: (String? val) {
              controllers.text = val!;
            },
            decoration: InputDecoration(
              prefixText: prefixText,
              contentPadding: const EdgeInsets.all(20),
              suffixIcon: suffixIcon,
              border: borderActive
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        isRounded! ? 50 : 5,
                      ),
                    )
                  : InputBorder.none,
              hintText: hintText,
              enabled: enable ?? true,
              prefixIcon: prefixIcons,
              suffixText: suffixText,
            ),
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
