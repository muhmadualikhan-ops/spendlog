import "../models/expense.dart";

Map<String, Object?> expenseToJson(Expense expense) {
  return {
    "id": expense.id,
    "title": expense.title,
    "categoryId": expense.categoryId,
    "amountMinor": expense.amountMinor,
    "spentOn": expense.spentOn.toIso8601String(),
    "note": expense.note,
  };
}

Expense expenseFromJson(Map<String, Object?> json) {
  return Expense(
    id: json["id"] as String,
    title: json["title"] as String,
    categoryId: json["categoryId"] as String,
    amountMinor: json["amountMinor"] as int,
    spentOn: DateTime.parse(json["spentOn"] as String),
    note: (json["note"] as String?) ?? "",
  );
}
