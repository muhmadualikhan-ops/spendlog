import "package:flutter_test/flutter_test.dart";
import "package:spendlog/data/ledger_store.dart";
import "package:spendlog/models/expense.dart";

void main() {
  Expense expense({
    String id = "e1",
    int amountMinor = 15000,
    String categoryId = "food",
    DateTime? spentOn,
  }) {
    return Expense(
      id: id,
      title: "Lunch",
      categoryId: categoryId,
      amountMinor: amountMinor,
      spentOn: spentOn ?? DateTime(2026, 3, 4),
      note: "Office",
    );
  }

  test("totals a month in minor units", () {
    final store = LedgerStore()
      ..add(expense())
      ..add(expense(id: "e2", amountMinor: 5000, spentOn: DateTime(2026, 3, 8)))
      ..add(expense(id: "e3", amountMinor: 9000, spentOn: DateTime(2026, 4, 1)));

    expect(store.totalMinor(2026, 3), 20000);
    expect(store.totalsByCategory(2026, 3)["food"], 20000);
  });

  test("round trips a ledger through json", () {
    final store = LedgerStore()..add(expense());
    final copy = LedgerStore()..importJson(store.exportJson());

    expect(copy.items.single.id, "e1");
    expect(copy.items.single.amountMinor, 15000);
    expect(copy.items.single.note, "Office");
  });

  test("updates and removes by id", () {
    final store = LedgerStore()..add(expense());
    store.update(expense(amountMinor: 18000));
    expect(store.find("e1")?.amountMinor, 18000);
    expect(store.remove("e1"), isTrue);
    expect(store.items, isEmpty);
  });
}
