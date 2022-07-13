import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tflite/tflite.dart';
import 'package:object_detection/model/exp_quo.dart';
import 'package:object_detection/ui/result_view.dart';

class testImageConvert extends StatefulWidget {
  final List<String> listimagepath;

  const testImageConvert({Key key, this.listimagepath}) : super(key: key);

  @override
  _testImageConvertState createState() => _testImageConvertState();
}
abstract class Quoter {
  String getQuote(int index);
}

class AngryQuotes extends Quoter {
  var quotes = {0: "angry me", 1: "angry you"};

  @override
  String getQuote(int index) {
    return quotes[index];
  }
}

class DisgustQuotes extends Quoter {
  var quotes = {0: "digust me", 1: "disgust you"};

  @override
  String getQuote(int index) => quotes[index];
}

class FearQuotes extends Quoter {
  var quotes = {0: "fear me", 1: "fear you"};

  @override
  String getQuote(int index) => quotes[index];
}

class HappyQuotes extends Quoter {
  var quotes = {0: "happy me", 1: "happy you"};

  @override
  String getQuote(int index) => quotes[index];
}

class SadQuotes extends Quoter {
  var quotes = {0: "sad me", 1: "sad you"};

  @override
  String getQuote(int index) => quotes[index];
}

class SurpriseQuotes extends Quoter {
  var quotes = {0: "surprise me", 1: "surprise you"};

  @override
  String getQuote(int index) => quotes[index];
}
class _testImageConvertState extends State<testImageConvert> {

  List<String> imagePath;
  bool _loading = false;
  List<dynamic> _outputs = new List();
  Map<int, dynamic> outputmap = new Map();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    imagePath = widget.listimagepath;
    _loading = true;
    //
    // loadModel().then((value) {
    //   setState(() {
    //     log("PATH ${imagePath[i]}");
    //     classifyImage(imagePath[i], 1);
    //     _loading = false;
    //   });
    // });

    loadModel().then((value) {
      setState(() {
        log("PATH ${imagePath[0]}");
        classifyImage(imagePath[0], 0);
        _loading = false;
      });
    });
    // for (int i = 0; i < imagePath.length; i++) {

    // }
    switch (outputmap[0]["index"]) {
      case 1:
        {
          var selectedQuotes = AngryQuotes();
          var index = math.Random().nextInt(2);
          log("${selectedQuotes.getQuote(index)}");
          break;
        }
      case 2:
        {
          var selectedQuotes = DisgustQuotes();
          var index = math.Random().nextInt(2);
          log("${selectedQuotes.getQuote(index)}");
          break;
        }
      case 3:
        {
          var selectedQuotes = DisgustQuotes();
          var index = math.Random().nextInt(2);
          log("${selectedQuotes.getQuote(index)}");
          break;
        }
      case 4:
        {
          var selectedQuotes = DisgustQuotes();
          var index = math.Random().nextInt(2);
          log("${selectedQuotes.getQuote(index)}");
          break;
        }
      case 5:
        {
          var selectedQuotes = DisgustQuotes();
          var index = math.Random().nextInt(2);
          log("${selectedQuotes.getQuote(index)}");
          break;
        }
      case 6:
        {
          var selectedQuotes = DisgustQuotes();
          var index = math.Random().nextInt(2);
          log("${selectedQuotes.getQuote(index)}");
          break;
        }
    }
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_exp(float).tflite",
      labels: "assets/labels_exp.txt",
    );
  }

  classifyImage(String imagePath, int index) async {
    Tflite.runModelOnImage(
      path: imagePath,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    ).then((value) {
      setState(() {
        _loading = false;
        //Declare List _outputs in the class which will be used to show the classified classs name and confidence
        // _outputs.add(value);
        // log(_outputs[0]["label"]);
        outputmap[index] = value;
        log("INI OUTPUT $index ${outputmap[index]}");
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // imagePath == null ? Container() : Image.file(File(imagePath)),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // _outputs != null
                  //     ? Text(
                  //         '${_outputs[0]["label"]}',
                  //         style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 20.0,
                  //           background: Paint()..color = Colors.white,
                  //         ),
                  //       )
                  //     : Container(),
                  // RaisedButton(
                  //   child: Text(
                  //     'Lanjut',
                  //     style: GoogleFonts.openSans(),
                  //   ),
                  //   onPressed: (){
                  //     Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => ResultView(resultClassification: _outputs[0]["label"],)));
                  //   },
                  //   color: Colors.lightGreen,
                  //   textColor: Colors.white,
                  //   padding: EdgeInsets.all(8.0),
                  //   splashColor: Colors.grey,
                  // ),
                ],
              ),
            ),
    );
  }
}
