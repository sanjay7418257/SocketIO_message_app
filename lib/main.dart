import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socketio_message_app/Model/message_view_model.dart';
import 'package:socketio_message_app/Screen/messaging_view.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MessageViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MessagingView(),
    );
  }
}
