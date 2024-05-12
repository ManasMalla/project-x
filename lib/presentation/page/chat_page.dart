import 'package:flutter/material.dart';
import 'package:socialpreneur/presentation/util/snackbar_util.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {
        'name': 'Andrew S',
        'lastSeen': 'Shall we proceed with the earlier idea',
        'imageUrl': 'https://github.com/ManasMalla.png'
      },
      {
        'name': 'John Doe',
        'lastSeen': 'I am interested in the project',
        'imageUrl': 'https://github.com/johndoe2.png'
      },
      {
        "name": "Jane Smith",
        "lastSeen": "I agree with your proposal",
        "imageUrl": "https://github.com/janesmith.png"
      },
      {
        "name": "Robert Johnson",
        "lastSeen": "Can we reschedule the meeting?",
        "imageUrl": "https://github.com/robertjohnson.png"
      },
      {
        "name": "Emily Davis",
        "lastSeen": "I've completed the task",
        "imageUrl": "https://github.com/emilydavis.png"
      },
      {
        "name": "Michael Miller",
        "lastSeen": "I need help with the code",
        "imageUrl": "https://github.com/michaelmiller.png"
      }
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "@manasmalla",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_square),
            onPressed: () {},
          ),
          SizedBox(
            width: 24,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Messages"),
                Text("Requests"),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  onTap: () {
                    showSnackbar(context, "Coming soon. Stay tuned!");
                  },
                  leading: ClipOval(
                    child: Image.network(
                      chat["imageUrl"] ?? "https://github.com/ManasMalla.png",
                      height: 42,
                      width: 42,
                    ),
                  ),
                  title: Text(chat["name"] ?? "Andrew S"),
                  subtitle: Opacity(
                    opacity: 0.7,
                    child: Text(chat["lastSeen"] ??
                        "Shall we proceed with the earlier idea"),
                  ),
                );
              },
              itemCount: chats.length,
            ),
          ),
        ],
      ),
    );
  }
}
