import 'package:flutter/material.dart';
import 'package:semanalysis/Config/color.dart';

class StudentListTable extends StatelessWidget {
  final List<Map<String, dynamic>> users;
  final List<String> columnHeaders;

  const StudentListTable(
      {super.key, required this.users, required this.columnHeaders});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final ScrollController horizontalController = ScrollController();
    return Container(
      padding: const EdgeInsets.all(2.5),
      constraints: BoxConstraints(
        maxHeight: (screenWidth < 600) ? 400 : 350,
        maxWidth: (screenWidth < 600) ? 550 : 1200,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular((screenWidth < 600) ? 17.5 : 22.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular((screenWidth < 600) ? 15 : 20),
        child: Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Scrollbar(
              controller: horizontalController,
              child: SingleChildScrollView(
                controller: horizontalController,
                scrollDirection: Axis.horizontal,
                // Main Data table
                child: DataTable(
                  showBottomBorder: false,
                  headingTextStyle: Theme.of(context).textTheme.titleMedium,
                  headingRowColor: const WidgetStatePropertyAll(primary),
                  headingRowHeight: 50,
                  dataRowColor: const WidgetStatePropertyAll(white),
                  dataRowMaxHeight: 40,
                  dataRowMinHeight: 30,
                  dataTextStyle: Theme.of(context).textTheme.labelMedium,
                  border: TableBorder(
                    verticalInside: BorderSide(
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    horizontalInside: BorderSide(
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  columns: columnHeaders
                      .map((header) => DataColumn(label: Text(header)))
                      .toList(),
                  rows: users.map((row) {
                    return DataRow(
                      cells: columnHeaders.map((column) {
                        return DataCell(Text(row[column].toString()));
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
