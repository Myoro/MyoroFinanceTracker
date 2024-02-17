class PriceHelper {
  /// Formats a ([String]) price, i.e. 1.234,56 --> 1234.56
  static double formatPrice(String price) => double.parse(price.replaceAll('.', '').replaceAll(',', '.'));
}
