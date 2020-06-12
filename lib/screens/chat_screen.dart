import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('chats/fWRMzk8qApsATv4YONfz/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.hasError)
            return new Text('Error: ${streamSnapshot.error}');
          switch (streamSnapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
            final documents = streamSnapshot.data.documents;
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (ctx, index) => Container(
                  padding: EdgeInsets.all(8),
                  child: Text(documents[index]['text']),
                ),
              );
          }
        },
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: () {
            Firestore.instance.collection('chats/fWRMzk8qApsATv4YONfz/messages').add({'text': 'This was added by clicking the button'});
          }),
    );
  }
}
