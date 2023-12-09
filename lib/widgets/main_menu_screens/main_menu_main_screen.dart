import 'package:animations/animations.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:radio_christ_song/widgets/main_menu_screens/main_menu_news_screen/main_menu_news_screen.dart';
import 'package:radio_christ_song/widgets/main_menu_screens/main_menu_order_screen/main_menu_order_screen.dart';
import 'package:radio_christ_song/widgets/main_menu_screens/main_menu_radio_screen/main_menu_radio_screen.dart';
import '../app.dart';
import 'main_menu_charts_screens/main_menu_charts_screen.dart';
import 'main_menu_feedback_screen/main_menu_feedback_screen.dart';

class MainMenuMainScreenWidget extends StatefulWidget {
  const MainMenuMainScreenWidget({super.key});

  @override
  State<MainMenuMainScreenWidget> createState() =>
      _MainMenuMainScreenWidgetState();
}

class _MainMenuMainScreenWidgetState extends State<MainMenuMainScreenWidget> {
  final _mainScreens = [
    {
      'widget': const MainMenuRadioScreenWidget(),
      'title': 'Плеер',
      'icon': const Icon(Icons.headphones_rounded),
    },
    {
      'widget': const MainMenuChartsScreenWidget(),
      'title': 'Чарт',
      'icon': const Icon(Icons.bar_chart_rounded),
    },
    {
      'widget': const MainMenuOrderScreenWidget(),
      'title': 'Стол заказов',
      'icon': const Icon(Icons.queue_music_rounded),
    },
    {
      'widget': const MainMenuNewsScreenWidget(),
      'title': 'Новости',
      'icon': const Icon(Icons.newspaper_rounded),
    },
    {
      'widget': const MainMenuFeedbackScreenWidget(),
      'title': 'Обратная связь',
      'icon': const Icon(Icons.feedback_rounded),
    },
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    isTimerActive.addListener(() {
      if (!isTimerActive.value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Таймер завершился.'),
        ));
      }
    });
    radioScreenBackgroundColor.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: radioScreenBackgroundColor.value,
      extendBody: true,
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation,
        ) =>
            FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          fillColor: radioScreenBackgroundColor.value,
          child: child,
        ),
        child: _mainScreens[_currentIndex]['widget'] as Widget,
      ),
      bottomNavigationBar: SizedBox(
        height: 64,
        child: CustomNavigationBar(
          backgroundColor: radioScreenBackgroundColor.value,
          opacity: 1,
          strokeColor: Colors.transparent,
          selectedColor: Colors.white,
          unSelectedColor: Colors.white.withOpacity(0.5),
          iconSize: 30,
          elevation: 0,
          currentIndex: _currentIndex,
          onTap: (index) {
            _currentIndex = index;
            setState(() {});
          },
          items: [
            CustomNavigationBarItem(
              icon: _mainScreens[0]['icon'] as Widget,
            ),
            CustomNavigationBarItem(
              icon: _mainScreens[1]['icon'] as Widget,
            ),
            CustomNavigationBarItem(
              icon: _mainScreens[2]['icon'] as Widget,
            ),
            CustomNavigationBarItem(
              icon: _mainScreens[3]['icon'] as Widget,
            ),
            CustomNavigationBarItem(
              icon: _mainScreens[4]['icon'] as Widget,
            ),
          ],
        ),
      ),
    );
  }
}
