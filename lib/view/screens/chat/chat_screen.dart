import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:bed3avendor/provider/chat_provider.dart';
import 'package:bed3avendor/utill/color_resources.dart';
import 'package:bed3avendor/utill/dimensions.dart';
import 'package:bed3avendor/view/base/custom_app_bar.dart';
import 'package:bed3avendor/view/screens/chat/widget/chat_shimmer.dart';
import 'package:bed3avendor/view/screens/chat/widget/message_bubble.dart';
import 'package:bed3avendor/view/screens/chat/widget/send_message_widget.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final int userId;
  ChatScreen({@required this.userId, this.name = ''});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final ImagePicker picker = ImagePicker();




  @override
  void initState() {
    Provider.of<ChatProvider>(context, listen: false).getMessageList(context, widget.userId, 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Consumer<ChatProvider>(builder: (context, chat, child) {
        return Column(children: [

          CustomAppBar(title: widget.name),

          // Chats
          Expanded(child: chat.messageList != null ? chat.messageList.length != 0 ?
          ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            itemCount: chat.messageList.length,
            reverse: true,
            itemBuilder: (context, index) {

              return MessageBubble(message: chat.messageList[index]);
            },
          ) : SizedBox.shrink() : ChatShimmer()),

          SendMessageWidget(id: widget.userId)
        ]);
      }),
    );
  }
}



