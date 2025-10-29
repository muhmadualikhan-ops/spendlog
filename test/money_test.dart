import "package:flutter_test/flutter_test.dart";
import "package:spendlog/models/money.dart";

void main() {
  test("parses whole rupees into paisa", () {
    expect(Money.parse("250").minor, 25000);
  });

  test("parses a decimal amount", () {
    expect(Money.parse("250.50").minor, 25050);
  });

  test("ignores thousands separators", () {
    expect(Money.parse("1,250").minor, 125000);
  });

  test("rejects an empty amount", () {
    expect(() => Money.parse("  "), throwsFormatException);
  });

  test("groups thousands when formatting", () {
    expect(Money(125050).format(), "Rs 1,250.50");
  });

  test("hides paisa when the amount is whole", () {
    expect(Money(25000).format(), "Rs 250");
  });
}
