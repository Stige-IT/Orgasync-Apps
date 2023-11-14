
import 'package:flutter/material.dart';

extension ThemeOfContext on BuildContext {
  ThemeData get theme => Theme.of(this);
}