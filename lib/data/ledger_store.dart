import "dart:convert";

import "../models/expense.dart";
import "ledger_codec.dart";

class LedgerStore {
  final List<Expense> _items = <Expense>[];

  List<Expense> get items => List<Expense>.unmodifiable(_items);

  void replaceAll(List<Expense> next) {
    _items
      ..clear()
      ..addAll(next);
    _sort();
  }

  void add(Expense expense) {
    _items.add(expense);
    _sort();
  }

  void update(Expense expense) {
    final index = _items.indexWhere((item) => item.id == expense.id);
    if (index < 0) {
      add(expense);
      return;
    }
    _items[index] = expense;
    _sort();
  }

  bool remove(String id) {
    final before = _items.length;
    _items.removeWhere((item) => item.id == id);
    return _items.length != before;
  }

  Expense? find(String id) {
    for (final item in _items) {
      if (item.id == id) return item;
    }
    return null;
  }

  List<Expense> forMonth(int year, int month) {
    return _items.where((item) => item.spentOn.year == year && item.spentOn.month == month).toList();
  }

  int totalMinor(int year, int month) {
    return forMonth(year, month).fold(0, (sum, item) => sum + item.amountMinor);
  }

  Map<String, int> totalsByCategory(int year, int month) {
    final totals = <String, int>{};
    for (final item in forMonth(year, month)) {
      totals[item.categoryId] = (totals[item.categoryId] ?? 0) + item.amountMinor;
    }
    return totals;
  }

  String exportJson() {
    return jsonEncode(_items.map(expenseToJson).toList());
  }

  void importJson(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! List) {
      throw const FormatException("Ledger export must be a list.");
    }
    replaceAll(decoded.map((item) => expenseFromJson(Map<String, Object?>.from(item as Map))).toList());
  }

  void _sort() {
    _items.sort((left, right) => right.spentOn.compareTo(left.spentOn));
  }
}
