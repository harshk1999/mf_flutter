import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mf_app/src/app/bloc/user_bloc.dart';
import 'package:mf_app/src/app/routes/routes.dart';
import 'package:mf_app/src/views/Login/otp/otp_view_model.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPView extends StatefulWidget {
  final String phoneNumber;
  const OTPView({super.key, required this.phoneNumber});
  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  late TextEditingController phoneOTPController;
  late OTPViewModel otpvm;
  @override
  void initState() {
    super.initState();
    phoneOTPController = TextEditingController();
    otpvm = context.read<OTPViewModel>();

    otpvm.otpNotifier.addListener(() {
      final state = otpvm.otpNotifier.value;
      if (state is LoggedIn) {
        context.read<UserBloc>().setUser = state.user;
        if (state.user.pan.isEmpty) {
          Navigator.pushReplacementNamed(context, AppRoutes.panScreen);
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.bottomNavBarHome);
        }
      }
    });
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
      body: ValueListenableBuilder(
          valueListenable: otpvm.otpNotifier,
          builder: (_, otpState, __) {
            if (otpState is OtpError) {
              return Center(
                child: Text(otpState.error),
              );
            }
            if (otpState is EnterOtp) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/svg/login_image.svg',
                      ),
                      const Positioned(
                        top: 110,
                        left: 74,
                        right: 60,
                        child: Text(
                          'Start your investing journey today.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Center(
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/images/svg/otp.svg'),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'OTP Verification',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'We have sent OTP on your register mobile number',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xff5F6570),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        // SizedBox(
                        //   height: 40,
                        //   child: OtpTextField(
                        //     numberOfFields: 6,
                        //     showFieldAsBox: true,
                        //     borderWidth: 1,
                        //     borderColor: const Color(0xffEFF1F5),
                        //     fieldWidth: 40,
                        //     enabledBorderColor: const Color(0xffEFF1F5),
                        //     focusedBorderColor: const Color(0xffEFF1F5),
                        //     cursorColor: Colors.black,
                        //   ),
                        // ),

                        Pinput(
                          keyboardType: TextInputType.emailAddress,
                          defaultPinTheme: defaultPinTheme,
                          scrollPadding: EdgeInsets.zero,
                          length: 6,
                          obscureText: false,
                          closeKeyboardWhenCompleted: true,
                          controller: phoneOTPController,
                          errorText: 'Please enter a valid OTP',
                          validator: (String? checkPin) {
                            return checkPin!.length == 6
                                ? null
                                : 'Pin is incorrect';
                          },
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 75),
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
                          height: 80,
                        ),

                        GestureDetector(
                          onTap: () {
                            otpvm.verifyOtp(
                                widget.phoneNumber, phoneOTPController.text);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 96, vertical: 15),
                            decoration: BoxDecoration(
                                color: const Color(0xff3F4599),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 8),
                                      blurRadius: 15,
                                      color: const Color(0xffE3E5EB)
                                          .withOpacity(0.5))
                                ],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(7))),
                            child: const Text(
                              'Verify',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
