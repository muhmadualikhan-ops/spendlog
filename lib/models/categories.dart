import "package:flutter/material.dart";

class SpendCategory {
  const SpendCategory({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String id;
  final String label;
  final IconData icon;
  final Color color;
}

const spendCategories = <SpendCategory>[
  SpendCategory(id: "groceries", label: "Groceries", icon: Icons.local_grocery_store_outlined, color: Color(0xFF2E7D32)),
  SpendCategory(id: "food", label: "Food", icon: Icons.restaurant_outlined, color: Color(0xFFEF6C00)),
  SpendCategory(id: "transport", label: "Transport", icon: Icons.directions_car_outlined, color: Color(0xFF1565C0)),
  SpendCategory(id: "bills", label: "Bills", icon: Icons.receipt_long_outlined, color: Color(0xFF6A1B9A)),
  SpendCategory(id: "health", label: "Health", icon: Icons.medical_services_outlined, color: Color(0xFFC62828)),
  SpendCategory(id: "shopping", label: "Shopping", icon: Icons.shopping_bag_outlined, color: Color(0xFF00838F)),
  SpendCategory(id: "rent", label: "Rent", icon: Icons.home_outlined, color: Color(0xFF455A64)),
  SpendCategory(id: "education", label: "Education", icon: Icons.menu_book_outlined, color: Color(0xFF3949AB)),
  SpendCategory(id: "other", label: "Other", icon: Icons.more_horiz, color: Color(0xFF546E7A)),
];

SpendCategory categoryById(String id) {
  return spendCategories.firstWhere(
    (category) => category.id == id,
    orElse: () => spendCategories.last,
  );
}
