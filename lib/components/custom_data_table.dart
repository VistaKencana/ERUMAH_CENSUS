import 'package:flutter/material.dart';

class DataTableWidget extends StatelessWidget {
  final List<String> columns;
  final int rowLength;
  final DataRow Function(int index) rowGenerator;
  const DataTableWidget(
      {super.key,
      required this.columns,
      required this.rowGenerator,
      required this.rowLength});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowColor: WidgetStateColor.resolveWith((states) => Colors.blue),
      columns: List.generate(
        columns.length,
        (index) => DataColumn(
          label: Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              columns[index],
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      rows: List.generate(rowLength, (index) => rowGenerator(index)),
    );
  }

  static DataRow dataRow(
          {required String bil,
          required String unit,
          required String bilstatus,
          void Function()? onPressed}) =>
      DataRow(
        cells: [
          DataCell(Text(bil)),
          DataCell(Text(unit)),
          DataCell(Text(bilstatus)),
          DataCell(
            Visibility(
              visible: onPressed != null,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: onPressed,
                child: const Text("Banci"),
              ),
            ),
          ),
        ],
      );
}
