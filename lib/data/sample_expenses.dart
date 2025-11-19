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
  SampleExpense(title: "Milk and bread", categoryId: "groceries", amountMinor: 84000, month: 1, day: 1, note: "Imtiaz"),
  SampleExpense(title: "Rice and lentils", categoryId: "groceries", amountMinor: 146500, month: 2, day: 2, note: "Local store"),
  SampleExpense(title: "Fruit from the cart", categoryId: "groceries", amountMinor: 65000, month: 3, day: 3, note: "Sunday bazaar"),
  SampleExpense(title: "Cooking oil", categoryId: "groceries", amountMinor: 102500, month: 4, day: 4, note: "Imtiaz"),
];
