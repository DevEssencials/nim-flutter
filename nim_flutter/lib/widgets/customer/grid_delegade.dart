import 'package:flutter/material.dart';

SliverGridDelegateWithFixedCrossAxisCount gridDelegate() {
  return const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 7,
    mainAxisExtent: 60.0,
    crossAxisSpacing: 50.0,
    mainAxisSpacing: 15.0,
  );
}
