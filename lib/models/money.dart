class Money {
  const Money(this.minor);

  final int minor;

  static const int scale = 100;

  factory Money.parse(String input) {
    final cleaned = input.trim().replaceAll(",", "");
    if (cleaned.isEmpty) {
      throw const FormatException("Enter an amount.");
    }
    final match = RegExp(r"^(\d+)(?:\.(\d{1,2}))?$").firstMatch(cleaned);
    if (match == null) {
      throw const FormatException("Use a number like 250 or 250.50.");
    }
    final rupees = int.parse(match.group(1)!);
    final fraction = match.group(2);
    final paisa = fraction == null ? 0 : int.parse(fraction.padRight(2, "0"));
    return Money(rupees * scale + paisa);
  }

  String format({String symbol = "Rs"}) {
    final negative = minor < 0;
    final absolute = minor.abs();
    final rupees = absolute ~/ scale;
    final paisa = absolute % scale;
    final grouped = _group(rupees);
    final body = paisa == 0 ? grouped : "$grouped.${paisa.toString().padLeft(2, "0")}";
    return negative ? "-$symbol $body" : "$symbol $body";
  }

  static String _group(int value) {
    final text = value.toString();
    final buffer = StringBuffer();
    for (var index = 0; index < text.length; index += 1) {
      final remaining = text.length - index;
      if (index > 0 && remaining % 3 == 0) buffer.write(",");
      buffer.write(text[index]);
    }
    return buffer.toString();
  }
}
