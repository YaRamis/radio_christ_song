import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:radio_christ_song/widgets/common_widgets/app_buttons.dart';
import 'package:radio_christ_song/widgets/common_widgets/app_text_fields.dart';
import 'package:radio_christ_song/widgets/main_menu_screens/main_menu_radio_screen/main_menu_radio_screen.dart';

import '../../../domain/api_clients/request_parameters.dart';
import '../../../redux/app_middlewares.dart';
import '../../../redux/app_state.dart';
import '../../../theme/app_colors.dart';
import 'main_menu_order_screen_card.dart';

class MainMenuOrderScreenDialogWidget extends StatefulWidget {
  final MainMenuOrderTrack orderTrack;

  const MainMenuOrderScreenDialogWidget({super.key, required this.orderTrack});

  @override
  State<MainMenuOrderScreenDialogWidget> createState() =>
      _MainMenuOrderScreenDialogWidgetState();
}

class _MainMenuOrderScreenDialogWidgetState
    extends State<MainMenuOrderScreenDialogWidget> {
  final TextEditingController _textEditingControllerName =
      TextEditingController();

  final TextEditingController _textEditingControllerMessage =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingControllerName.dispose();
    _textEditingControllerMessage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
      child: AlertDialog(
        insetPadding: const EdgeInsets.all(20),
        shadowColor: Colors.transparent,
        backgroundColor: radioScreenBackgroundColor.value,
        contentPadding: EdgeInsets.zero,
        alignment: Alignment.center,
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Заказ песни',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 105,
                      child: Text(
                        'Исполнитель: ',
                        textAlign: TextAlign.end,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(child: Text(widget.orderTrack.author))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 105,
                      child: Text(
                        'Название: ',
                        textAlign: TextAlign.end,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(child: Text(widget.orderTrack.title))
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Представьтесь:',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                AppDefaultTextField(
                  textEditingController: _textEditingControllerName,
                  maxLength: 20,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Сообщение в эфир:',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                AppDefaultTextField(
                  textEditingController: _textEditingControllerMessage,
                  maxLength: 100,
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: AppDefaultButton(
                        onPressed: () {
                          StoreProvider.of<AppState>(context)
                              .dispatch(sendTrackRequest(
                                  PostTrackRequestParameters(
                                    id: widget.orderTrack.id,
                                    message: _textEditingControllerMessage.text,
                                    person: _textEditingControllerName.text,
                                  ), () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Ваша заявка успешно отправлена.'),
                              backgroundColor: AppColors.darkGreen,
                            ));
                            Navigator.of(context).pop();
                          }, () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  'Возникли неполадки. Пожалуйста, свяжитесь с разработчиками!'),
                              backgroundColor: Colors.red,
                            ));
                            Navigator.of(context).pop();
                          }));
                        },
                        child: const Text('Отправить'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppDefaultButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Отмена'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
