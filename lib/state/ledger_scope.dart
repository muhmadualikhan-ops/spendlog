import "package:flutter/material.dart";

import "ledger_controller.dart";

class LedgerScope extends InheritedNotifier<LedgerController> {
  const LedgerScope({required LedgerController controller, required super.child, super.key})
      : super(notifier: controller);

  static LedgerController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LedgerScope>();
    assert(scope != null, "LedgerScope is missing above this widget.");
    return scope!.notifier!;
  }
}
