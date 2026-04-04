import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StyledRadialBar extends StatefulWidget {
  final double percentage;
  final String label;
  final Color fillColor;
  final Color progressColor;
  final double size;

  const StyledRadialBar({
    super.key,
    required this.percentage,
    required this.label,
    this.fillColor = const Color(0xFF43A047), // لون الدائرة
    this.progressColor = const Color(0xFF2E7D32), // لون الخط الخارجي
    this.size = 130,
  });

  @override
  State<StyledRadialBar> createState() => _StyledRadialBarState();
}

class _StyledRadialBarState extends State<StyledRadialBar> {
  late List<_ChartData> chartData;

  @override
  void initState() {
    super.initState();
    chartData = widget.percentage >= 100
        ? [
      _ChartData('progress', 100, widget.progressColor),
    ]
        : [
      _ChartData('progress', widget.percentage, widget.progressColor),
      _ChartData('empty', 100 - widget.percentage, Colors.transparent),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // الخلفية الدائرية
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.fillColor,
            ),
          ),
          // الرسم البياني للراديال بار
          SfCircularChart(
            margin: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            series: <DoughnutSeries<_ChartData, String>>[
              DoughnutSeries<_ChartData, String>(
                dataSource: chartData,
                xValueMapper: (_ChartData data, _) => data.label,
                yValueMapper: (_ChartData data, _) => data.value,
                pointColorMapper: (_ChartData data, _) => data.color,
                innerRadius: '95%',
                radius: '110%',
                startAngle: 0,
                endAngle: 360,
                dataLabelSettings: const DataLabelSettings(isVisible: false),
                animationDuration: 1000,
              ),
            ],
          ),
          // النص داخل الدائرة
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: widget.percentage),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Text(
                      '${value.toInt()}%',
                      style: TextStyle(
                        fontSize: widget.size * 0.15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  },
                ),

                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: widget.size * 0.1,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
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
