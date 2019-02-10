import 'package:flutter/material.dart';

class LoadingLinear extends StatelessWidget {
  LoadingLinear({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LinearProgressIndicator(),
    );
  }
}