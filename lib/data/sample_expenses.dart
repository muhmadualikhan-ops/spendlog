import "../models/expense.dart";

class SampleExpense {
  const SampleExpense({
    required this.title,
    required this.categoryId,
    required this.amountMinor,
    required this.month,
    required this.day,
    required this.note,
  });

  final String title;
  final String categoryId;
  final int amountMinor;
  final int month;
  final int day;
  final String note;

  Expense toExpense(int index) {
    return Expense(
      id: "sample-$index",
      title: title,
      categoryId: categoryId,
      amountMinor: amountMinor,
      spentOn: DateTime(2026, month, day),
      note: note,
    );
  }
}

const List<SampleExpense> sampleExpenses = <SampleExpense>[
];
