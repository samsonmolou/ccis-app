import 'package:flutter/material.dart';

class SpinnerLoading extends StatelessWidget {
  SpinnerLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}