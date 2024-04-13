import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mf_app/src/app/routes/routes.dart';
import 'package:mf_app/src/views/Login/phone_number/phone_number_view_model.dart';
import 'package:provider/provider.dart';

class PhoneNumberView extends StatefulWidget {
  const PhoneNumberView({super.key});

  @override
  State<PhoneNumberView> createState() => _PhoneNumberViewState();
}

class _PhoneNumberViewState extends State<PhoneNumberView> {
  late final TextEditingController _textEditingController;
  late final PhoneNumberViewModel pvm;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    pvm = context.read<PhoneNumberViewModel>();

    pvm.phoneNumberNotifier.addListener(() {
      if (pvm.phoneNumberNotifier.value is PhoneNumberEntered) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.otpScreen,
            arguments: _textEditingController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/login_image.svg',

                    // width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.06,
                    left: 74,
                    right: 60,
                    child: const Text(
                      'Start your investing journey today.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                          fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
            ValueListenableBuilder(
                valueListenable: pvm.phoneNumberFieldNotifier,
                builder: (_, phoneNumberFieldState, __) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        const Center(
                          child: Text(
                            'Welcome to SMC',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          'Mobile Number',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextField(
                          controller: _textEditingController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              errorText: phoneNumberFieldState.phoneNumber,
                              filled: true,
                              fillColor: const Color(0xffF7F8FA),
                              focusColor: const Color(0xffF7F8FA),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: 'Enter Mobile Number',
                              hintStyle: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xff7E838D))),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text.rich(TextSpan(children: [
                          TextSpan(
                              text: '6 Digit OTP ',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                          TextSpan(
                              text:
                                  'will be sent via SMS to verity your mobile number !',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff5F6570)))
                        ])),
                        const SizedBox(
                          height: 82,
                        ),
                      ],
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        String phoneNumber = _textEditingController.text;

                        if (phoneNumber.isNotEmpty &&
                            phoneNumber.length == 10) {
                          pvm.enterPhoneNumber(phoneNumber);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 88, vertical: 15),
                        decoration: BoxDecoration(
                            color: const Color(0xff3F4599),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 8),
                                  blurRadius: 15,
                                  color:
                                      const Color(0xffE3E5EB).withOpacity(0.5)),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(7))),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text.rich(TextSpan(children: [
                      TextSpan(
                          text: 'By Proceeding, I agree to ',
                          style: TextStyle(
                            color: Color(0xff7E838D),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          )),
                      TextSpan(
                          text: 'T&C , Privacy Policy & Tariff Rates',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ))
                    ]))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
