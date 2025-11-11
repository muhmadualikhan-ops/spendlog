import "package:flutter/material.dart";

import "../state/ledger_scope.dart";
import "../models/categories.dart";
import "../models/expense.dart";
import "../models/money.dart";

class EditorPage extends StatefulWidget {
  const EditorPage({this.existing, super.key});

  final Expense? existing;

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  late final TextEditingController _title;
  late final TextEditingController _amount;
  late final TextEditingController _note;
  late String _categoryId;
  late DateTime _spentOn;
  String? _error;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _title = TextEditingController(text: existing?.title ?? "");
    _amount = TextEditingController(
      text: existing == null ? "" : Money(existing.amountMinor).format(symbol: "").trim(),
    );
    _note = TextEditingController(text: existing?.note ?? "");
    _categoryId = existing?.categoryId ?? spendCategories.first.id;
    _spentOn = existing?.spentOn ?? DateTime.now();
  }

  @override
  void dispose() {
    _title.dispose();
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _spentOn,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) setState(() => _spentOn = picked);
  }

  void _save() {
    final title = _title.text.trim();
    if (title.isEmpty) {
      setState(() => _error = "Add a short title.");
      return;
    }
    final Money money;
    try {
      money = Money.parse(_amount.text);
    } on FormatException catch (error) {
      setState(() => _error = error.message);
      return;
    }
    if (money.minor <= 0) {
      setState(() => _error = "Amount has to be more than zero.");
      return;
    }
    final expense = Expense(
      id: widget.existing?.id ?? "e${DateTime.now().microsecondsSinceEpoch}",
      title: title,
      categoryId: _categoryId,
      amountMinor: money.minor,
      spentOn: DateTime(_spentOn.year, _spentOn.month, _spentOn.day),
      note: _note.text.trim(),
    );
    LedgerScope.of(context).save(expense);
    Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    final existing = widget.existing;
    if (existing == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete this expense?"),
          content: Text(existing.title),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Keep")),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete")),
          ],
        );
      },
    );
    if (confirmed == true && mounted) {
      LedgerScope.of(context).delete(existing.id);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.existing != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? "Edit expense" : "Add expense"),
        actions: [
          if (editing) IconButton(tooltip: "Delete", onPressed: _delete, icon: const Icon(Icons.delete_outline)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _title,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: "Title", hintText: "Milk and bread"),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _amount,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: "Amount", prefixText: "Rs "),
          ),
          const SizedBox(height: 16),
          Text("Category", style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final category in spendCategories)
                ChoiceChip(
                  label: Text(category.label),
                  avatar: Icon(category.icon, size: 18),
                  selected: _categoryId == category.id,
                  onSelected: (_) => setState(() => _categoryId = category.id),
                ),
            ],
          ),
          const SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("Date"),
            subtitle: Text("${_spentOn.day} ${_monthName(_spentOn.month)} ${_spentOn.year}"),
            trailing: const Icon(Icons.event_outlined),
            onTap: _pickDate,
          ),
          TextField(
            controller: _note,
            decoration: const InputDecoration(labelText: "Note", hintText: "Optional"),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ],
          const SizedBox(height: 20),
          FilledButton(onPressed: _save, child: Text(editing ? "Save changes" : "Add expense")),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const names = <String>[
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
    return names[month - 1];
  }
}
