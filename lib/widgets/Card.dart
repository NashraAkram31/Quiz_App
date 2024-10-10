import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  HomeCard({super.key, required this.image, required this.imagetext});
  String image;
  String imagetext;

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 5, // This creates the raised effect
        borderRadius: BorderRadius.circular(10), // Rounded corners
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                10), // Match the Material widget for rounded corners
            color: Colors.white, // Container background color (raised box)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Turtle image (replace with your own asset)
              Image.asset(
                image,
                width: 60,
                height: 60,
              ),
              SizedBox(height: 10),
              // Category text
              Text(
                imagetext,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ));
  }
}
