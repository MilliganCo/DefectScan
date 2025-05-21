// lib/features/history/domain/history_status.dart
import 'package:flutter/material.dart';

enum HistoryStatus {
  sent   (Icons.check_circle,  Colors.green),
  removed(Icons.delete,        Colors.redAccent);

  const HistoryStatus(this.icon, this.color);
  final IconData icon;
  final Color    color;
}
