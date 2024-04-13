import 'package:flutter/material.dart';

class ListWidgetForFilters extends StatefulWidget {
  final List filters;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;
  final String filterName;
  const ListWidgetForFilters(
      {super.key,
      required this.filters,
      required this.isChecked,
      required this.onChanged,
      required this.filterName});

  @override
  State<ListWidgetForFilters> createState() => _ListWidgetForFiltersState();
}

class _ListWidgetForFiltersState extends State<ListWidgetForFilters> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: widget.filters.length,
          padding: const EdgeInsets.only(left: 20),
          itemBuilder: (_, int index) {
            return Row(
              children: [
                Checkbox(value: widget.isChecked, onChanged: widget.onChanged),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  widget.filterName,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                )
              ],
            );
          }),
    );
  }
}
