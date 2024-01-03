
import 'package:flutter/material.dart';

extension MinHeightContext on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 700 ;
  bool get isDesktop => MediaQuery.of(this).size.width >= 700 ;

}