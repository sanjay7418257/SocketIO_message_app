import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socketio_message_app/Model/message_model.dart';

class MessageViewModel extends ChangeNotifier {
  late IO.Socket socket;
  List<Message> messages = [];

  MessageViewModel() {
    _initializeSocketConnection();
  }

  void _initializeSocketConnection() {
socket = IO.io('http://10.0.2.2:3000', IO.OptionBuilder()
      .setTransports(['websocket'])
      .disableAutoConnect()
      .build());

  print('Attempting to connect to Socket.IO server...');
  
  socket.connect(); 
    socket.onConnect((_) {
      print('Connected to socket server');
    });

    socket.on('receive_message', (data) {
      final message = Message(sender: data['sender'], content: data['content']);
      messages.add(message);
      notifyListeners(); 
    });

    socket.onDisconnect((_) {
      print('Disconnected from socket server');
    });
  }

  void sendMessage(String sender, String content) {
    final message = {'sender': sender, 'content': content};
    socket.emit('send_message', message); 
  }
}
