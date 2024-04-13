import 'package:flutter/material.dart';
import 'package:mf_app/src/app/bloc/user_bloc.dart';
import 'package:mf_app/src/views/analyze_portfolio/ap_mobile_number/ap_mobile_view_model.dart';
import 'package:mf_app/src/views/analyze_portfolio/helper/ap_screen_bar.dart';
import 'package:provider/provider.dart';

class ApPhoneNumberArguments {
  final String phoneNumber;
  final bool isPhoneNumberUpdated;

  ApPhoneNumberArguments(
      {required this.phoneNumber, required this.isPhoneNumberUpdated});
}

class AnalyzePortfolioPhoneNumberView extends StatefulWidget {
  const AnalyzePortfolioPhoneNumberView({super.key});

  @override
  State<AnalyzePortfolioPhoneNumberView> createState() =>
      _AnalyzePortfolioPhoneNumberViewState();
}

class _AnalyzePortfolioPhoneNumberViewState
    extends State<AnalyzePortfolioPhoneNumberView> {
  late final TextEditingController _mobileNumberController;
  late final AnalyzePortfolioPhoneViewModel appnv;
  bool isphoneNumberUpdated = false;
  @override
  void initState() {
    super.initState();
    _mobileNumberController = TextEditingController();
    appnv = context.read<AnalyzePortfolioPhoneViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ValueListenableBuilder(
            valueListenable: appnv.apPhoneNotifier,
            builder: (_, apPhoneNumberState, __) {
              if (apPhoneNumberState is ApPhoneNumberInitial ||
                  apPhoneNumberState is ApPhoneNumberUpdated) {
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
                        border: Border.all(
                            width: 1, color: const Color(0xffEFF1F5)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Column(
                              children: [
                                Text(
                                  'Your Mobile Number !',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      fontFamily: 'Poppins'),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            'Mobile Number',
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
                            controller: _mobileNumberController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xffF7F8FA),
                                focusColor: Color(0xffF7F8FA),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: 'Enter Mobile Number',
                                hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xff7E838D))),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text.rich(TextSpan(children: [
                            TextSpan(
                                text: '6 Digit OTP  will be sent By ',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff5F6570))),
                            TextSpan(
                                text: 'MF Central ',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            TextSpan(
                                text: 'to your mobile Number',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff5F6570))),
                          ])),
                          const SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              appnv.updatePhoneNumber(
                                  _mobileNumberController.text,
                                  context.read<UserBloc>().user.value!);
                              // isphoneNumberUpdated = true;
                              // Navigator.of(context).pushReplacementNamed(
                              //     AppRoutes.analyzePortfolioOtp,
                              //     arguments: ApPhoneNumberArguments(
                              //         phoneNumber: _mobileNumberController.text,
                              //         isPhoneNumberUpdated:
                              //             isphoneNumberUpdated));
                            },
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 44, vertical: 14),
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
                                  'Generate OTP',
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
              }
              if (apPhoneNumberState is ApPhoneNumberError) {
                return Center(
                  child: Text(apPhoneNumberState.error),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
