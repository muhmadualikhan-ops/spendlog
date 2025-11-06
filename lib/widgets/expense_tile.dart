import "package:flutter/material.dart";

import "../models/categories.dart";
import "../models/expense.dart";
import "../models/money.dart";

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({required this.expense, required this.onTap, super.key});

  final Expense expense;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final category = categoryById(expense.categoryId);
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: category.color.withValues(alpha: 0.14),
        foregroundColor: category.color,
        child: Icon(category.icon),
      ),
      title: Text(expense.title),
      subtitle: Text(expense.note.isEmpty ? category.label : "${category.label} · ${expense.note}"),
      trailing: Text(
        Money(expense.amountMinor).format(),
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
