
import 'package:flutter/material.dart';

String validateDate(String value){
  Pattern pattern = r'^([0-3]{0,1}\d{1}\/[0-1]{0,1}\d{1}\/\d{4})$';
  RegExp format = RegExp(pattern);
  if (format.hasMatch(value))
    return null;
  return 'Formato de fecha incorrecto';
}