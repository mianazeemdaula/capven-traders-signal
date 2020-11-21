import 'package:flutter/material.dart';

class Helper {
  static Color getForexColor(String conitdion) {
    conitdion = conitdion.trim().toUpperCase();
    if (conitdion == 'BUY')
      return Colors.green;
    else if (conitdion == 'SELL') return Colors.red;
    return Colors.orange;
  }

  static IconData getForexIcon(String conitdion) {
    conitdion = conitdion.trim().toUpperCase();
    if (conitdion == 'BUY')
      return Icons.arrow_upward;
    else if (conitdion == 'SELL') return Icons.arrow_downward;
    return Icons.date_range;
  }

  static Color getIndicesColor(String conitdion) {
    conitdion = conitdion.trim().toUpperCase();
    if (conitdion == 'BUY')
      return Colors.green;
    else if (conitdion == 'SELL') return Colors.red;
    return Colors.orange;
  }

  static IconData getIndicesIcon(String conitdion) {
    conitdion = conitdion.trim().toUpperCase();
    if (conitdion == 'BUY')
      return Icons.arrow_upward;
    else if (conitdion == 'SELL') return Icons.arrow_downward;
    return Icons.date_range;
  }

  static Color getOptionColor(String conitdion) {
    conitdion = conitdion.trim().toUpperCase();
    if (conitdion == 'CALL')
      return Colors.green;
    else if (conitdion == 'PUT') return Colors.red;
    return Colors.orange;
  }

  static IconData getOptionIcon(String conitdion) {
    conitdion = conitdion.trim().toUpperCase();
    if (conitdion == 'CALL')
      return Icons.arrow_upward;
    else if (conitdion == 'PUT') return Icons.arrow_downward;
    return Icons.date_range;
  }
}
