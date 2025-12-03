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
  SampleExpense(title: "Breakfast paratha", categoryId: "food", amountMinor: 34000, month: 9, day: 9, note: "Dhaba"),
  SampleExpense(title: "Fresh juice", categoryId: "food", amountMinor: 38500, month: 10, day: 10, note: "On the way home"),
  SampleExpense(title: "Careem ride", categoryId: "transport", amountMinor: 63000, month: 11, day: 11, note: "Office commute"),
  SampleExpense(title: "Petrol", categoryId: "transport", amountMinor: 136500, month: 12, day: 12, note: "Bike"),
  SampleExpense(title: "Bus card top up", categoryId: "transport", amountMinor: 68000, month: 1, day: 13, note: "Metro"),
  SampleExpense(title: "Rickshaw", categoryId: "transport", amountMinor: 34500, month: 2, day: 14, note: "Short trip"),
  SampleExpense(title: "Jazz load", categoryId: "bills", amountMinor: 51000, month: 3, day: 15, note: "Mobile"),
  SampleExpense(title: "K-Electric bill", categoryId: "bills", amountMinor: 662500, month: 4, day: 16, note: "Home"),
  SampleExpense(title: "Internet bill", categoryId: "bills", amountMinor: 274000, month: 5, day: 17, note: "Monthly"),
  SampleExpense(title: "Gas bill", categoryId: "bills", amountMinor: 205500, month: 6, day: 18, note: "Home"),
  SampleExpense(title: "Pharmacy", categoryId: "health", amountMinor: 103000, month: 7, day: 19, note: "Cold medicine"),
  SampleExpense(title: "Clinic visit", categoryId: "health", amountMinor: 200000, month: 8, day: 20, note: "Checkup"),
  SampleExpense(title: "Vitamins", categoryId: "health", amountMinor: 96500, month: 9, day: 21, note: "Monthly"),
  SampleExpense(title: "Phone cable", categoryId: "shopping", amountMinor: 68000, month: 10, day: 22, note: "Market"),
  SampleExpense(title: "Notebooks", categoryId: "shopping", amountMinor: 46500, month: 11, day: 23, note: "Stationery"),
  SampleExpense(title: "Shirt", categoryId: "shopping", amountMinor: 226000, month: 12, day: 24, note: "Weekend"),
  SampleExpense(title: "Room rent", categoryId: "rent", amountMinor: 1807500, month: 1, day: 25, note: "Monthly"),
];
