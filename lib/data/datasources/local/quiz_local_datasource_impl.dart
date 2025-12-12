import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/utils/json_loader.dart';
import '../../models/question_model.dart';
import '../../models/quiz_result_model.dart';
import 'quiz_local_datasource.dart';

class QuizLocalDataSourceImpl implements QuizLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _historyKey = 'quiz_history';

  QuizLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<QuestionModel>> getQuestions() async {
    try {
      final jsonData = await JsonLoader.loadQuestions();
      return jsonData.map((json) => QuestionModel.fromJson(json)).toList();
    } catch (e) {
      throw DataException('Failed to load questions: ${e.toString()}');
    }
  }

  @override
  Future<void> saveQuizResult(QuizResultModel result) async {
    try {
      final history = await getQuizHistory();
      history.add(result);

      final jsonList = history.map((r) => r.toJson()).toList();
      final jsonString = json.encode(jsonList);

      await sharedPreferences.setString(_historyKey, jsonString);
    } catch (e) {
      throw CacheException('Failed to save quiz result: ${e.toString()}');
    }
  }

  @override
  Future<List<QuizResultModel>> getQuizHistory() async {
    try {
      final jsonString = sharedPreferences.getString(_historyKey);

      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => QuizResultModel.fromJson(json)).toList();
    } catch (e) {
      throw CacheException('Failed to load quiz history: ${e.toString()}');
    }
  }
}
