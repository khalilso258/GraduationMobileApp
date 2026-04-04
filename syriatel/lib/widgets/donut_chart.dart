import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syriatel/theme/colors.dart';

class DonutChart extends StatefulWidget {
  final double value1;
  final double value2;
  final double value3;

  DonutChart({
    required this.value1,
    required this.value2,
    required this.value3,
  });

  @override
  _DonutChartState createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  late List<_ChartData> chartData;

  @override
  void initState() {
    super.initState();
    chartData = [
      _ChartData('v1', widget.value1, AppColors.thirdColor),
      _ChartData('v2', widget.value2, const Color(0xFFEE2200).withOpacity(0.5)),
      _ChartData('v3', widget.value3, const Color(0xFFEE2200).withOpacity(0.3)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 124,
      height: 124,
      child: SfCircularChart(
        series: <DoughnutSeries<_ChartData, String>>[
          DoughnutSeries<_ChartData, String>(
            dataSource: chartData,
            xValueMapper: (_ChartData data, _) => data.label,
            yValueMapper: (_ChartData data, _) => data.value,
            pointColorMapper: (_ChartData data, _) => data.color,
            innerRadius: '65%',
            radius: '140%',
            startAngle: 0,
            endAngle: 360,
            dataLabelSettings: const DataLabelSettings(isVisible: false),
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  final String label;
  final double value;
  final Color color;

  _ChartData(this.label, this.value, this.color);
}
