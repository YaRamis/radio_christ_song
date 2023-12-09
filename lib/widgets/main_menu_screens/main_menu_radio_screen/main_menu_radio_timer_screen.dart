import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:radio_christ_song/widgets/common_widgets/app_buttons.dart';
import 'package:radio_christ_song/widgets/main_menu_screens/main_menu_radio_screen/main_menu_radio_screen.dart';

import '../../app.dart';

int _hours = 0;
int _minutes = 0;
int _seconds = 0;
int _allInSeconds = 0;
Duration _myDuration = const Duration();

bool _isTimerPaused = false;

class MainMenuRadioTimerScreenWidget extends StatefulWidget {
  const MainMenuRadioTimerScreenWidget({super.key});

  @override
  State<MainMenuRadioTimerScreenWidget> createState() =>
      _MainMenuRadioTimerScreenWidgetState();
}

class _MainMenuRadioTimerScreenWidgetState
    extends State<MainMenuRadioTimerScreenWidget>
    with AutomaticKeepAliveClientMixin<MainMenuRadioTimerScreenWidget> {
  late final Timer _countdownTimer;

  void startTimer() {
    isTimerActive.value = true;
    _isTimerPaused = false;
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    setState(() {});
  }

  void pauseTimer() {
    _isTimerPaused = true;
    setState(() => countdownTimer.cancel());
  }

  void stopTimer() {
    pauseTimer();
    isTimerActive.value = false;
    _hours = 0;
    _minutes = 0;
    // _seconds = 0;
    setState(() {});
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    final seconds = _myDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      countdownTimer.cancel();
      isTimerActive.value = false;
      radioPlayer.stop();
      isPlaying = false;
    } else {
      _myDuration = Duration(seconds: seconds);
      _hours = _myDuration.inHours.remainder(24);
      _minutes = _myDuration.inMinutes.remainder(60);
      _seconds = _myDuration.inSeconds.remainder(60);
    }
  }

  @override
  void initState() {
    _countdownTimer =
        Timer.periodic(const Duration(milliseconds: 1), (_) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(_hours);
    final minutes = strDigits(_minutes);
    final seconds = strDigits(_seconds);
    // final seconds = strDigits(_seconds);
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
      child: AlertDialog(
        insetPadding: const EdgeInsets.all(20),
        shadowColor: Colors.transparent,
        backgroundColor: radioScreenBackgroundColor.value,
        contentPadding: EdgeInsets.zero,
        alignment: Alignment.center,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            const Text(
              'Таймер',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            isTimerActive.value
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 250,
                              height: 250,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 10,
                                strokeCap: StrokeCap.round,
                                backgroundColor: Colors.white.withOpacity(0.2),
                                value: _myDuration.inSeconds / _allInSeconds,
                              ),
                            ),
                            Text(
                              '$hours:$minutes:$seconds',
                              style: const TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _isTimerPaused
                                ? SizedBox(
                                    width: 140,
                                    child: AppDefaultButton(
                                      onPressed: () {
                                        startTimer();
                                      },
                                      child: const Text('Продолжить'),
                                    ),
                                  )
                                : SizedBox(
                                    width: 140,
                                    child: AppDefaultButton(
                                      onPressed: () {
                                        pauseTimer();
                                      },
                                      child: const Text('Пауза'),
                                    ),
                                  ),
                            const SizedBox(width: 16),
                            SizedBox(
                              width: 140,
                              child: AppDefaultButton(
                                onPressed: () {
                                  stopTimer();
                                },
                                child: const Text('Стоп'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NumberPicker(
                            minValue: 0,
                            maxValue: 24,
                            zeroPad: true,
                            value: _hours,
                            infiniteLoop: true,
                            textStyle:
                                TextStyle(color: Colors.white.withOpacity(0.6)),
                            selectedTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                            onChanged: (number) {
                              _hours = number;
                              setState(() {});
                            },
                          ),
                          const Text(
                            ':',
                            style: TextStyle(fontSize: 20),
                          ),
                          NumberPicker(
                            minValue: 0,
                            maxValue: 59,
                            zeroPad: true,
                            value: _minutes,
                            infiniteLoop: true,
                            textStyle:
                                TextStyle(color: Colors.white.withOpacity(0.6)),
                            selectedTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                            onChanged: (number) {
                              _minutes = number;
                              setState(() {});
                            },
                          ),
                          // const Text(
                          //   ':',
                          //   style: TextStyle(fontSize: 20),
                          // ),
                          // NumberPicker(
                          //   minValue: 0,
                          //   maxValue: 59,
                          //   zeroPad: true,
                          //   value: _seconds,
                          //   infiniteLoop: true,
                          //   onChanged: (number) {
                          //     _seconds = number;
                          //     setState(() {});
                          //   },
                          // ),
                        ],
                      ),
                      SizedBox(
                        width: 150,
                        child: (_hours == 0 && _minutes == 0)
                            ? const AppDisabledDefaultButton(
                                child: Text('Начать'),
                              )
                            : AppDefaultButton(
                                onPressed: () {
                                  _myDuration = Duration(
                                    hours: _hours,
                                    minutes: _minutes,
                                  );
                                  _allInSeconds = _myDuration.inSeconds;
                                  startTimer();
                                },
                                child: const Text('Начать'),
                              ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
