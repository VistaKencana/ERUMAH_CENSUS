import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'model/dashboard_json_model.dart';

class DashboardDataView extends StatefulWidget {
  final DashboardModel data;
  final void Function()? onPressed;
  const DashboardDataView(
      {super.key, required this.data, required this.onPressed});

  @override
  State<DashboardDataView> createState() => _DashboardDataViewState();

  static Future show(BuildContext context,
      {required DashboardModel data, required void Function()? onPressed}) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(14))),
      isScrollControlled: true,
      builder: (_) => DashboardDataView(data: data, onPressed: onPressed),
    );
  }
}

class _DashboardDataViewState extends State<DashboardDataView> {
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: ModalRoute.of(context)!.animation!,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
      child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: .7,
          maxChildSize: .7,
          minChildSize: .6,
          builder: (context, sc) {
            return ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Form(
                child: Scaffold(
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 6),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.midGrey.color,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(18),
                          margin: const EdgeInsets.only(top: 4),
                          child: const Icon(Icons.location_on),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.data.housingProject?.desc ?? "-",
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(widget.data.unit?.unitNo ?? "-"),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.04),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Catatan",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(stringPlaceholder(
                                  (widget.data.visit?.isEmpty ?? true)
                                      ? ""
                                      : widget.data.visit?.first.remark)),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.04),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Status',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.data.status?.desc ?? "-",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Bancian Pertama',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              stringPlaceholder(
                                  (widget.data.visit?.isEmpty ?? true)
                                      ? ""
                                      : widget.data.visit?.first.date),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Bancian Terakhir',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              stringPlaceholder(
                                  (widget.data.visit?.isEmpty ?? true)
                                      ? ""
                                      : widget.data.visit?.last.date),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: Visibility(
                    visible: widget.onPressed != null,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (widget.onPressed != null) {
                                        widget.onPressed!();
                                      }
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: const Text("Banci"))),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  String stringPlaceholder(String? val) {
    return (val?.isEmpty ?? true) ? "-" : val!;
  }
}
