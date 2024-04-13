import 'package:flutter/material.dart';
import 'package:mf_app/src/app/bloc/user_bloc.dart';
import 'package:mf_app/src/app/routes/routes.dart';
import 'package:mf_app/src/views/analyze_portfolio/ap_otp/ap_otp_view_model.dart';
import 'package:mf_app/src/views/analyze_portfolio/helper/ap_screen_bar.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class AnalyzePortfolioOtpView extends StatefulWidget {
  // final String updatedMobileNumber;
  // final bool isMobileNumberupdated;
  const AnalyzePortfolioOtpView({
    super.key,
  });

  @override
  State<AnalyzePortfolioOtpView> createState() =>
      _AnalyzePortfolioOtpViewState();
}

class _AnalyzePortfolioOtpViewState extends State<AnalyzePortfolioOtpView> {
  late final TextEditingController _phoneOtpController;
  late final AnalyzePortfoliOtpViewModel apovm;
  bool isPopupVisible = false;
  final bool isMobileNumberUpdated = false;

  @override
  void initState() {
    super.initState();
    _phoneOtpController = TextEditingController();
    apovm = context.read<AnalyzePortfoliOtpViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            border: Border.all(width: 1, color: const Color(0xffEFF1F5))));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ValueListenableBuilder(
            valueListenable: apovm.apOtpNotifier,
            builder: (_, apOtpState, __) {
              if (apOtpState is APOtpInitial || apOtpState is APOtpEntered) {
                return Column(
                  children: [
                    const ApScreenBar(),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      // padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(
                              width: 1,
                              color: Color(0xffEFF1F5),
                            ),
                            right:
                                BorderSide(width: 1, color: Color(0xffEFF1F5)),
                            left:
                                BorderSide(width: 1, color: Color(0xffEFF1F5)),
                            bottom:
                                BorderSide(width: 0, color: Color(0xffEFF1F5))),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'OTP Verification',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                fontFamily: 'Poppins'),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text.rich(
                              TextSpan(children: [
                                const TextSpan(
                                    text: 'Enter the OTP you received to  ',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff5F6570),
                                        fontSize: 14)),
                                TextSpan(
                                    text:
                                        "${Provider.of<UserBloc>(context).user.value!.mobileNo} ",
                                    style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 14)),
                                WidgetSpan(
                                    child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        AppRoutes.analyzePortfoliomobileNumber);
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    size: 17,
                                  ),
                                )),
                                const TextSpan(
                                    text: ' By MF central',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 14)),
                              ]),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Pinput(
                            defaultPinTheme: defaultPinTheme,
                            scrollPadding: EdgeInsets.zero,
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            // ],
                            length: 6,
                            obscureText: false,
                            closeKeyboardWhenCompleted: true,
                            controller: _phoneOtpController,
                            // onCompleted: (value) {
                            //   otpvm.verifyOtp(widget.phoneNumber,
                            //       phoneOTPController.text);
                            // },
                            errorText: 'Please enter a valid OTP',
                            validator: (String? checkPin) {
                              return checkPin!.length == 6
                                  ? null
                                  : 'Pin is incorrect';
                            },
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 55),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    'Resend OTP',
                                    style: TextStyle(
                                        color: Color(0xff3F4599),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 42,
                          ),
                          GestureDetector(
                            onTap: () {
                              apovm.verifyOtpAnanlyzePortfolio(
                                  context.read<UserBloc>().user.value!.mobileNo,
                                  _phoneOtpController.text);

                              isPopupVisible = true;

                              if (isPopupVisible) {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      var screenSize =
                                          MediaQuery.of(context).size;
                                      return Dialog(
                                        alignment: Alignment.center,
                                        backgroundColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Container(
                                          height: screenSize.height * 0.4,
                                          width: screenSize.width * 0.7,
                                          child: Image.asset(
                                              'assets/images/png/scanner.png'),
                                        ),
                                      );
                                    });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 36, vertical: 14),
                              decoration: BoxDecoration(
                                  color: const Color(0xff3F4599),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0, 8),
                                        blurRadius: 15,
                                        color: const Color(0xffE3E5EB)
                                            .withOpacity(0.5))
                                  ],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7))),
                              child: const Text(
                                'OTP Verification',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 39, vertical: 16),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: Color(0xffEFF1F5))),
                        color: Color(0xffF7F8FA),
                      ),
                      child: const Text(
                        "We'll collect your data from MF Central to ensure your portfolio stays current and up to date.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff5F6570),
                        ),
                      ),
                    )
                  ],
                );
              }
              if (apOtpState is APOtpError) {
                return Center(
                  child: Text(apOtpState.error),
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
