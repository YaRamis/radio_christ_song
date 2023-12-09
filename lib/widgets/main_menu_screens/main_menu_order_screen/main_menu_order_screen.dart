import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:radio_christ_song/domain/api_clients/request_parameters.dart';
import 'package:radio_christ_song/redux/app_state.dart';
import 'package:radio_christ_song/widgets/common_widgets/app_text_fields.dart';
import 'package:radio_christ_song/widgets/main_menu_screens/main_menu_radio_screen/main_menu_radio_screen.dart';

import '../../../redux/app_middlewares.dart';
import '../../../theme/app_colors.dart';
import 'main_menu_order_screen_card.dart';

class MainMenuOrderScreenWidget extends StatefulWidget {
  const MainMenuOrderScreenWidget({super.key});

  @override
  State<MainMenuOrderScreenWidget> createState() =>
      _MainMenuOrderScreenWidgetState();
}

class _MainMenuOrderScreenWidgetState extends State<MainMenuOrderScreenWidget> {
  String _searchQuery = '';
  static const _numberOfCardsPerRequest = 14;
  final PagingController<int, MainMenuOrderTrack> _pagingController =
      PagingController(firstPageKey: 0);
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      await _fetchPage(pageKey);
    });
    _textEditingController.addListener(() async {
      _searchQuery = _textEditingController.text;
      _pagingController.refresh();
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    StoreProvider.of<AppState>(context).dispatch(fetchRadioOrderTracks(
        GetRadioOrderTracksParameters(
            limit: _numberOfCardsPerRequest,
            offset: pageKey * _numberOfCardsPerRequest,
            searchQuery: _searchQuery), (radioOrderTracks) {
      final tracks = radioOrderTracks.tracks
          .map((track) => MainMenuOrderTrack(
              id: track.id,
              title: track.title,
              author: track.author,
              imageUrl: track.imgUrl))
          .toList();

      if (tracks.length < _numberOfCardsPerRequest) {
        _pagingController.appendLastPage(tracks);
      } else {
        _pagingController.appendPage(tracks, pageKey + 1);
      }
    }));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onHorizontalDragStart: (dragStartDetails) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: const Text('Стол заказов'),
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppDefaultTextField(
                    textEditingController: _textEditingController,
                    hintText: 'Поиск',
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () =>
                      Future.sync(() => _pagingController.refresh()),
                  color: AppColors.blue,
                  child: PagedListView<int, MainMenuOrderTrack>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate(
                      itemBuilder: (BuildContext context, item, int index) {
                        return MainMenuOrderScreenCardWidget(orderTrack: item);
                      },
                      noItemsFoundIndicatorBuilder: (BuildContext context) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Нет треков, доступных для заказа',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
