import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final Icon icon;
  final TextEditingController controller;
  final String labelText;
  final TextInputType inputType;
  final bool isPassword;
  final double width;
  final String initialValue;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final TextCapitalization textCapitalization;
  final int maxLines;
  final bool enabled;

  CustomTextField({
    this.icon,
    this.initialValue,
    this.controller,
    this.labelText,
    this.inputType,
    this.isPassword,
    this.width,
    this.validator,
    this.onSaved,
    this.maxLines = 1,
    this.textCapitalization,
    this.enabled = true
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 12.0,vertical: 5.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        height: 60.0,
        constraints: BoxConstraints(
          minWidth: size.width *0.25,
          maxWidth: (this.width==null) ? size.width : this.width ,
      ),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: TextFormField(
            style: TextStyle(
              color: Colors.white
            ),
            initialValue: initialValue,
            enabled: this.enabled ,
            controller: controller,
            maxLines: maxLines,
            textCapitalization:(textCapitalization==null) ? TextCapitalization.sentences : textCapitalization,
            keyboardType:(inputType!=null) ? inputType : TextInputType.text,
            obscureText: (isPassword!=null) ? isPassword : false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 5.0),
              errorStyle: TextStyle(
                color: Theme.of(context).errorColor,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              icon: (icon!=null) ? icon :  null,
              labelText: (labelText!=null) ? labelText : '',
              alignLabelWithHint: true,
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),



            ),
            cursorColor: Colors.green,
            onSaved: onSaved,
            validator: (validator!=null) ? validator : null,
          ),
        ),
      ),
    );
  }
}
