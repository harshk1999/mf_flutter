import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mf_app/src/app/bloc/user_bloc.dart';
import 'package:mf_app/src/app/routes/routes.dart';
import 'package:mf_app/src/views/Login/pan_view/pan_view_model.dart';
import 'package:provider/provider.dart';

class PanView extends StatefulWidget {
  const PanView({super.key});

  @override
  State<PanView> createState() => _PanViewState();
}

class _PanViewState extends State<PanView> {
  late final TextEditingController _panController;
  late final PanViewModel pvm;
  @override
  void initState() {
    super.initState();
    _panController = TextEditingController();
    pvm = context.read<PanViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder(
          valueListenable: pvm.panNotifier,
          builder: (_, panState, __) {
            if (panState is PanInitial || PanState is PanEntered) {
              return Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/images/svg/login_image.svg'),
                        const SizedBox(
                          height: 32,
                        ),
                        SvgPicture.asset('assets/images/svg/otp.svg'),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'PAN Card Detail',
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
                          'Enter 10 Digit Number from your PAN Card',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xff5F6570),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          controller: _panController,
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
                          height: 105,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      pvm.updatePanForMfCentral(_panController.text,
                          context.read<UserBloc>().user.value!.id);

                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.bottomNavBarHome);
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
                ],
              );
            }
            if (panState is PanError) {
              return Center(
                child: Text(panState.error),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
