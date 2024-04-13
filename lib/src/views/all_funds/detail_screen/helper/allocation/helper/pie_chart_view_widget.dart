import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartViewWidget extends StatefulWidget {
  final List<PieChartSectionData> pieChartSectionDataList;
  final List allocationList;
  final List<Color> colorsList;
  final String name;
  final double percentage;
  final String allocationName;
  const PieChartViewWidget(
      {super.key,
      required this.pieChartSectionDataList,
      required this.allocationList,
      required this.colorsList,
      required this.name,
      required this.percentage,
      required this.allocationName});

  @override
  State<PieChartViewWidget> createState() => _PieChartViewWidgetState();
}

class _PieChartViewWidgetState extends State<PieChartViewWidget> {
  final bool isClubSector = false;
  @override
  Widget build(BuildContext context) {
    // widget.pieChartSectionDataList = List.generate(6, (index)  {

    // })
    return Column(
      children: [
        SizedBox(
            height: 190,
            child: PieChart(
                PieChartData(sections: widget.pieChartSectionDataList))),
        const SizedBox(
          height: 24,
        ),
        Column(
          children: List.generate(widget.allocationList.length, (index) {
            return Row(
              children: [
                Container(
                  height: 20,
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(2.5)),
                    color: widget.colorsList[index % widget.colorsList.length],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  widget.name,
                  style: const TextStyle(
                      color: Color(0xff7E838D),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                const Spacer(),
                Text(
                  '${widget.percentage.toStringAsFixed(2)} %',
                  style: const TextStyle(
                      color: Color(0xff161719),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            );
          }),
        )
      ],
    );
  }
}
