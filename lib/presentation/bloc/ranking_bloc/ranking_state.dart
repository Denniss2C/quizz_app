import 'package:equatable/equatable.dart';

import '../../../domain/entities/quiz_result.dart';

abstract class RankingState extends Equatable {
  const RankingState();

  @override
  List<Object> get props => [];
}

class RankingInitial extends RankingState {}

class RankingLoading extends RankingState {}

class RankingLoaded extends RankingState {
  final List<QuizResult> results;

  const RankingLoaded(this.results);

  @override
  List<Object> get props => [results];
}

class RankingEmpty extends RankingState {}

class RankingError extends RankingState {
  final String message;

  const RankingError(this.message);

  @override
  List<Object> get props => [message];
}
