import 'package:flutter/material.dart';
import 'package:mf_app/src/app/bloc/user_bloc.dart';
import 'package:mf_app/src/app/repository/analyze_your_portfolio/mf_central_repo.dart';
import 'package:mf_app/src/app/repository/auth_repo/login_repository.dart';
import 'package:mf_app/src/app/repository/funds_repository/funds_repository.dart';
import 'package:mf_app/src/app/repository/goal_management/goal_management_repo.dart';
import 'package:mf_app/src/app/routes/routes.dart';
import 'package:mf_app/src/views/Login/otp/otp_view_model.dart';
import 'package:mf_app/src/views/Login/pan_view/pan_view.dart';
import 'package:mf_app/src/views/Login/pan_view/pan_view_model.dart';
import 'package:mf_app/src/views/Login/phone_number/phone_number_view.dart';
import 'package:mf_app/src/views/Login/phone_number/phone_number_view_model.dart';
import 'package:mf_app/src/views/Login/otp/otp_view.dart';
import 'package:mf_app/src/views/all_funds/detail_screen/detail_view_model.dart';
import 'package:mf_app/src/views/all_funds/detail_screen/details_view.dart';
import 'package:mf_app/src/views/all_funds/discover_all_funds/discover_all_funds_view.dart';
import 'package:mf_app/src/views/all_funds/discover_all_funds/discover_all_funds_view_model.dart';
import 'package:mf_app/src/views/analyze_portfolio/ap_mobile_number/ap_mobile_view.dart';
import 'package:mf_app/src/views/analyze_portfolio/ap_mobile_number/ap_mobile_view_model.dart';
import 'package:mf_app/src/views/analyze_portfolio/ap_otp/ap_otp_view.dart';
import 'package:mf_app/src/views/analyze_portfolio/ap_otp/ap_otp_view_model.dart';
import 'package:mf_app/src/views/analyze_portfolio/ap_pan/ap_pan_view.dart';
import 'package:mf_app/src/views/analyze_portfolio/ap_pan/ap_pan_view_model.dart';
import 'package:mf_app/src/views/analyze_portfolio/portfolio_performance/portfolio_performance_view.dart';
import 'package:mf_app/src/views/analyze_portfolio/portfolio_performance/portfolio_performance_view_model.dart';
import 'package:mf_app/src/views/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:mf_app/src/views/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:mf_app/src/views/bottom_nav_bar/search/search_view.dart';
import 'package:mf_app/src/views/bottom_nav_bar/search/search_view_model.dart';
import 'package:mf_app/src/views/explore/explore_view.dart';
import 'package:mf_app/src/views/explore/explore_view_model.dart';
import 'package:mf_app/src/views/goal_management/goal_Calculator/goal_calculator.dart';
import 'package:mf_app/src/views/goal_management/goal_Calculator/goal_calculator_view_model.dart';
import 'package:mf_app/src/views/goal_management/goal_Calculator/goal_plan_view.dart';
import 'package:mf_app/src/views/goal_management/goal_Calculator/goal_plan_view_model.dart';
import 'package:mf_app/src/views/goal_management/goal_management_view.dart';
import 'package:mf_app/src/views/goal_management/helper/goal_management_conatiner.dart';
import 'package:mf_app/src/views/return_calculator/return_calculator_view.dart';
import 'package:mf_app/src/views/splash/splash_view.dart';
import 'package:mf_app/src/views/splash/splash_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final FundsRepository repository;
  late final LoginRepository loginRepository;
  late final MfCentralRepository mfCentralRepository;
  late final GoalManagementRepository gmRepo;

  @override
  void initState() {
    super.initState();
    repository = FundsRepository();
    loginRepository = LoginRepository();
    mfCentralRepository = MfCentralRepository();
    gmRepo = GoalManagementRepository();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserBloc>(create: (_) => UserBloc()),
        Provider<BottomNavBarViewModel>(create: (_) => BottomNavBarViewModel()),
        Provider<ExploreViewModel>(
            create: (_) => ExploreViewModel(
                  exploreRepository: repository,
                  mfCentralRepository: mfCentralRepository,
                )),
        Provider<AllFundsViewModel>(
            create: (_) => AllFundsViewModel(fundRepo: repository)),
        Provider<DetailsViewModel>(
            create: (_) => DetailsViewModel(detailsRepo: repository)),
        Provider<GoalCalculatorViewModel>(
            create: (_) => GoalCalculatorViewModel()),
        Provider<SplashViewModel>(
            create: (_) => SplashViewModel(loginRepository: loginRepository)),
        Provider<PhoneNumberViewModel>(
            create: (_) =>
                PhoneNumberViewModel(phoneNumberRepo: loginRepository)),
        Provider<OTPViewModel>(
            create: (_) => OTPViewModel(otpRepo: loginRepository)),
        Provider(create: (_) => PanViewModel(loginRepository: loginRepository)),
        Provider(
            create: (_) =>
                AnalyzePortfolioPanViewModel(loginRepository: loginRepository)),
        Provider<AnalyzePortfoliOtpViewModel>(
            create: (_) => AnalyzePortfoliOtpViewModel(
                mfCentralRepository: mfCentralRepository)),
        Provider<AnalyzePortfolioPhoneViewModel>(
            create: (_) => AnalyzePortfolioPhoneViewModel(
                mfCentralRepository: mfCentralRepository)),
        Provider<PortfolioPerformanceViewModel>(
            create: (_) => PortfolioPerformanceViewModel(
                mfCentralRepository: mfCentralRepository)),
        Provider<GoalPlanViewModel>(
            create: (_) => GoalPlanViewModel(goalManagementRepository: gmRepo)),
        Provider<SearchViewModel>(
            create: (_) => SearchViewModel(fundsRepository: repository)),
      ],
      child: MaterialApp(
        initialRoute: AppRoutes.splashScreen,
        onGenerateRoute: (settings) {
          if (settings.name == AppRoutes.loginScreen) {
            return MaterialPageRoute(builder: (context) {
              return const PhoneNumberView();
            });
          }

          if (settings.name == AppRoutes.otpScreen) {
            final args = settings.arguments as String;
            return MaterialPageRoute(builder: (context) {
              return OTPView(
                phoneNumber: args,
              );
            });
          }

          if (settings.name == AppRoutes.panScreen) {
            return MaterialPageRoute(builder: (context) {
              return const PanView();
            });
          }

          if (settings.name == AppRoutes.bottomNavBarHome) {
            return MaterialPageRoute(builder: (context) {
              return const BottomNavBarView();
            });
          }

          if (settings.name == AppRoutes.discoverAllFunds) {
            return MaterialPageRoute(builder: (context) {
              return const DiscoverAllFundsView();
            });
          }

          if (settings.name == AppRoutes.detailScreen) {
            final args = settings.arguments as ExploreScreenArguments;
            return MaterialPageRoute(builder: (context) {
              return AllFundsDetailView(
                schemeId: args.schemeId,
                duration: args.duration,
              );
            });
          }

          if (settings.name == AppRoutes.goalManagement) {
            return MaterialPageRoute(builder: (context) {
              return const GoalManagementView();
            });
          }

          if (settings.name == AppRoutes.goalCalculator) {
            final args = settings.arguments as GoalManagementScreenArguments;
            return MaterialPageRoute(builder: (context) {
              return GoalCalculator(
                goalName: args.goalName,
                img: args.img,
                about: args.about,
              );
            });
          }

          if (settings.name == AppRoutes.goalPlan) {
            final args = settings.arguments as GoalCalculatorScreenArguments;
            return MaterialPageRoute(builder: (context) {
              return GoalPlanView(
                goalName: args.goalName,
                img: args.img,
                monthlyInvestmentRequired: args.monthlyInvestmentRequired,
                inflationAdjustedAmount: args.inflationAdjustedValue,
                projectedSavings: args.projectedSavings,
                years: args.years,
              );
            });
          }

          if (settings.name == AppRoutes.analyzePortfolioPanScreen) {
            return MaterialPageRoute(builder: (context) {
              return const AnalyzePortfolioPanView();
            });
          }

          if (settings.name == AppRoutes.analyzePortfoliomobileNumber) {
            return MaterialPageRoute(builder: (context) {
              return const AnalyzePortfolioPhoneNumberView();
            });
          }

          if (settings.name == AppRoutes.analyzePortfolioOtp) {
            // final args = settings.arguments as ApPhoneNumberArguments;
            return MaterialPageRoute(builder: (context) {
              return const AnalyzePortfolioOtpView(
                  // updatedMobileNumber: args.phoneNumber,
                  // isMobileNumberupdated: args.isPhoneNumberUpdated,
                  );
            });
          }

          if (settings.name == AppRoutes.portfolioPerformance) {
            return MaterialPageRoute(builder: (context) {
              return const PortfolioPerformanceView();
            });
          }

          if (settings.name == AppRoutes.returnCalculator) {
            return MaterialPageRoute(builder: (context) {
              return const ReturnCalculatorView();
            });
          }

          if (settings.name == AppRoutes.searchScreen) {
            return MaterialPageRoute(builder: (context) {
              return const SearchScreen();
            });
          }

          return MaterialPageRoute(builder: (context) {
            return const SplashView();
          });
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
      ),
    );
  }
}
