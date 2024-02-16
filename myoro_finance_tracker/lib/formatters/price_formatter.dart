import 'package:flutter/services.dart';

class PriceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (!RegExp(r'^[0-9]').hasMatch(newValue.text)) return oldValue;

    // Start of input
    if(oldValue.text.isEmpty) {
      return TextEditingValue(
        text: '0,0${newValue.text}',
        selection: const TextSelection.collapsed(offset: 4),
      );
    } else {
      // Inputting 0 when the price is already 0
      if(newValue.text == '0,000') {
        return oldValue;
      } else if(newValue.text.contains('0,00')) {
        return TextEditingValue(
          text: '0,0${newValue.text}',
          selection: const TextSelection.collapsed(offset: 4),
        );
      }

      // Every other case
      for(int i = 0; i < newValue.text.length; i++) {
        if(newValue.text[i] == ',') {
          List<String> result = newValue.text.split(',');

          return TextEditingValue(
            text: '${result[0]}${result[1][0]},${result[1][1-2]}',
            selection: TextSelection.collapsed(offset: newValue.text.length),
          );
        }
      }

      return newValue;
    }
  }
}