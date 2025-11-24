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
  SampleExpense(title: "Eggs and yogurt", categoryId: "groceries", amountMinor: 60000, month: 5, day: 5, note: "Nearby shop"),
  SampleExpense(title: "Chai and samosa", categoryId: "food", amountMinor: 25500, month: 6, day: 6, note: "Office canteen"),
  SampleExpense(title: "Chicken karahi", categoryId: "food", amountMinor: 174000, month: 7, day: 7, note: "Dinner out"),
  SampleExpense(title: "Chicken biryani", categoryId: "food", amountMinor: 55500, month: 8, day: 8, note: "Lunch"),
];
