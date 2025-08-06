import 'package:flutter/material.dart';

class CustomDropDownField<T> extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;

  const CustomDropDownField({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: DropdownButtonFormField<T>(

        value: value,
        validator: validator,
        items: items,
        onChanged: onChanged,

        decoration: InputDecoration(
          labelText: label,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        isExpanded: true,
      ),
    );
  }
}
