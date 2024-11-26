import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartsVisual extends StatelessWidget {
  final List<Map<String, dynamic>> users;
  final List<String> subjects;
  const ChartsVisual({super.key, required this.users, required this.subjects});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int totalPass = 0;
    int totalFail = 0;

    for (var entry in users) {
      if (entry["Result"].contains("PASS")) {
        totalPass++;
      } else if (entry["Result"].contains("Fail")) {
        totalFail++;
      }
    }
    int total = totalPass + totalFail;
    List<BarChartGroupData> getBarGroups() {
      return subjects.asMap().entries.map((entry) {
        int index = entry.key;
        String subject = entry.value;

        // Count how many students failed in this particular subject
        int failCount = users.where((user) {
          String grade = user[subject];

          return grade == 'F';
        }).length;

        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: failCount.toDouble(), // Fail count for the subject
              color: Theme.of(context).colorScheme.tertiary,
              width: (screenWidth < 600)
                  ? (screenWidth < 350)
                      ? 10
                      : 20
                  : 30,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(5.0), bottom: Radius.zero),
            ),
          ],
        );
      }).toList();
    }

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.start,
      runSpacing: 50,
      spacing: (screenWidth < 600) ? 0 : 100,
      children: [
        // Pie chart
        Column(
          children: [
            Text(
              "Result in Percentage",
              style: (screenWidth < 600)
                  ? Theme.of(context).textTheme.headlineSmall
                  : Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: (screenWidth < 600) ? 15 : 20,
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: (screenWidth < 600) ? 300 : 400,
                minWidth: (screenWidth < 600) ? 200 : 300,
                minHeight: (screenWidth < 600)
                    ? (screenWidth < 350)
                        ? 150
                        : 200
                    : 200,
                maxHeight: (screenWidth < 600)
                    ? (screenWidth < 350)
                        ? 250
                        : 300
                    : 300,
              ),
              child: PieChart(
                PieChartData(
                  sectionsSpace: 5,
                  centerSpaceRadius: (screenWidth < 600)
                      ? (screenWidth < 350)
                          ? 50
                          : 60
                      : 70,
                  sections: [
                    PieChartSectionData(
                      title:
                          "${(totalFail / total * 100).toStringAsFixed(2)} %\nFail",
                      showTitle: true,
                      titleStyle: Theme.of(context).textTheme.titleSmall,
                      color: Theme.of(context).colorScheme.tertiary,
                      value: totalFail.toDouble(),
                      radius: (screenWidth < 600)
                          ? (screenWidth < 350)
                              ? 60
                              : 70
                          : 80,
                    ),
                    PieChartSectionData(
                      title:
                          "${(totalPass / total * 100).toStringAsFixed(2)} %\nPass",
                      showTitle: true,
                      titleStyle: Theme.of(context).textTheme.titleSmall,
                      color: Theme.of(context).colorScheme.primary,
                      value: totalPass.toDouble(),
                      radius: (screenWidth < 600)
                          ? (screenWidth < 350)
                              ? 70
                              : 80
                          : 90,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Subject bar
        Column(
          children: [
            Text(
              "Subject Wise Fail",
              style: (screenWidth < 600)
                  ? Theme.of(context).textTheme.headlineSmall
                  : Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: (screenWidth < 600)
                    ? (screenWidth < 350)
                        ? 300
                        : 500
                    : 800,
                minWidth: (screenWidth < 600)
                    ? (screenWidth < 350)
                        ? 200
                        : 300
                    : 400,
                minHeight: (screenWidth < 600)
                    ? (screenWidth < 350)
                        ? 150
                        : 200
                    : 200,
                maxHeight: (screenWidth < 600)
                    ? (screenWidth < 350)
                        ? 250
                        : 300
                    : 300,
              ),
              child: BarChart(
                BarChartData(
                  barGroups: getBarGroups(),
                  maxY: users.length.toDouble(),
                  minY: 0,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          rod.toY.toString(), // Show the quantity (fail count)
                          TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary, // Set font color for the tooltip text
                            fontWeight: FontWeight.bold,
                            fontSize: (screenWidth < 600)
                                ? (screenWidth < 350)
                                    ? 12
                                    : 14
                                : 14,
                          ),
                        );
                      },
                    ),
                    enabled: true,
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        maxIncluded: true,
                        showTitles: true,
                        minIncluded: false,
                        getTitlesWidget: (value, meta) {
                          var style = TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Hind",
                            fontSize: (screenWidth < 600) ? 14 : 16,
                          );
                          return Text(
                            value.toString(), // Display the subject name
                            style: style,
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          var style = TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Hind",
                            fontSize: (screenWidth < 600) ? 12 : 14,
                          );

                          // Convert the value (x-axis index) to the subject name dynamically
                          if (value.toInt() >= 0 &&
                              value.toInt() < subjects.length) {
                            // Use the subject name based on the index
                            return Padding(
                              padding: (screenWidth < 600)
                                  ? (screenWidth < 350)
                                      ? const EdgeInsets.only(left: 23, top: 10)
                                      : const EdgeInsets.only(left: 25, top: 10)
                                  : const EdgeInsets.only(right: 35, top: 10),
                              child: Transform.rotate(
                                angle: (screenWidth < 600)
                                    ? (screenWidth < 350)
                                        ? -1.57
                                        : -1.57
                                    : -0.5, // Adjust the angle as per your needs (in radians)
                                child: Text(
                                  subjects[value
                                      .toInt()], // Display the subject name
                                  style: style,
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    border: Border(
                      left: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 3,
                      ),
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
