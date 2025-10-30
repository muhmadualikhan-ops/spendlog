class Expense {
  const Expense({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.amountMinor,
    required this.spentOn,
    this.note = "",
  });

  final String id;
  final String title;
  final String categoryId;
  final int amountMinor;
  final DateTime spentOn;
  final String note;

  Expense copyWith({
    String? title,
    String? categoryId,
    int? amountMinor,
    DateTime? spentOn,
    String? note,
  }) {
    return Expense(
      id: id,
      title: title ?? this.title,
      categoryId: categoryId ?? this.categoryId,
      amountMinor: amountMinor ?? this.amountMinor,
      spentOn: spentOn ?? this.spentOn,
      note: note ?? this.note,
    );
  }
}
