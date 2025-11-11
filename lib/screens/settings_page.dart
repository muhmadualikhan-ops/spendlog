import "package:flutter/material.dart";

import "../state/ledger_scope.dart";

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: const [
          _CurrencyTile(),
          _SampleTile(),
          _ClearTile(),
        ],
      ),
    );
  }
}

class _CurrencyTile extends StatelessWidget {
  const _CurrencyTile();

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: Icon(Icons.payments_outlined),
      title: Text("Currency"),
      subtitle: Text("Pakistani rupees. Amounts are stored in paisa."),
    );
  }
}

class _SampleTile extends StatelessWidget {
  const _SampleTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.auto_stories_outlined),
      title: const Text("Load example month"),
      subtitle: const Text("Replaces the current ledger with the sample expenses."),
      onTap: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Load examples?"),
              content: const Text("This replaces whatever is currently on the ledger."),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
                FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text("Load")),
              ],
            );
          },
        );
        if (confirmed == true && context.mounted) {
          LedgerScope.of(context).loadSamples();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Example expenses loaded.")));
        }
      },
    );
  }
}

class _ClearTile extends StatelessWidget {
  const _ClearTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.delete_sweep_outlined),
      title: const Text("Clear this month"),
      subtitle: const Text("Removes expenses in the month you are viewing."),
      onTap: () {
        LedgerScope.of(context).clearMonth();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("This month was cleared.")));
      },
    );
  }
}
