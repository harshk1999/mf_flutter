import 'package:flutter/foundation.dart';
import 'package:mf_app/src/app/repository/analyze_your_portfolio/mf_central_repo.dart';
import 'package:mf_app/src/app/repository/models/mf_central/portfolio_analysis_model.dart';

abstract class PortfolioPerformanceState {}

class PortfolioPerformanceInitial implements PortfolioPerformanceState {}

class PortfolioPerformanceLoading implements PortfolioPerformanceState {}

class PortfolioPerformanceError implements PortfolioPerformanceState {
  final String error;

  PortfolioPerformanceError({required this.error});
}

class PortfolioPerformanceLoaded implements PortfolioPerformanceState {
  final PortfolioMfCentral portfolioMfCentral;

  PortfolioPerformanceLoaded({required this.portfolioMfCentral});
}

class PortfolioPerformanceViewModel {
  final MfCentralRepository mfCentralRepository;

  PortfolioPerformanceViewModel({required this.mfCentralRepository});

  final ValueNotifier<PortfolioPerformanceState> _portfolioPerformanceNotifier =
      ValueNotifier<PortfolioPerformanceState>(PortfolioPerformanceInitial());

  ValueListenable<PortfolioPerformanceState> get portfolioPerformanceNotifier =>
      _portfolioPerformanceNotifier;

  Future<void> getportfolioAnalysis(String mobileNumber) async {
    _portfolioPerformanceNotifier.value = PortfolioPerformanceLoading();
    try {
      final portfolioMfCentral =
          await mfCentralRepository.fetchPortfolioData(mobileNumber);
      _portfolioPerformanceNotifier.value =
          PortfolioPerformanceLoaded(portfolioMfCentral: portfolioMfCentral);
    } catch (e) {
      _portfolioPerformanceNotifier.value =
          PortfolioPerformanceError(error: e.toString());
      rethrow;
    }
  }
}
