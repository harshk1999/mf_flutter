class PortfolioAnalysisMfCentral {
  final PortfolioMfCentral data;

  PortfolioAnalysisMfCentral({
    required this.data,
  });

  factory PortfolioAnalysisMfCentral.fromJson(Map<String, dynamic> json) =>
      PortfolioAnalysisMfCentral(
        data: PortfolioMfCentral.fromJson(json["data"]),
      );
}

class PortfolioMfCentral {
  final String fromDate;
  final String toDate;
  final double lastYrXirr;
  final double portfolioXirr;
  final double portfolioReturnAmt;
  final double portfolioReturn;
  final double oneDayReturn;
  final double currentInvestedValue;
  final double currentMarketValue;
  final Analysis analysis;
  final List<FundsDetail> fundsDetail;

  PortfolioMfCentral({
    required this.fromDate,
    required this.toDate,
    required this.lastYrXirr,
    required this.portfolioXirr,
    required this.portfolioReturnAmt,
    required this.portfolioReturn,
    required this.oneDayReturn,
    required this.currentInvestedValue,
    required this.currentMarketValue,
    required this.analysis,
    required this.fundsDetail,
  });

  factory PortfolioMfCentral.fromJson(Map<String, dynamic> json) =>
      PortfolioMfCentral(
        fromDate: json["from_date"],
        toDate: json["to_date"],
        lastYrXirr: json["last_yr_xirr"]?.toDouble(),
        portfolioXirr: json["portfolio_xirr"]?.toDouble(),
        portfolioReturnAmt: json["portfolio_return_amt"]?.toDouble(),
        portfolioReturn: json["portfolio_return"]?.toDouble(),
        oneDayReturn: json["one_day_return"],
        currentInvestedValue: json["current_invested_value"]?.toDouble(),
        currentMarketValue: json["current_market_value"]?.toDouble(),
        analysis: Analysis.fromJson(json["analysis"]),
        fundsDetail: List<FundsDetail>.from(
            json["funds_detail"].map((x) => FundsDetail.fromJson(x))),
      );
}

class Analysis {
  final List<CategoryAnalysisElement> categoryAnalysis;
  final List<CategoryAnalysisElement> sectorAnalysis;
  final List<CategoryAnalysisElement> companyAnalysis;

  Analysis({
    required this.categoryAnalysis,
    required this.sectorAnalysis,
    required this.companyAnalysis,
  });

  factory Analysis.fromJson(Map<String, dynamic> json) => Analysis(
        categoryAnalysis: List<CategoryAnalysisElement>.from(
            json["category_analysis"]
                .map((x) => CategoryAnalysisElement.fromJson(x))),
        sectorAnalysis: List<CategoryAnalysisElement>.from(
            json["sector_analysis"]
                .map((x) => CategoryAnalysisElement.fromJson(x))),
        companyAnalysis: List<CategoryAnalysisElement>.from(
            json["company_analysis"]
                .map((x) => CategoryAnalysisElement.fromJson(x))),
      );
}

class CategoryAnalysisElement {
  final String name;
  final double value;

  CategoryAnalysisElement({
    required this.name,
    required this.value,
  });

  factory CategoryAnalysisElement.fromJson(Map<String, dynamic> json) =>
      CategoryAnalysisElement(
        name: json["name"],
        value: json["value"]?.toDouble(),
      );
}

class FundsDetail {
  final int schemeId;
  final String schemeCode;
  final String name;
  final String iconUrl;
  final double fundReturn;
  final double returnAmount;
  final double fundMarketValue;
  final double fundInvestedValue;
  final String benchmark;
  final String benchmarkReturn;
  final String xirr;
  final String isin;
  final double currentNav;
  final double units;

  FundsDetail({
    required this.schemeId,
    required this.schemeCode,
    required this.name,
    required this.iconUrl,
    required this.fundReturn,
    required this.returnAmount,
    required this.fundMarketValue,
    required this.fundInvestedValue,
    required this.benchmark,
    required this.benchmarkReturn,
    required this.xirr,
    required this.isin,
    required this.currentNav,
    required this.units,
  });

  factory FundsDetail.fromJson(Map<String, dynamic> json) => FundsDetail(
        schemeId: json["scheme_id"],
        schemeCode: json["scheme_code"],
        name: json["name"],
        iconUrl: json["icon_url"],
        fundReturn: json["fund_return"]?.toDouble(),
        returnAmount: json["return_amount"]?.toDouble(),
        fundMarketValue: json["fund_market_value"]?.toDouble(),
        fundInvestedValue: json["fund_invested_value"]?.toDouble(),
        benchmark: json["benchmark"],
        benchmarkReturn: json["benchmark_return"],
        xirr: json["xirr"],
        isin: json["isin"],
        currentNav: json["current_nav"]?.toDouble(),
        units: json["units"]?.toDouble(),
      );
}
