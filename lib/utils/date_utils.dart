
String validateDate(String value){
  Pattern pattern = r'^([0-3]{0,1}\d{1}\/[0-1]{0,1}\d{1}\/\d{4})$';
  RegExp format = RegExp(pattern);
  if (format.hasMatch(value))
    return null;
  return 'Formato de fecha incorrecto';
}


String dateToFormat(DateTime date) {
  final String formatted = "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  return formatted;
}

String dateToSpanishFormat(DateTime date) {
  final String formatted = "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString().padLeft(4, '0')}";
  return formatted;
}