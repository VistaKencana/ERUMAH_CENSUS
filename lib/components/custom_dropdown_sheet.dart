import 'package:flutter/material.dart';

class CustomDropdownSheet<T> extends StatefulWidget {
  final String label;
  final T? groupValue;
  final List<T> items;
  final String Function(T data) getTitle;
  final void Function(T? data) onChange;
  final double initialChildSize;
  final double maxChildSize;
  final double minChildSize;

  const CustomDropdownSheet({
    required this.label,
    required this.items,
    required this.getTitle,
    super.key,
    this.groupValue,
    required this.onChange,
    this.initialChildSize = 0.7,
    this.maxChildSize = 0.7,
    this.minChildSize = 0.3,
  });

  Future show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      isScrollControlled: true,
      builder: (_) => this,
    );
  }

  @override
  State<CustomDropdownSheet<T>> createState() => _CustomDropdownSheetState<T>();
}

class _CustomDropdownSheetState<T> extends State<CustomDropdownSheet<T>> {
  T? currValue;
  @override
  void initState() {
    super.initState();
    currValue = widget.groupValue;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: widget.initialChildSize,
        minChildSize: widget.minChildSize,
        maxChildSize: widget.maxChildSize,
        builder: (context, sc) {
          return ScaleTransition(
            scale: CurvedAnimation(
              parent: ModalRoute.of(context)!.animation!,
              curve: Curves.easeOut,
              reverseCurve: Curves.easeIn,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 28, bottom: 18),
                  child: Text(
                    widget.label,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                widget.items.isNotEmpty
                    ? Expanded(
                        child: Scrollbar(
                        thickness: 10,
                        radius: const Radius.circular(20),
                        child: ListView(
                          controller: sc,
                          children: List.generate(
                            widget.items.length,
                            (index) => RadioListTile<T>(
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                groupValue: widget.groupValue,
                                value: widget.items[index],
                                title:
                                    Text(widget.getTitle(widget.items[index])),
                                onChanged: (val) {
                                  widget.onChange(val);
                                  Navigator.pop(context);
                                }),
                          ),
                        ),
                      ))
                    : Expanded(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.18),
                          Center(
                              child: Icon(
                            Icons.description_outlined,
                            color: Colors.grey,
                            size: MediaQuery.sizeOf(context).width * 0.15,
                          )),
                          const Center(
                              child: Text(
                            "There is no data to show",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          )),
                        ],
                      ))
              ],
            ),
          );
        });
  }
}
