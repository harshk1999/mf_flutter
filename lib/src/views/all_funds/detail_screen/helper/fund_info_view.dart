import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mf_app/src/views/all_funds/detail_screen/detail_view_model.dart';
import 'package:mf_app/src/views/all_funds/detail_screen/helper/about_fund_manager_container.dart';
import 'package:provider/provider.dart';

class FundInfoView extends StatefulWidget {
  const FundInfoView({super.key});

  @override
  State<FundInfoView> createState() => _FundInfoViewState();
}

class _FundInfoViewState extends State<FundInfoView> {
  late final DetailsViewModel dvm;
  @override
  void initState() {
    super.initState();
    dvm = context.read<DetailsViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: dvm.detailsNotifier,
        builder: (_, fundInfoState, __) {
          if (fundInfoState is DetailsLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    "About ${fundInfoState.singleFundDetails.details.name}",
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff161719),
                      height: 30 / 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    fundInfoState.fundInfo.about,
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff5f646f),
                        height: 2),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  const Text(
                    "About Fund Managers",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff161719),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: fundInfoState.fundInfo.managerInfo.length,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (_, index) {
                      final fundInfo =
                          fundInfoState.fundInfo.managerInfo[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 16),
                        child: AboutFundManagerConatiners(
                            fundManagerName: fundInfo.name,
                            imgUrl: fundInfo.iconUrl),
                      );
                    },
                    separatorBuilder: (_, int index) {
                      return const Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 10),
                          child: Divider(
                            thickness: 1,
                            color: Color(0xffDDE0E7),
                          ));
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Divider(
                    color: Color(0xffDDE0E7),
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "FAQs",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff161719),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      SvgPicture.asset('assets/images/svg/faq.svg'),
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),

                  // Column(
                  //   children: List.generate(
                  //       fundInfoState.fundQuestions.faqs.length, (index) {
                  //     final faq = fundInfoState.fundQuestions.faqs[index];
                  //     return Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 4, vertical: 12),
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             '0${(index + 1)}'.toString(),
                  //             style: const TextStyle(
                  //               fontFamily: "Poppins",
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w700,
                  //               color: Color(0xff161719),
                  //             ),
                  //             textAlign: TextAlign.left,
                  //           ),
                  //           const SizedBox(
                  //             width: 8,
                  //           ),
                  //           Expanded(
                  //             child: Text(
                  //               faq.question,
                  //               maxLines: 1,
                  //               style: const TextStyle(
                  //                 fontFamily: "Poppins",
                  //                 fontSize: 14,
                  //                 fontWeight: FontWeight.w500,
                  //                 color: Color(0xff161719),
                  //               ),
                  //             ),
                  //           ),
                  //           const Spacer(),
                  //           const Icon(
                  //             Icons.add,
                  //             size: 32,
                  //           )
                  //         ],
                  //       ),
                  //     );
                  //   }),
                  // )
                  Expanded(
                    child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        // shrinkWrap: true,
                        itemBuilder: (_, index) {
                          final faq = fundInfoState.fundQuestions.faqs[index];
                          print(fundInfoState.fundQuestions.faqs.length);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '0${(index + 1)}'.toString(),
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff161719),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Text(
                                    faq.question,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff161719),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.add,
                                  size: 32,
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (_, __) {
                          return const Divider(
                            thickness: 1,
                            color: Color(0xffDDE0E7),
                          );
                        },
                        itemCount: fundInfoState.fundQuestions.faqs.length),
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
