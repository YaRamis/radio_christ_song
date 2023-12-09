import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:marquee/marquee.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:radio_christ_song/redux/app_state.dart';
import 'package:redux/redux.dart';

import '../../../domain/api_clients/request_parameters.dart';
import '../../../domain/entities/radio_tracks_history/track_history.dart';
import '../../../redux/app_middlewares.dart';
import '../../app.dart';

bool _mounted = false;

ValueNotifier<Color> radioScreenBackgroundColor =
    ValueNotifier<Color>(Colors.grey.shade600);
final ValueNotifier<int> currentTrackId = ValueNotifier(-1);
Future<PaletteGenerator> updatePaletteGenerator(String image) async {
  final paletteGenerator = await PaletteGenerator.fromImageProvider(
    image.startsWith('http')
        ? Image.network(image).image
        : Image.asset(image).image,
  );
  return paletteGenerator;
}

class MainMenuRadioScreenWidget extends StatefulWidget {
  const MainMenuRadioScreenWidget({super.key});

  @override
  State<MainMenuRadioScreenWidget> createState() =>
      _MainMenuRadioScreenWidgetState();
}

class MainMenuRadioTrackHistory {
  final String title;
  final String author;
  final String? imageUrl;
  final int id;

  MainMenuRadioTrackHistory(TrackHistory trackHistory)
      : title =
            trackHistory.title != '' ? trackHistory.title : metadata?[1] ?? '',
        author = trackHistory.author != ''
            ? trackHistory.author
            : metadata?[0] ?? '',
        imageUrl = trackHistory.imageMediumUrl,
        id = trackHistory.allMusicId;
}

class MainMenuRadioMapStateToProps {
  final Function dispatch;
  final MainMenuRadioTrackHistory trackHistory;
  MainMenuRadioMapStateToProps({
    required this.dispatch,
    required this.trackHistory,
  });
}

class _MainMenuRadioScreenWidgetState extends State<MainMenuRadioScreenWidget> {
  bool _isThumbUp = false;
  bool _isThumbDown = false;
  final ValueNotifier<bool> _isRated = ValueNotifier(false);
  bool _isPlaying = false;
  late Timer _timerIsPlaying;

  @override
  void initState() {
    _mounted = true;
    _isRated.addListener(() {
      if (_isRated.value == true) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Вы уже голосовали за этот трэк')));
        _isRated.value = !_isRated.value;
        setState(() {});
      }
    });
    currentTrackId.addListener(() {
      _isThumbUp = false;
      _isThumbDown = false;
    });
    _isPlaying = isPlaying;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _timerIsPlaying = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_isPlaying != isPlaying) {
        _isPlaying = isPlaying;
        setState(() {});
      }
    });
    isTimerActive.addListener(() {
      if (_mounted) {
        setState(() {});
      }
    });
    radioScreenBackgroundColor.addListener(() {
      if (_mounted) {
        setState(() {});
      }
    });
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    _mounted = false;
    super.deactivate();
  }

  @override
  void dispose() {
    _timerIsPlaying.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'РАДИО\nХристианская Песня',
            textAlign: TextAlign.center,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                barrierColor: const Color(0x55000000),
                builder: (context) => mainMenuRadioTimerScreenWidget,
                context: context,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                isTimerActive.value
                    ? Icons.timer_rounded
                    : Icons.timer_outlined,
                size: 30,
                color: isTimerActive.value
                    ? Colors.white
                    : Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: StoreConnector(
          converter: (Store<AppState> store) => MainMenuRadioMapStateToProps(
            dispatch: store.dispatch,
            trackHistory: MainMenuRadioTrackHistory(
                store.state.radioTracksHistory.tracks[0]),
          ),
          builder: (BuildContext context, props) {
            // radioPlayer.setDefaultArtwork(props.trackHistory.imageUrl ??
            //     'assets/images/default_cover.png');
            // radioPlayer.setCustomMetadata(
            //     [props.trackHistory.author, props.trackHistory.title, '']);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 260,
                  height: 260,
                  child: Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.linear,
                        width: isPlaying ? 260 : 230,
                        height: isPlaying ? 260 : 230,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          // child: props.trackHistory.imageUrl != null
                          //     ? Image.network(
                          //         props.trackHistory.imageUrl as String)
                          //     : Image.asset(
                          //         'assets/images/default_cover.png'),
                          child: props.trackHistory.imageUrl != null
                              ? Image.network(
                                  props.trackHistory.imageUrl as String)
                              : Image.asset('assets/images/default_cover.png'),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                    width: 250,
                    height: 45,
                    child: props.trackHistory.title.length > 14
                        ? Marquee(
                            text: props.trackHistory.title.toString(),
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                            velocity: 30,
                            fadingEdgeEndFraction: 0.2,
                            fadingEdgeStartFraction: 0.2,
                            blankSpace: 60,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          )
                        : Text(
                            props.trackHistory.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          )),
                const SizedBox(height: 5),
                SizedBox(
                  width: 300,
                  child: Text(
                    props.trackHistory.author,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        props.dispatch(sendTrackRating(
                            PostTrackRatingParameters(
                                id: props.trackHistory.id, isLike: false), () {
                          _isRated.value = true;
                        }, () {
                          _isRated.value = true;
                          _isThumbDown = true;
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13),
                        child: _isThumbDown
                            ? const Icon(
                                Icons.thumb_down,
                                size: 40,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.thumb_down_outlined,
                                size: 40,
                                color: Colors.white.withOpacity(0.7),
                              ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    GestureDetector(
                      onTap: () {
                        isPlaying ? radioPlayer.pause() : radioPlayer.play();
                        isPlaying = !isPlaying;
                        setState(() {});
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: isPlaying
                            ? Icon(
                                Icons.pause_rounded,
                                size: 70,
                                color: radioScreenBackgroundColor.value,
                              )
                            : Icon(
                                Icons.play_arrow_rounded,
                                size: 70,
                                color: radioScreenBackgroundColor.value,
                              ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    GestureDetector(
                      onTap: () {
                        props.dispatch(sendTrackRating(
                            PostTrackRatingParameters(
                                id: props.trackHistory.id, isLike: true), () {
                          _isRated.value = true;
                        }, () {
                          _isThumbUp = true;
                        }));
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 13),
                        child: _isThumbUp
                            ? const Icon(
                                Icons.thumb_up,
                                size: 40,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.thumb_up_outlined,
                                size: 40,
                                color: Colors.white.withOpacity(0.7),
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
