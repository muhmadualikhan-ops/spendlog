import "package:flutter/material.dart";

import "../models/categories.dart";
import "../models/money.dart";

class CategoryBreakdown extends StatelessWidget {
  const CategoryBreakdown({required this.totals, required this.total, super.key});

  final Map<String, int> totals;
  final int total;

  @override
  Widget build(BuildContext context) {
    final rows = spendCategories.where((category) => (totals[category.id] ?? 0) > 0).toList();
    if (rows.isEmpty) {
      return const Text("No spending in this month yet.");
    }
    return Column(
      children: [
        for (final category in rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _CategoryBar(
              label: category.label,
              color: category.color,
              amount: totals[category.id] ?? 0,
              share: total == 0 ? 0 : (totals[category.id] ?? 0) / total,
            ),
          ),
      ],
    );
  }
}

class _CategoryBar extends StatelessWidget {
  const _CategoryBar({
    required this.label,
    required this.color,
    required this.amount,
    required this.share,
  });

  final String label;
  final Color color;
  final int amount;
  final double share;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(label)),
            Text(Money(amount).format()),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: share.clamp(0, 1),
            minHeight: 8,
            backgroundColor: color.withValues(alpha: 0.12),
            color: color,
          ),
        ),
      ],
    );
  }
}
