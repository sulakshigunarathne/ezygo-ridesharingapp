import 'package:flutter/material.dart';

class AvailableVehiclesPage extends StatelessWidget {
  final String vehicleType;

  const AvailableVehiclesPage({Key? key, required this.vehicleType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for available vehicles
    final List<Map<String, String>> availableVehicles = [
      {
        "driverName": "John Doe",
        "driverPhoto": "assets/images/john_doe.jpg",
        "passengers": "2",
        "totalCost": "\$10",
      },
      {
        "driverName": "Jane Smith",
        "driverPhoto": "assets/images/jane_smith.jpg",
        "passengers": "1",
        "totalCost": "\$12",
      },
      // Add more vehicles as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Available $vehicleType Vehicles"),
      ),
      body: ListView.builder(
        itemCount: availableVehicles.length,
        itemBuilder: (context, index) {
          final vehicle = availableVehicles[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(vehicle["driverPhoto"]!),
            ),
            title: Text(vehicle["driverName"]!),
            subtitle: Text("Passengers: ${vehicle["passengers"]}"),
            trailing: Text(vehicle["totalCost"]!),
            onTap: () {
              // Handle vehicle selection
            },
          );
        },
      ),
    );
  }
}
