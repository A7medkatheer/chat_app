import 'package:chat_app/widgets/constant.dart';
// import 'package:flutter/foundation.dart';

class Message {
   final String message;
   final String id;

  Message(this.message, this.id);
  
factory Message.fromJson( jsonData) {
    return Message(
      jsonData[kMessage],
      jsonData['id'],
    );
  }
  
  
}