import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socketio_message_app/Model/message_view_model.dart';

class MessagingView extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  MessagingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Socket.io Messaging')),
      body: Column(
        children: [
          Expanded(
            child: Consumer<MessageViewModel>(
              builder: (context, viewModel, child) {
                return ListView.builder(
                  itemCount: viewModel.messages.length,
                  itemBuilder: (context, index) {
                    final message = viewModel.messages[index];
                    return ListTile(
                      title: Text(message.sender),
                      subtitle: Text(message.content),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Enter message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final content = _controller.text.trim();
                    if (content.isNotEmpty) {
                      context.read<MessageViewModel>().sendMessage('User', content);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}