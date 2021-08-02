import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NuevoScreen extends StatefulWidget{
  
  @override
  _NuevoScreenState createState() => _NuevoScreenState();
}

class _NuevoScreenState extends State<NuevoScreen> {
  
  String fecha = '';
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        fecha ="${selectedDate.year}-${selectedDate.month}-${selectedDate.day}" ;
        print(fecha);
        print(picked.toString());
      }
    );
}


  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Column(
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: Get.width * 0.6,
                decoration: BoxDecoration(
                  color: Color(0xff9DA5AF),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Center(
                  child: Text(fecha, style: TextStyle(color: Colors.white, fontSize: 18))
                )
              ),
              SizedBox(width: 15),
              RaisedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  'Seleccionar',
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                color: Color(0xffDF3E3E),
              ),
            ],
          ),
        ],
      ),
    );
  }
}