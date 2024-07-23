import 'package:ezygo/Pages/rider_page.dart';
import 'package:flutter/material.dart';
import 'package:ezygo/Widgets/rolecard_widget.dart';

class RolePage extends StatefulWidget {
  const RolePage({super.key});

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: height * 0.3,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100), // Adjust the radius for circular shape
                        child: Image.asset(
                          "assets/images/EZY-GO-Logo.jpeg",
                          scale: 2,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 0), // Reduced padding between image and text
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Choose your Role",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      print('Rider role card tapped'); // Debug print
                      // Handle customer role tap
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const LoginPage()),
                      // );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RoleCard(
                            icon: Icons.person,
                            title: 'Rider',
                            description: 'Find a ride',
                            cardColor: Colors.blue,
                            onTap: () {
                              // Navigate to Rider Screen
                              print('Navigating to RiderPage');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const RiderPage()),
                              );
                            },
                          ),
                          RoleCard(
                            icon: Icons.drive_eta,
                            title: 'Driver',
                            description: 'Offer a ride',
                            cardColor: Colors.blueGrey,
                            onTap: () {
                              // Navigate to Driver Screen
                            },
                          ),
                          RoleCard(
                            icon: Icons.local_shipping,
                            title: 'Delivery Provider',
                            description: 'Deliver a package',
                            cardColor: Colors.green,
                            onTap: () {
                              // Navigate to Delivery Provider Screen
                            },
                          ),
                          RoleCard(
                            icon: Icons.delivery_dining,
                            title: 'Delivery Receiver',
                            description: 'Receive or send a package',
                            cardColor: Colors.black,
                            onTap: () {
                              // Navigate to Delivery Receiver Screen
                            },
                          ),
                        ],
                      ),
              //         child: const Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Row(
              //               children: [
              //                 Icon(Icons.person, size: 30, color: Colors.blue),
              //                 SizedBox(width: 10),
              //                 Text(
              //                   "Continue as a Customer",
              //                   style: TextStyle(
              //                       fontSize: 18, color: Colors.black),
              //                 ),
              //               ],
              //             ),
              //             Icon(Icons.arrow_forward, color: Colors.blue),
              //           ],
              //         ),
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         // Handle driver role tap
              //       },
              //       child: Container(
              //         margin: const EdgeInsets.symmetric(vertical: 10),
              //         padding: const EdgeInsets.all(20),
              //         decoration: BoxDecoration(
              //           color: Colors.grey[200],
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         child: const Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Row(
              //               children: [
              //                 Icon(Icons.local_taxi, size: 30, color: Colors.black),
              //                 SizedBox(width: 10),
              //                 Text(
              //                   "Continue as a Driver",
              //                   style: TextStyle(
              //                       fontSize: 18, color: Colors.black),
              //                 ),
              //               ],
              //             ),
              //             Icon(Icons.arrow_forward, color: Colors.black),
              //           ],
              //         ),
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         // Handle delivery role tap
              //       },
              //       child: Container(
              //         margin: const EdgeInsets.symmetric(vertical: 10),
              //         padding: const EdgeInsets.all(20),
              //         decoration: BoxDecoration(
              //           color: Colors.green[50],
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         child: const Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Row(
              //               children: [
              //                 Icon(Icons.delivery_dining, size: 30, color: Colors.green),
              //                 SizedBox(width: 10),
              //                 Text(
              //                   "Continue as a Delivery",
              //                   style: TextStyle(
              //                       fontSize: 18, color: Colors.black),
              //                 ),
              //               ],
              //             ),
              //             Icon(Icons.arrow_forward, color: Colors.green),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // // Positioned(
              // //   top: 40,
              // //   right: 20,
              // //   child: Image.asset(
              // //     "assets/images/EzyGO-icon.png",
              // //     scale: 1.5,
              ),
              ),
           ],
         ),
                    ),
                  ),
                ],
              ),
    ]),
    ),
   ));
  }
}
