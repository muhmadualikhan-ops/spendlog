import "package:flutter/foundation.dart";

import "../data/ledger_store.dart";
import "../data/sample_expenses.dart";
import "../models/expense.dart";

class LedgerController extends ChangeNotifier {
  LedgerController(this.store) : month = DateTime(DateTime.now().year, DateTime.now().month);

  final LedgerStore store;
  DateTime month;

  List<Expense> get monthItems => store.forMonth(month.year, month.month);

  int get monthTotal => store.totalMinor(month.year, month.month);

  Map<String, int> get categoryTotals => store.totalsByCategory(month.year, month.month);

  void showMonth(DateTime next) {
    month = DateTime(next.year, next.month);
    notifyListeners();
  }

  void previousMonth() {
    showMonth(DateTime(month.year, month.month - 1));
  }

  void nextMonth() {
    showMonth(DateTime(month.year, month.month + 1));
  }

  void save(Expense expense) {
    if (store.find(expense.id) == null) {
      store.add(expense);
    } else {
      store.update(expense);
    }
    month = DateTime(expense.spentOn.year, expense.spentOn.month);
    notifyListeners();
  }

  void delete(String id) {
    store.remove(id);
    notifyListeners();
  }

  void loadSamples() {
    store.replaceAll(<Expense>[
      for (var index = 0; index < sampleExpenses.length; index += 1) sampleExpenses[index].toExpense(index),
    ]);
    if (store.items.isNotEmpty) {
      final latest = store.items.first.spentOn;
      month = DateTime(latest.year, latest.month);
    }
    notifyListeners();
  }

  void clearMonth() {
    final ids = monthItems.map((item) => item.id).toList();
    for (final id in ids) {
      store.remove(id);
    }
    notifyListeners();
  }
}
