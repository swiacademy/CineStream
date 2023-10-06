import 'package:flutter/material.dart';

class DescriptionMovie extends StatelessWidget {
  final String? text;
  const DescriptionMovie({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: Theme.of(context)
          .textTheme
          .labelMedium!
          .copyWith(fontWeight: FontWeight.normal),
      textAlign: TextAlign.justify,
    );
  }
}
