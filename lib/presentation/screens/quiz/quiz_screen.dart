import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routes/app_routes.dart';
import '../../../injection_container.dart';
import '../../bloc/quiz_bloc/quiz_bloc.dart';
import '../../bloc/quiz_bloc/quiz_event.dart';
import '../../bloc/quiz_bloc/quiz_state.dart';
import '../../bloc/timer_bloc/timer_bloc.dart';
import '../../bloc/timer_bloc/timer_event.dart';
import '../../bloc/timer_bloc/timer_state.dart';
import 'widgets/answer_option.dart';
import 'widgets/progress_indicator_widget.dart';
import 'widgets/question_card.dart';
import 'widgets/timer_widget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int totalElapsedSeconds = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<QuizBloc>()..add(LoadQuestionsEvent())),
        BlocProvider(
          create: (_) => sl<TimerBloc>()
            ..add(
              const TimerStarted(duration: AppDimensions.questionTimeInSeconds),
            ),
        ),
      ],
      child: BlocListener<TimerBloc, TimerState>(
        listener: (context, timerState) {
          if (timerState is TimerRunComplete) {
            context.read<QuizBloc>().add(TimeUpEvent());
          }
        },
        child: BlocConsumer<QuizBloc, QuizState>(
          listener: (context, state) {
            if (state is QuizFinished) {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.result,
                arguments: {
                  'score': state.score,
                  'totalQuestions': state.totalQuestions,
                  'correctAnswers': state.correctAnswers,
                  'totalTime': state.totalTimeInSeconds,
                },
              );
            }
          },
          builder: (context, state) {
            if (state is QuizLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (state is QuizError) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: AppDimensions.paddingL),
                      Text(state.message),
                      const SizedBox(height: AppDimensions.paddingL),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(AppStrings.backToHome),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is QuizLoaded) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Quiz Challenge'),
                  actions: [
                    BlocBuilder<TimerBloc, TimerState>(
                      builder: (context, timerState) {
                        return TimerWidget(seconds: timerState.duration);
                      },
                    ),
                    const SizedBox(width: AppDimensions.paddingM),
                  ],
                ),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        QuizProgressIndicator(
                          current: state.currentQuestionIndex + 1,
                          total: state.totalQuestions,
                        ),
                        const SizedBox(height: AppDimensions.paddingL),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                QuestionCard(
                                  question: state.currentQuestion.question,
                                ),
                                const SizedBox(height: AppDimensions.paddingL),
                                ...List.generate(
                                  state.currentQuestion.options.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: AppDimensions.paddingM,
                                    ),
                                    child: AnswerOption(
                                      text:
                                          state.currentQuestion.options[index],
                                      isSelected: state.selectedAnswer == index,
                                      isCorrect:
                                          state.isAnswered &&
                                          state.currentQuestion.correctAnswer ==
                                              index,
                                      isWrong:
                                          state.isAnswered &&
                                          state.selectedAnswer == index &&
                                          state.currentQuestion.correctAnswer !=
                                              index,
                                      isDisabled: state.isAnswered,
                                      onTap: () {
                                        if (!state.isAnswered) {
                                          context.read<TimerBloc>().add(
                                            TimerPaused(),
                                          );
                                          context.read<QuizBloc>().add(
                                            AnswerSelectedEvent(index),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: AppDimensions.paddingL),
                        _buildNextButton(context, state),
                      ],
                    ),
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context, QuizLoaded state) {
    final isLastQuestion = state.isLastQuestion;
    final isAnswered = state.isAnswered;

    return ElevatedButton(
      onPressed: isAnswered
          ? () {
              if (isLastQuestion) {
                final timerState = context.read<TimerBloc>().state;
                final questionTime =
                    AppDimensions.questionTimeInSeconds - timerState.duration;
                totalElapsedSeconds += questionTime;

                context.read<QuizBloc>().add(
                  FinishQuizEvent(totalElapsedSeconds),
                );
              } else {
                final timerState = context.read<TimerBloc>().state;
                final questionTime =
                    AppDimensions.questionTimeInSeconds - timerState.duration;
                totalElapsedSeconds += questionTime;

                context.read<QuizBloc>().add(NextQuestionEvent());
                context.read<TimerBloc>().add(
                  const TimerReset(
                    duration: AppDimensions.questionTimeInSeconds,
                  ),
                );
                context.read<TimerBloc>().add(
                  const TimerStarted(
                    duration: AppDimensions.questionTimeInSeconds,
                  ),
                );
              }
            }
          : null,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingL),
      ),
      child: Text(
        isLastQuestion ? AppStrings.finish : AppStrings.nextQuestion,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
