import 'dart:convert';

import 'package:farmers_friend/src/network/ApiClient.dart';
import 'package:farmers_friend/src/utility/color_converter.dart';
import 'package:farmers_friend/src/utility/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:speech_recognition/speech_recognition.dart';

class ChatWindow extends StatefulWidget {
  final String username;
  final String plantName;
  ChatWindow({this.username, this.plantName});
  @override
  _ChatWindowState createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow>  with SingleTickerProviderStateMixin {
  List<String> _messages;

  TextEditingController textEditingController;
  ScrollController scrollController;
  FlutterSound flutterSound = new FlutterSound();
  AnimationController _animationController;


  bool enableButton = true;
  String chatBotReply = "";
  bool reverse = true;
  bool _isRecord = false;

  int currentIndex = 0;
  String country = "";
  String username = "";
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  String resultText = "";

  void initSpeechRecognizer(){
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() => textEditingController.text = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() {
        _isListening = false;
        _isRecord = false;
        }),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }

  Future initializeDetails() async{
    String musername = await getNameFromPref();
    String mcountry = await getCountryFromPref();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _animationController.addListener(() {
      setState(() {});
    });
    setState(() {
      username = musername;
      country = mcountry;
    });
    _messages = List<String>();
    _messages.add("How are you $username?");
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }


  @override
  void initState() {
    initializeDetails();
    initSpeechRecognizer();
    // _messages.add("I'm fine. thanks");
    // _messages.add("This is a multiline message.\nKeep reading!");
    // _messages.add("And this is a very..\nvery..\nlong..\nmessage.");
    // _messages.add("Hi! How are you?");
    // _messages.add("I'm fine. thanks");
    // _messages.add("This is a multiline message.\nKeep reading!");
    // _messages.add("And this is a very..\nvery..\nlong..\nmessage.");

    textEditingController = TextEditingController();

    scrollController = ScrollController();
    reverse = true;
    super.initState();
  }

  void handleSendMessage() async{
    var text = textEditingController.value.text;
    textEditingController.clear();
    setState(() {
      reverse = false;
      _messages.add(text);
      enableButton = false;
    });
    var response = await ApiClient.sendMessageToChatBot(text);
    setState(() {
      chatBotReply = response["result"]["fulfillment"]["speech"];
      reverse = true;
      _messages.add(chatBotReply);
    });
    Future.delayed(Duration(milliseconds: 100), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          curve: Curves.ease, duration: Duration(milliseconds: 500));
    });
  }

  @override
  Widget build(BuildContext context) {
    double scale = 1 - _animationController.value;
    var textInput = Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextField(
              
              onChanged: (text) {
                setState(() {
                  enableButton = text.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    elevation: 4,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          _isRecord = !_isRecord;
                        });
                        // if (_isRecord){

                        //   if (_isAvailable && _isListening){
                        //     _speechRecognition.listen(locale: "en-US").then((result)=> print("$result"));
                        //     setState(() {
                        //     textEditingController.text = resultText;
                        //   });
                        //   }
                        //   setState(() {
                        //     textEditingController.text = resultText;
                        //   });
                          
                        // }else{
                        //   if (_isAvailable && _isListening){
                        //     _speechRecognition.stop().then((result)=> setState((){
                        //       _isListening = result;

                        //     }));
                        //   }
                        // }
                        if(_isRecord){
                          _animationController.forward();
                          if (_isAvailable && !_isListening)
                        _speechRecognition
                            .listen(locale: "en_US")
                            .then((result) => print('$result'));
                        }
                        else{
                          _animationController.reverse();
                          if (_isListening)
                        _speechRecognition.stop().then(
                              (result) => setState(() => _isListening = result),
                            );
                            
                        }
                        
                            
                        
                        
                      },
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 5.0,
                  spreadRadius: 0.25,
              ),
            ],
                        ),
                        child: Center(child: Icon(!_isRecord ? Icons.mic: Icons.stop, size: 16,)),
                      ),
                    ),
                  ),
                ),
                hintText: "Type a message",
              ),
              controller: textEditingController,
            ),
          ),
        ),
        enableButton
            ? IconButton(
                color: Theme.of(context).primaryColor,
                icon: Icon(
                  Icons.send,
                ),
                disabledColor: Colors.grey,
                onPressed: handleSendMessage,
              )
            : IconButton(
                color: Colors.blue,
                icon: Icon(
                  Icons.send,
                ),
                disabledColor: Colors.grey,
                onPressed: null,
              )
      ],
    );

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
       title: Text("${widget.plantName}"),
      // title: Text(resultText),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                bool reverse = true;

                if (index % 2 == 0) {
                  reverse = false;
                }

                var avatar = Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
                  child: CircleAvatar(
                    child: Text("A"),
                  ),
                );

                var botAvatar = Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
                  child: CircleAvatar(
                    child: Image.asset("assets/images/bot.png"),
                  ),
                );

                var triangle = CustomPaint(
                  painter: Triangle(),
                );

                var messagebody = DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(getColorHexFromStr("#36ab80")),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(_messages[index], style: TextStyle(color: Colors.white),),
                    ),
                  ),
                );

                Widget message;

                if (reverse) {
                  message = Stack(
                    children: <Widget>[
                      messagebody,
                      Positioned(right: 0, bottom: 0, child: triangle),
                    ],
                  );
                } else {
                  message = Stack(
                    children: <Widget>[
                      Positioned(left: 0, bottom: 0, child: triangle),
                      messagebody,
                    ],
                  );
                }

                if (reverse) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 250,
                          child: message
                          ),
                      ),
                      avatar,
                    ],
                  );
                } else {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      botAvatar,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 250,
                          child: message
                          ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Divider(height: 2.0),
          textInput
        ],
      ),
    );
  }
}

class Triangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Color(getColorHexFromStr("#36ab80"));

    var path = Path();
    path.lineTo(10, 0);
    path.lineTo(0, -10);
    path.lineTo(-10, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}