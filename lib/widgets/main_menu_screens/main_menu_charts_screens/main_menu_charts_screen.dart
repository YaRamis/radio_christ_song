import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:radio_christ_song/widgets/main_menu_screens/main_menu_radio_screen/main_menu_radio_screen.dart';
import 'package:redux/redux.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../domain/entities/radio_chart/radio_chart.dart';
import '../../../redux/app_middlewares.dart';
import '../../../redux/app_state.dart';
import '../../../theme/app_colors.dart';
import 'main_menu_cart_tab/main_menu_chart_tab.dart';

class _MainMenuChartTabParameters {
  final List<RadioChartTrack> radioChartBestTracks;
  final List<RadioChartTrack> radioChartWorstTracks;

  _MainMenuChartTabParameters({
    required this.radioChartBestTracks,
    required this.radioChartWorstTracks,
  });
}

class MainMenuChartsScreenWidget extends StatefulWidget {
  const MainMenuChartsScreenWidget({super.key});

  @override
  State<MainMenuChartsScreenWidget> createState() =>
      _MainMenuChartsScreenWidgetState();
}

class _MainMenuChartsScreenWidgetState extends State<MainMenuChartsScreenWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    StoreProvider.of<AppState>(context).dispatch(fetchAllRadioChartTracks());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: const Text('Чарт'),
            backgroundColor: Colors.transparent,
            bottom: TabBar(
              unselectedLabelColor: Colors.white.withOpacity(0.5),
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              dividerColor: Colors.transparent,
              indicator: MaterialIndicator(
                height: 3,
                color: Colors.white,
                bottomLeftRadius: 2,
                bottomRightRadius: 2,
                topLeftRadius: 2,
                topRightRadius: 2,
              ),
              tabs: const [
                Tab(text: 'Лучшие треки'),
                Tab(text: 'Худшие треки'),
              ],
              // isScrollable: true,
            ),
          ),
          backgroundColor: Colors.transparent,
          body: StoreConnector(
            converter: (Store<AppState> store) => _MainMenuChartTabParameters(
                radioChartBestTracks: store.state.radioChartBestTracks,
                radioChartWorstTracks: store.state.radioChartWorstTracks),
            builder: (BuildContext context, tabParameters) => TabBarView(
              children: [
                MainMenuChartTabWidget(
                  radioChartTracks: tabParameters.radioChartBestTracks,
                ),
                MainMenuChartTabWidget(
                  radioChartTracks: tabParameters.radioChartWorstTracks,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
