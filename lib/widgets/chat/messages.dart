import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocuments = snapshot.data.documents;
        return ListView.builder(
            reverse: true,
            itemCount: chatDocuments.length,
            itemBuilder: (context, index) {
              return Text(chatDocuments[index].get('text'));
            });
      },
    );
  }
}
