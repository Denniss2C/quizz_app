import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_quiz_history.dart';
import 'ranking_event.dart';
import 'ranking_state.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  final GetQuizHistory getQuizHistory;

  RankingBloc({required this.getQuizHistory}) : super(RankingInitial()) {
    on<LoadRankingEvent>(_onLoadRanking);
  }

  Future<void> _onLoadRanking(
    LoadRankingEvent event,
    Emitter<RankingState> emit,
  ) async {
    emit(RankingLoading());

    final result = await getQuizHistory();

    result.fold((failure) => emit(RankingError(failure.message)), (results) {
      if (results.isEmpty) {
        emit(RankingEmpty());
      } else {
        emit(RankingLoaded(results));
      }
    });
  }
}
