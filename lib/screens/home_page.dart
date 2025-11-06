import "package:flutter/material.dart";

import "../state/ledger_scope.dart";
import "../models/money.dart";
import "../screens/editor_page.dart";
import "../screens/history_page.dart";
import "../screens/settings_page.dart";
import "../widgets/category_breakdown.dart";
import "../widgets/expense_tile.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _months = <String>[
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  @override
  Widget build(BuildContext context) {
    final ledger = LedgerScope.of(context);
    final monthLabel = "${_months[ledger.month.month - 1]} ${ledger.month.year}";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spendlog"),
        actions: [
          IconButton(
            tooltip: "History",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const HistoryPage()));
            },
            icon: const Icon(Icons.calendar_month_outlined),
          ),
          IconButton(
            tooltip: "Settings",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const SettingsPage()));
            },
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const EditorPage()));
        },
        icon: const Icon(Icons.add),
        label: const Text("Add expense"),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        children: [
          Row(
            children: [
              IconButton(tooltip: "Previous month", onPressed: ledger.previousMonth, icon: const Icon(Icons.chevron_left)),
              Expanded(
                child: Text(monthLabel, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium),
              ),
              IconButton(tooltip: "Next month", onPressed: ledger.nextMonth, icon: const Icon(Icons.chevron_right)),
            ],
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Spent this month", style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 8),
                  Text(Money(ledger.monthTotal).format(), style: Theme.of(context).textTheme.displaySmall),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: CategoryBreakdown(totals: ledger.categoryTotals, total: ledger.monthTotal),
            ),
          ),
          const SizedBox(height: 16),
          Text("Recent", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          if (ledger.monthItems.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text("Nothing logged for this month. Add an expense, or load the example month from Settings."),
              ),
            )
          else
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  for (final expense in ledger.monthItems.take(8))
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
      ),
    );
  }
}
