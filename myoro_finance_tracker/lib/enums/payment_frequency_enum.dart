enum PaymentFrequencyEnum {
  daily('Daily'),
  weekly('Weekly'),
  monthly('Monthly'),
  yearly('Yearly');

  final String title;

  const PaymentFrequencyEnum(this.title);
}
