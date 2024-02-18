import 'package:myoro_finance_tracker/formatters/price_formatter.dart';

class PriceHelper {
  /// Formats a ([String]) price, i.e. 1.234,56 --> 1234.56
  static double formatPriceToDouble(String price) => double.parse(price.replaceAll('.', '').replaceAll(',', '.'));

  /// i.e. 00,12 --> 0,12
  /// i.e. 1234,56 --> 1.234,56
  /// NOTE: Only takes the LHS (price without cents) because of [PriceFormatter]
  static String formatPriceToBrazilianFormat(String text) {
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
}
