import 'package:flutter/material.dart';

class PerformanceFundListContainer extends StatelessWidget {
  final String index;
  final String fundName;
  final String fundReturn;
  final bool selected;
  const PerformanceFundListContainer(
      {super.key,
      required this.index,
      this.selected = false,
      required this.fundName,
      required this.fundReturn});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: selected ? const Color(0xff19BC8A).withOpacity(0.2) : null,
        border: Border.all(width: 1, color: const Color(0xffDDE0E7)),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              '0$index',
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: selected
                    ? const Color(0xff27AA6B)
                    : const Color(0xff161719),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              fundName,
              maxLines: 1,
              style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff161719)),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          Text(
            fundReturn,
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff161719),
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}
