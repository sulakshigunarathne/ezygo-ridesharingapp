import 'package:flutter/material.dart';
import 'package:ezygo/Pages/available_vehicle_list.dart';

class VehicleTypePopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Available Vehicle Types"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text("Car"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AvailableVehiclesPage(vehicleType: "Car")),
              );
            },
          ),
          ListTile(
            title: Text("Bike"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AvailableVehiclesPage(vehicleType: "Bike")),
              );
            },
          ),
          // Add more vehicle types as needed
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Close"),
        ),
      ],
    );
  }
}
