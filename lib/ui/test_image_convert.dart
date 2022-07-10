import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tflite/tflite.dart';

import 'package:object_detection/ui/result_view.dart';



class testImageConvert extends StatefulWidget {
  final String expression;

  const testImageConvert({Key key, this.expression}) : super(key: key);

  @override
  _testImageConvertState createState() => _testImageConvertState();
}

class _testImageConvertState extends State<testImageConvert> {
  String imagePath;
  bool _loading = false;
  List<dynamic> _outputs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    imagePath = widget.expression;
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });

    classifyImage(imagePath);
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_exp.tflite",
      labels: "assets/labels_exp.txt",
    );
  }

  classifyImage(String imagePath) async {
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
      _outputs = output;
      log(_outputs[0]["label"]);
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
                  imagePath == null ? Container() : Image.file(File(imagePath)),
                  SizedBox(
                    height: 20,
                  ),
                  _outputs != null
                      ? Text(
                          '${_outputs[0]["label"]}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            background: Paint()..color = Colors.white,
                          ),
                        )
                      : Container(),
                  RaisedButton(
                    child: Text(
                      'Lanjut',
                      style: GoogleFonts.openSans(),
                    ),
                    onPressed: (){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultView(resultClassification: _outputs[0]["label"],)));
                    },
                    color: Colors.lightGreen,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.grey,
                  ),
                ],
              ),
            ),
    );
  }
}