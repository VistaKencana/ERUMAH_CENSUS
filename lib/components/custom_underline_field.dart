import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomUnderlineField extends StatelessWidget {
  final String? title;
  final Color? fillColor;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? titleStyle;
  final String? Function(String? value)? validator;
  final void Function()? onTap;
  final void Function(String value)? onChanged;
  final AutovalidateMode autovalidateMode;
  final TextStyle errorStyle;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final bool readOnly;
  final int? maxLines;
  final bool? enabled;
  final bool addBorder;
  final bool isMandatory;
  final bool canEdit;
  final void Function()? onEdit;
  const CustomUnderlineField({
    super.key,
    this.title,
    this.fillColor,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixIcon,
    this.suffixWidget,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding,
    this.labelStyle,
    this.titleStyle,
    this.hintStyle,
    this.validator,
    this.onTap,
    this.onChanged,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.errorStyle = const TextStyle(height: 0.01),
    this.inputFormatters,
    this.initialValue,
    this.readOnly = false,
    this.maxLines = 1,
    this.enabled = true,
    this.addBorder = true,
    this.isMandatory = false,
    this.canEdit = true,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Row(
            children: [
              Text(title!,
                  style: titleStyle ??
                      const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF7E7E7E))),
              if (isMandatory)
                const Text(
                  "*",
                  style: TextStyle(color: Colors.red),
                )
            ],
          ),
        SizedBox(
          height: 40,
          child: TextFormField(
            enabled: enabled,
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            autovalidateMode: autovalidateMode,
            readOnly: readOnly,
            validator: validator,
            onTap: onTap,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: false,
              hintText: hintText,
              fillColor: fillColor,
              enabledBorder: addBorder
                  ? const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFA4A8AD)),
                    )
                  : null,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              contentPadding: contentPadding ??
                  const EdgeInsets.only(left: 0.0, right: 12.0, top: 5),
              labelStyle: labelStyle ?? const TextStyle(fontSize: 16),
              hintStyle: hintStyle ?? const TextStyle(color: Colors.grey),
              prefixIcon: prefixWidget ??
                  (prefixIcon != null
                      ? Icon(prefixIcon, color: Colors.grey)
                      : null),
              suffixIcon: (canEdit)
                  ? GestureDetector(
                      onTap: onEdit, child: const Icon(Icons.edit_note))
                  : suffixWidget ??
                      (suffixIcon != null ? Icon(suffixIcon) : null),
            ),
          ),
        ),
      ],
    );
  }
}
