import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tflite/tflite.dart';
import 'package:object_detection/model/exp_quo.dart';
import 'package:object_detection/ui/result_view.dart';

import 'home_view.dart';

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
  var quotes = {0: "don't be mad just by such a thing, no need to ruin your days", 1: "it's okay if you don't have such a good day, don't keep keep it till sun goes die"};

  @override
  String getQuote(int index) {
    return quotes[index];
  }
}

class DisgustQuotes extends Quoter {
  var quotes = {0: "ini memang hidupmu, wajar jika merasa muak, jangan lupa kalau kamu tidak sendiri ya", 1: "don't let that thing's around you anymore!"};

  @override
  String getQuote(int index) => quotes[index];
}

class FearQuotes extends Quoter {
  var quotes = {0: "orang pemberani bukanlah dia yang tidak merasa takut, tapi dia yang mengalahkan rasa takut itu", 1: "don't let your fear make you such a loser"};

  @override
  String getQuote(int index) => quotes[index];
}

class HappyQuotes extends Quoter {
  var quotes = {0: "happy is just a bunch of trigger to make your day!", 1: "bahagia itu sederhana, sesederhana melihat orang yang kita sayangi bahagia"};

  @override
  String getQuote(int index) => quotes[index];
}

class SadQuotes extends Quoter {
  var quotes = {0: "orang menangis bukan karena mereka lemah. Tapi, mereka menangis karena telah berusaha kuat dalam waktu yang lama", 1: "air mata yang menetes untuk orang lain bukanlah pertanda kelemahan. Itu adalah tanda hati yang murni"};

  @override
  String getQuote(int index) => quotes[index];
}

class SurpriseQuotes extends Quoter {
  var quotes = {0: "jika kita melakukan semua hal yang kita mampu lakukan, kita telah sungguh-sungguh membuat diri kita terkejut", 1: "tidak perlu terlalu kaget, perubahan ini hal yang biasa terjadi"};

  @override
  String getQuote(int index) => quotes[index];
}
class _testImageConvertState extends State<testImageConvert> {

  List<String> imagePath;
  String Quotes;
  bool _loading = false;
  List<dynamic> _outputs ;
  Map<int, dynamic> outputmap = new Map();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    imagePath = widget.listimagepath;
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });

    log("PATH ${imagePath[0]}");
    classifyImage(imagePath[0], 0);
    // for (int i = 0; i < imagePath.length; i++) {

    // }

  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_exp(float).tflite",
      labels: "assets/labels_exp.txt",
    );
  }

  classifyImage(String imagePath, int index) async {
    var output = await Tflite.runModelOnImage(
      path: imagePath,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      //Declare List _outputs in the class which will be used to show the classified classs name and confidence
      // _outputs.add(value);
      // log(_outputs[0]["label"]);
      // outputmap[index] = value;
      _outputs = output;
      log(_outputs[0]["label"]);
      // log(_outputs.toString());
      log("INI OUTPUT $index ${_outputs[0].toString()}");
      log("INI INDEX $index ${_outputs[0]["index"]}");

      switch (_outputs[0]["index"]) {
        case 0:
          {
            var selectedQuotes = AngryQuotes();
            var index = math.Random().nextInt(2);
            log("${selectedQuotes.getQuote(index)}");
            Quotes=selectedQuotes.getQuote(index);
            break;
          }
        case 1:
          {
            var selectedQuotes = DisgustQuotes();
            var index = math.Random().nextInt(2);
            log("${selectedQuotes.getQuote(index)}");
            Quotes=selectedQuotes.getQuote(index);
            break;
          }
        case 2:
          {
            var selectedQuotes = FearQuotes();
            var index = math.Random().nextInt(2);
            log("${selectedQuotes.getQuote(index)}");
            Quotes=selectedQuotes.getQuote(index);
            break;
          }
        case 3:
          {
            var selectedQuotes = HappyQuotes();
            var index = math.Random().nextInt(2);
            log("${selectedQuotes.getQuote(index)}");
            Quotes=selectedQuotes.getQuote(index);
            break;
          }
        case 4:
          {
            var selectedQuotes = SadQuotes();
            var index = math.Random().nextInt(2);
            log("${selectedQuotes.getQuote(index)}");
            Quotes=selectedQuotes.getQuote(index);
            break;
          }
        case 5:
          {
            var selectedQuotes = SurpriseQuotes();
            var index = math.Random().nextInt(2);
            log("${selectedQuotes.getQuote(index)}");
            Quotes=selectedQuotes.getQuote(index);
            break;
          }
      }
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
                  StatsRow('Read this one:', '${Quotes}'),
      ])),
    );
  }
}
