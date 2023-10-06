import 'package:flutter/material.dart';

class TitleMovie extends StatelessWidget {
  final String? text;
  const TitleMovie({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(fontWeight: FontWeight.bold),
      textAlign: TextAlign.justify,
    );
  }
}
