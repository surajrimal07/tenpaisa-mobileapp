import 'package:flutter/material.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final List<Color> chartColors = [
  Colors.orange,
  Colors.purple,
  Colors.green,
  Colors.amber,
  Colors.red,
  Colors.blue,
  Colors.teal,
  Colors.deepOrange,
  Colors.indigo,
  Colors.pink,
  Colors.cyan,
  Colors.deepPurple,
  Colors.lime,
  Colors.brown,
];

class CommonPortfolioCard extends StatelessWidget {
  final String title;
  final Map<String, double> dataMap;
  final bool isDarkMode;

  const CommonPortfolioCard(
      {super.key,
      required this.title,
      required this.dataMap,
      required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Sizes.dynamicHeight(37),
              child: SfCircularChart(
                margin: const EdgeInsets.all(0),
                title: ChartTitle(text: title),
                tooltipBehavior: TooltipBehavior(
                  color: Colors.grey[700],
                  enable: true,
                  format: 'point.x\n${title.split(' ').last}: point.y',
                ),
                series: <CircularSeries>[
                  PieSeries<MapEntry<String, double>, String>(
                    dataSource: dataMap.entries.toList(),
                    xValueMapper: (MapEntry<String, double> data, _) =>
                        data.key,
                    yValueMapper: (MapEntry<String, double> data, _) =>
                        data.value * 100,
                    dataLabelMapper: (MapEntry<String, double> data, _) =>
                        '${data.key}\n${(data.value * 100).toStringAsFixed(2)}%',
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside,
                      showZeroValue: false,
                      showCumulativeValues: true,
                      textStyle: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ), //if error remove pointcolormapper
                    pointColorMapper: (MapEntry<String, double> data, _) =>
                        chartColors[
                            dataMap.keys.toList().indexOf(data.key) % 14],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
