import 'package:flutter/material.dart';
import 'package:ingemec/models/vehicle_model.dart';
import 'package:ingemec/services/vehicle_service.dart';

class VehicleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Vehicle>>(
        future: VehicleService.instance.getVehicles(),
        builder: (_,snapshot){
          if (snapshot.hasData){
            print(snapshot.data.length);
            return Container();

          }
          else
            return Center(child: CircularProgressIndicator.adaptive(),);
        },
      ),
    );
  }
}
