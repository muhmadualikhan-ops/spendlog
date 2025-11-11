import "package:flutter/material.dart";

import "../state/ledger_scope.dart";
import "../models/expense.dart";
import "../screens/editor_page.dart";
import "../widgets/expense_tile.dart";

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = LedgerScope.of(context).store.items;
    final groups = <String, List<Expense>>{};
    for (final item in items) {
      final key = "${item.spentOn.year}-${item.spentOn.month.toString().padLeft(2, "0")}-${item.spentOn.day.toString().padLeft(2, "0")}";
      groups.putIfAbsent(key, () => <Expense>[]).add(item);
    }
    final keys = groups.keys.toList()..sort((left, right) => right.compareTo(left));
    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body: keys.isEmpty
          ? const Center(child: Text("Your history will show up here."))
          : ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                for (final key in keys) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                    child: Text(key, style: Theme.of(context).textTheme.labelLarge),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        for (final expense in groups[key]!)
                          ExpenseTile(
                            expense: expense,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(builder: (_) => EditorPage(existing: expense)),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}
