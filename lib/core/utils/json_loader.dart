import 'dart:convert';

import 'package:flutter/services.dart';

import '../error/exceptions.dart';

class JsonLoader {
  static Future<List<Map<String, dynamic>>> loadQuestions() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/questions.json',
      );
      final List<dynamic> data = json.decode(response);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      throw DataException('Error loading questions: ${e.toString()}');
    }
  }
}
