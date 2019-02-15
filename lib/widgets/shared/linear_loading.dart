import 'package:flutter/material.dart';

class LinearLoading extends StatelessWidget {
  LinearLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LinearProgressIndicator(),
    );
  }
}