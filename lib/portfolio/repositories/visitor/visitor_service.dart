import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// A singleton service that fetches and holds the live visitor count
class VisitorService {
  VisitorService._();
  static final VisitorService _instance = VisitorService._();
  static VisitorService get instance => _instance;

  /// Holds the current visitor count. `null` means still loading
  final ValueNotifier<int?> count = ValueNotifier<int?>(null);

  bool _hasFetched = false;

  /// Calls the counter API to increment and fetch the current count
  /// Safe to call multiple times – only the first invocation hits the network
  Future<void> fetchAndIncrement() async {
    if (_hasFetched) return;
    _hasFetched = true;

    try {
      final response = await http
          .get(
            Uri.parse('https://api.counterapi.dev/v1/ismailmagdy/portfolio/up'),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw Exception('Bad status code: ${response.statusCode}');
      }

      final data = jsonDecode(response.body);
      count.value = (data['count'] as int?) ?? 0;
    } catch (e) {
      debugPrint('Counter API Error: $e');
      // Fallback to 0 so the spinner stops and the badge still renders
      count.value = 0;
    }
  }
}
