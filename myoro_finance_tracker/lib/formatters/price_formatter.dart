import 'package:flutter/services.dart';

/// [TextInputFormatter] for prices (currently only the brazilian format)
///
/// Use a starting text of 0,00 for 'standard' use, but the logic autocorrect an empty [TextEditingValue] to 0,00
///
/// Example
/// 0,00
/// 0,01
/// 0,12
/// 1,23
/// 12,34
/// 123,45
/// 1.234,56
/// 12.345,67
/// 123.456,78
/// 1.234.567,89
class PriceFormatter extends TextInputFormatter {
  /// i.e. 00,12 --> 0,12
  /// i.e. 1234,56 --> 1.234,56
  String _trimZeroesAndPlaceDots(String text) {
    while (true) {
      if (text[0] == '0' && text.length != 1) {
        text = text.substring(1);
      } else {
        break;
      }
    }

    if (text.length > 3) {
      String result = '';

      final int remainder = text.length % 3;
      for (int i = 0; i < remainder; i++) {
        result += text[0];
        text = text.substring(1);
      }

      while (text.isNotEmpty) {
        result += '${result.isNotEmpty ? '.' : ''}${text.substring(0, 3)}';
        text = text.substring(3);
      }

      return result;
    } else {
      return text;
    }
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (!RegExp(r'^[0-9]').hasMatch(newValue.text)) return oldValue;

    // Empty starting text case
    if (oldValue.text.isEmpty) {
      return TextEditingValue(
        text: '0,0${newValue.text}',
        selection: const TextSelection.collapsed(offset: 4),
      );
    }

    // Adding numbers
    if (newValue.text.length > oldValue.text.length) {
      // Removing numbers when the text is already 0,00
      if (oldValue.text == '0,00' && newValue.text == '0,000') {
        return oldValue;
      }

      // Normal case
      final List<String> split = oldValue.text.split(',');
      return TextEditingValue(
        text: '${_trimZeroesAndPlaceDots('${split[0].replaceAll('.', '')}${split[1][0]}')},${split[1][1]}${newValue.text[newValue.text.length - 1]}',
      );
    }
    // Removing numbers
    else {
      // Removing numbers when the text is already 0,00
      if (oldValue.text == '0,00' && newValue.text == '0,0') {
        return oldValue;
      }

      // Normal case
      final List<String> split = oldValue.text.split(',');
      final String newLHS = split[0].substring(0, split[0].length - 1);
      return TextEditingValue(
        text: '${_trimZeroesAndPlaceDots(newLHS.isEmpty ? '0' : newLHS)},${split[0][split[0].length - 1]}${split[1][0]}',
      );
    }
  }
}
