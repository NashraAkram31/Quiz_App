import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Admin/Add_Quiz.dart';

class AdminLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController passward = TextEditingController();
    Future<void> AdminLogin(String username, String passward) async {
      try {
        DocumentSnapshot admindocument = await FirebaseFirestore.instance
            .collection('Admin')
            .doc('Admininfo')
            .get();
        var AdminData = admindocument.data() as Map<String, dynamic>;
        if (username == AdminData['Name']) {
          if (passward == AdminData['Passward']) {
            Get.to(() => AddQuiz());
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Entered Passward is Wrong")));
          }
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Entered Name is Wrong")));
        }
        print(AdminData);
      } on FirebaseException catch (e) {
        print(e);
      }
    }

    return Scaffold(
        backgroundColor: Color(0xFFF0F0F0), // Custom light color
        // You can set a background color here
        body: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Stack(
            children: [
              // The curved background at the bottom
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 400, // Adjust the height as needed
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                ),
              ),
              // The form container
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 500,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Text(
                            "Let's start with Admin!",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(height: 20),
                      TextField(
                        controller: username,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      TextField(
                        controller: passward,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (username.text.isNotEmpty &&
                              passward.text.isNotEmpty) {
                            await AdminLogin(
                                username.text.trim(), passward.text.trim());
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Enter Field")));
                          }
                        },
                        child: Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
              // Subscribe button
              // Positioned(
              //   bottom: 30,
              //   right: 20,
              //   child: IconButton(
              //     icon: Icon(
              //       Icons.play_circle_outline,
              //       color: Colors.red,
              //       size: 50,
              //     ),
              //     onPressed: () {
              //       // Handle subscribe action
              //     },
              //   ),
              // ),
            ],
          ),
        ));
  }
}
