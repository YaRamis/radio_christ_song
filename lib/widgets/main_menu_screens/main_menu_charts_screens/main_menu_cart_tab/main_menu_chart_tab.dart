import 'package:flutter/material.dart';
import '../../../../domain/entities/radio_chart/radio_chart.dart';
import '../../../../theme/app_colors.dart';

part 'main_menu_chart_tab_card.dart';

class MainMenuChartTabWidget extends StatelessWidget {
  final List<RadioChartTrack> radioChartTracks;

  const MainMenuChartTabWidget({super.key, required this.radioChartTracks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: radioChartTracks.length < 99 ? radioChartTracks.length : 99,
        itemBuilder: (BuildContext context, int index) {
          return MainMenuChartTabCardWidget(
            index: index,
            chartTrack: MainMenuChartTrack(radioChartTracks[index]),
          );
        });
  }
}
