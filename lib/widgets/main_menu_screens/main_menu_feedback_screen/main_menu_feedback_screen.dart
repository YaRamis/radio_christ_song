import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:radio_christ_song/domain/api_clients/request_parameters.dart';
import 'package:radio_christ_song/redux/app_middlewares.dart';
import 'package:radio_christ_song/redux/app_state.dart';
import 'package:radio_christ_song/theme/app_colors.dart';
import 'package:radio_christ_song/widgets/common_widgets/app_buttons.dart';
import 'package:radio_christ_song/widgets/common_widgets/app_text_fields.dart';
import 'package:radio_christ_song/widgets/main_menu_screens/main_menu_radio_screen/main_menu_radio_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MainMenuFeedbackScreenWidget extends StatefulWidget {
  const MainMenuFeedbackScreenWidget({super.key});

  @override
  State<MainMenuFeedbackScreenWidget> createState() =>
      _MainMenuFeedbackScreenWidgetState();
}

class _MainMenuFeedbackScreenWidgetState
    extends State<MainMenuFeedbackScreenWidget> {
  final TextEditingController _textEditingEmailController =
      TextEditingController();
  final TextEditingController _textEditingSubjectController =
      TextEditingController();
  final TextEditingController _textEditingMessageController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: const Text('Обратная связь'),
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Мы в соц. сетях:',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        final Uri url = Uri.parse('https://t.me/xpradio');
                        await launchUrl(url);
                      },
                      child: const Icon(
                        Icons.telegram_rounded,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                    // AppDefaultTextField(
                    //   textEditingController: _textEditingEmailController,
                    //   hintText: 'Электронная почта',
                    // ),
                    // const SizedBox(height: 20),
                    // AppDefaultTextField(
                    //   textEditingController: _textEditingSubjectController,
                    //   hintText: 'Тема',
                    // ),
                    // const SizedBox(height: 20),
                    // AppDefaultTextField(
                    //   textEditingController: _textEditingMessageController,
                    //   hintText: 'Сообщение',
                    //   maxLines: 6,
                    // ),
                    // const SizedBox(height: 20),
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 50,
                    //   child: AppDefaultButton(
                    //     onPressed: () {
                    //       FocusManager.instance.primaryFocus?.unfocus();
                    //       StoreProvider.of<AppState>(context).dispatch(
                    //           sendFeedback(
                    //               PostFeedbackParameters(
                    //                   email: _textEditingEmailController.text,
                    //                   message: _textEditingMessageController.text,
                    //                   subject: _textEditingSubjectController
                    //                       .text), (status) {
                    //         if (status == null) {
                    //           ScaffoldMessenger.of(context)
                    //               .showSnackBar(const SnackBar(
                    //             content: Text('no status'),
                    //           ));
                    //         } else {
                    //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //             content: Text(status),
                    //           ));
                    //         }
                    //       }));
                    //     },
                    //     child: const Text(
                    //       'Отправить',
                    //       style: TextStyle(fontSize: 18),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
