import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Color? fillColor;
  final Color? textColor;
  final Color? hintTextColor;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool? autoFocus;
  final int? maxLength;
  final bool? filled;
  final bool? showBorder;
  final Widget? suffixIcon;
  final bool? hasBorderside;
  final Iterable<String>? autofillHints;
  final bool? readOnly;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final Color? borderColor;

  const CustomTextfield({
    super.key,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.controller,
    this.textInputAction,
    this.onEditingComplete,
    this.focusNode,
    this.autoFocus = false,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.words,
    this.borderColor,
    this.onChanged,
    this.inputFormatters,
    this.maxLines = 1,
    this.filled = true,
    this.hasBorderside = true,
    this.fillColor = Colors.white,
    this.maxLength,
    this.textColor = Colors.black,
    this.textAlign,
    this.suffixIcon,
    this.autofillHints,
    this.readOnly = false,
    this.initialValue,
    this.onTap,
    this.prefixIcon,
    this.hintTextColor,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      initialValue: initialValue,
      textAlign: textAlign ?? TextAlign.start,
      onChanged: onChanged,
      autofocus: autoFocus!,
      cursorColor: Colors.black,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      readOnly: readOnly!,
      controller: controller,
      cursorWidth: 1.0,
      maxLines: maxLines,
      obscureText: obscureText,
      maxLength: maxLength,
      validator: validator,
      autofillHints: autofillHints,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
          fontSize: 16,
          color: hintTextColor ?? Colors.grey,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: borderColor ?? Colors.grey.shade400,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: borderColor ?? Colors.red,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: borderColor ?? Colors.red,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: borderColor ?? Colors.grey.shade400,
            )),
        fillColor: fillColor,
        filled: filled,
        hintText: hintText,
      ),
      style: TextStyle(
        fontSize: 16,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
