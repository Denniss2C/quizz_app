import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routes/app_routes.dart';
import '../../../injection_container.dart';
import '../../bloc/ranking_bloc/ranking_bloc.dart';
import '../../bloc/ranking_bloc/ranking_event.dart';
import '../../bloc/ranking_bloc/ranking_state.dart';
import 'widgets/ranking_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RankingBloc>()..add(LoadRankingEvent()),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppDimensions.paddingXXL),
                _buildHeader(),
                const SizedBox(height: AppDimensions.paddingXXL),
                _buildStartButton(context),
                const SizedBox(height: AppDimensions.paddingL),
                _buildHistorySection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: AppColors.primaryGradient),
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          ),
          child: const Icon(
            Icons.quiz,
            size: AppDimensions.iconXXL,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingL),
        const Text(
          AppStrings.homeTitle,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.paddingS),
        Text(
          AppStrings.homeSubtitle,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, AppRoutes.quiz),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingL),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.play_arrow, size: AppDimensions.iconL),
          SizedBox(width: AppDimensions.paddingS),
          Text(
            AppStrings.startQuiz,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.viewRanking,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          Expanded(
            child: BlocBuilder<RankingBloc, RankingState>(
              builder: (context, state) {
                if (state is RankingLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is RankingEmpty) {
                  return _buildEmptyState();
                }

                if (state is RankingError) {
                  return Center(child: Text(state.message));
                }

                if (state is RankingLoaded) {
                  return ListView.builder(
                    itemCount: state.results.length,
                    itemBuilder: (context, index) {
                      return RankingCard(
                        result: state.results[index],
                        index: index,
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.emoji_events_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: AppDimensions.paddingM),
          Text(
            AppStrings.noHistory,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          Text(
            AppStrings.playFirstQuiz,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
