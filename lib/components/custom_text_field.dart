import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final bool isPassword;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final String? prefixText;

  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.isPassword = false,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.prefixText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label),
          SizedBox(height: 5),
          TextField(
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            controller: widget.controller,
            obscureText: isObscureText && widget.isPassword,

            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey),
              ),
              fillColor: Colors.grey.shade100,
              filled: true,
              prefixText: widget.prefixText,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isObscureText = !isObscureText;
                        });
                      },
                      icon: Icon(
                        isObscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey.shade600,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
