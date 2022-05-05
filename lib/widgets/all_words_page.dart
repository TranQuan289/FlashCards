import 'package:flash_cards/model/english_today.dart';
import 'package:flutter/material.dart';

class AllWords extends StatelessWidget {
  final List<EnglishToday> words;

  const AllWords({Key? key, required this.words}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Text('jo'),
    ));
  }
}
