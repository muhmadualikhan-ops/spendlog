import "package:flutter/material.dart";

import "app.dart";
import "state/ledger_controller.dart";
import "data/ledger_store.dart";

void main() {
  runApp(SpendlogApp(controller: LedgerController(LedgerStore())));
}
