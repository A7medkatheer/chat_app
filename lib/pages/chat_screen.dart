import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:chat_app/widgets/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
  static String id = "chat_screen";
  final ScrollController _controller = ScrollController();

  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kTime, descending: true).snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i].data()));
            }
            // print(snapshot.data!.docs[0]['message']);
            return Scaffold(
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: kPrimaryColor,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(kLogo, height: 50),
                      const Text("Chat"),
                    ],
                  )),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messagesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return messagesList[index].id == email
                              ? ChatBuble(
                                  message: messagesList[index],
                                )
                              : ChatBubleForFriend(
                                  message: messagesList[index]);
                        }),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: messageController,
                      onSubmitted: (date) {
                        messages.add({
                          'message': date,
                          kTime: DateTime.now(),
                          'id': email
                        });
                        messageController.clear();
                        _controller.animateTo(
                          _controller.position.minScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.send, color: kPrimaryColor),
                        hintText: "Enter your message",
                        border: const OutlineInputBorder(
                            // borderRadius: BorderRadius.all(Radius.circular(50)),
                            ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Text("Loading...");
          }
        }));
  }
}
