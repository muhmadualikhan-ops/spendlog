import "package:flutter/material.dart";

import "screens/home_page.dart";
import "state/ledger_controller.dart";
import "state/ledger_scope.dart";
import "theme/app_theme.dart";

class SpendlogApp extends StatelessWidget {
  const SpendlogApp({required this.controller, super.key});

  final LedgerController controller;

  @override
  Widget build(BuildContext context) {
    return LedgerScope(
      controller: controller,
      child: MaterialApp(
        title: "Spendlog",
        debugShowCheckedModeBanner: false,
        theme: buildSpendlogTheme(),
        home: const HomePage(),
      ),
    );
  }
}
