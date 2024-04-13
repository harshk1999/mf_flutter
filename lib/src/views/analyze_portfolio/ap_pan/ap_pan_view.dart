import 'package:flutter/material.dart';
import 'package:mf_app/src/app/bloc/user_bloc.dart';
import 'package:mf_app/src/app/routes/routes.dart';
import 'package:mf_app/src/views/analyze_portfolio/ap_pan/ap_pan_view_model.dart';
import 'package:mf_app/src/views/analyze_portfolio/helper/ap_screen_bar.dart';
import 'package:provider/provider.dart';

class AnalyzePortfolioPanView extends StatefulWidget {
  const AnalyzePortfolioPanView({super.key});

  @override
  State<AnalyzePortfolioPanView> createState() =>
      _AnalyzePortfolioPanViewState();
}

class _AnalyzePortfolioPanViewState extends State<AnalyzePortfolioPanView> {
  late final TextEditingController _apPanController;
  late final AnalyzePortfolioPanViewModel appvm;
  @override
  void initState() {
    super.initState();
    _apPanController = TextEditingController();
    appvm = context.read<AnalyzePortfolioPanViewModel>();
    appvm.apPanNotifier.addListener(() {
      if (context.read<UserBloc>().user.value!.pan.isNotEmpty) {
        Navigator.of(context)
            .pushReplacementNamed(AppRoutes.analyzePortfolioOtp);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ValueListenableBuilder(
            valueListenable: appvm.apPanNotifier,
            builder: (_, apPanState, __) {
              if (apPanState is APPanError) {
                return Center(
                  child: Text(apPanState.error),
                );
              }
              if (apPanState is APPanLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  const ApScreenBar(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 361,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(width: 1, color: const Color(0xffEFF1F5)),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              const Text(
                                'Your PAN Number!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    fontFamily: 'Poppins'),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Image.asset('assets/images/png/PAN.png'),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                  'Enter 10 Digit Number from your PAN Card',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff5F6570),
                                      fontSize: 12))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          'PAN',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextField(
                          controller: _apPanController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF7F8FA),
                              focusColor: Color(0xffF7F8FA),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: 'Enter PAN Number',
                              hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xff7E838D))),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            appvm.updatePanForMfCentral(_apPanController.text,
                                context.read<UserBloc>().user.value!.id);
                          },
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 66, vertical: 14),
                              decoration: BoxDecoration(
                                  color: const Color(0xff3F4599),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0, 8),
                                        blurRadius: 15,
                                        color: const Color(0xffE3E5EB)
                                            .withOpacity(0.5)),
                                  ],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7))),
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
