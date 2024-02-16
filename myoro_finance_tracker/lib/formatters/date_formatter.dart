import 'package:flutter/services.dart';

class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (!RegExp(r'^[0-9]').hasMatch(newValue.text)) return oldValue;

    if ((newValue.text.length == 2 || newValue.text.length == 5) && newValue.text.length > oldValue.text.length) {
      return TextEditingValue(
        text: '${newValue.text}/',
        selection: TextSelection.collapsed(offset: newValue.text.length + 1),
      );
    } else if (newValue.text.length > 10) {
      return oldValue;
    } else {
      return newValue;
    }
  }
}