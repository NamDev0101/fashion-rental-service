import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frs_mobile/core/constants/color_constants.dart';
import '../../utils/asset_helper.dart';
import '../../utils/image_helper.dart';
import '../widgets/app_bar_main.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:frs_mobile/services/authprovider.dart';

class ChatScreen extends StatefulWidget {
  final int? roomID;
  const ChatScreen({super.key, this.roomID});
  static const String routeName = '/chat_screen';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    int? accountID = AuthProvider.userModel?.accountID;
    int? roomID = widget.roomID;
    print('code : $accountID');
    String url = roomID != null
        ? 'http://fashionrental.online/$accountID/chat/$roomID'
        : 'http://fashionrental.online/$accountID/chat';
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url)); // thay thế url của cậu vào
  }

  @override
  Widget build(BuildContext context) {
    return AppBarMain(
        titleAppbar: 'Chat',
        leading: widget.roomID == null
            ? FractionallySizedBox(
                widthFactor: 0.8,
                heightFactor: 0.8,
                child: ImageHelper.loadFromAsset(
                  AssetHelper.imageLogoFRS,
                ),
              )
            : GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                    color: ColorPalette.backgroundScaffoldColor,
                    child: Icon(FontAwesomeIcons.angleLeft)),
              ),
        child: Scaffold(
          body: WebViewWidget(controller: controller),
        ));
  }
}
