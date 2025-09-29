import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoadingCupertino extends StatelessWidget {
  const LoadingCupertino({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        margin: const EdgeInsets.only(top: 30),
        color: Colors.white,
        child: Column(
          children: const <Widget>[
            CupertinoButton(
              child: Text("Muhammad Alif Febriansyah"),
              onPressed: null,
            ),
            CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
