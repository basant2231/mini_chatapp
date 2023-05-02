import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
DateTime now = DateTime.now();
  late User signedInUser;
class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);
  static String ChatScreenRoute = '/ChatScreenScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  String? messageText;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
       signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void GetMessagesStreams() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[600]! ,
        title: Row(
          children: [
            Image.asset(
              'lib/Images/logo.png',
              height: 40,
            ),
            SizedBox(
              width: 10,
            ),
            Text('MessageMe'),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                GetMessagesStreams();
                 _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MessageStreamBuilder(firestore: _firestore),
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Color.fromARGB(225, 206, 53, 130), width: 2)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          hintText: 'Write Your Message Here........',
                          border: InputBorder.none),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        messageTextController.clear();
                        _firestore.collection('messages').add({
                          'sender': signedInUser.email,
                          'text': messageText,
                          'time':FieldValue.serverTimestamp()
                        });
                      },
                      child: Text(
                        'send',
                        style: TextStyle(
                            color: Colors.cyan[600]!,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({
    super.key,
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> messagewidget = [];
        if (snapshot.hasData) {
          final messages = snapshot.data!.docs.reversed;
          for (var message in messages) {
            final messagetext = message.get('text');
            final messagesender = message.get('sender');
            final currentuser=signedInUser.email;
          
            final messageWidget = MessageLine(isme:currentuser==messagesender ,
              sender: messagesender,
              text: messagetext,
            );
            messagewidget.add(messageWidget);
          }
        } else {
          Center(
            child: CircularProgressIndicator(),
          );
        }
        return Expanded(
          child: ListView(reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messagewidget,
          ),
        );
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({
    Key? key,
    required this.sender,
    required this.text,required this.isme,
  }) : super(key: key);
  final String sender;
  final String text;
  final isme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isme?CrossAxisAlignment.end :CrossAxisAlignment.start,
        children: [
          Text('${now.year}-${(now.month)}-${(now.day)} ${(now.hour)}:${(now.minute)}:${(now.second)}',style: TextStyle(color:Colors.black54),),
          Text(
            '$sender',
            style: TextStyle(fontSize: 12, color:Color.fromARGB(255, 169, 176, 208) ),
          ),
          Material(
              borderRadius: BorderRadius.only(
                topLeft:isme? Radius.circular(30):Radius.circular(0),
                topRight: isme? Radius.circular(0):Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              elevation: 5,
              color:isme? Colors.cyan[600]!:Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  '$text',
                  style: TextStyle(color:isme? Colors.white:Colors.pink, fontSize: 15),
                ),
              )),
        ],
      ),
    );
  }
}
