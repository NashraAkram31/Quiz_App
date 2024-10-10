import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key});

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  String SetValue = 'ANIMALS';
  List<String> GridList = [
    'ANIMALS',
    'PLACES',
    'FRUITS',
    'OBJECTS',
    'SPORTS',
    'COUNTRIES'
  ];

  File? image;

  Future<void> imagepicker() async {
    final ImagePicker _picker = ImagePicker();

    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path); // State update inside setState
      });
      print("Image selected: ${image!.path}");
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No Image Picked By The User")));
    }
  }

  Future<void> SentDataIntoFirebase(String option1, String option2,
      String option3, String question, String CorrectAns) async {
    print(image);

    try {
      if (image != null &&
          option1.isNotEmpty &&
          option2.isNotEmpty &&
          option3.isNotEmpty &&
          question.isNotEmpty) {
        String ImageId = randomAlphaNumeric(10);

        // Reference to the storage location
        Reference ref =
            FirebaseStorage.instance.ref().child('Quiz_Data').child(ImageId);

        // Upload the image
        await ref.putFile(image!);

        // Fetch the download URL after the upload completes
        String getDownloadURL = await ref.getDownloadURL();
        print("File URL: $getDownloadURL");
        Map<String, dynamic> QuizQuestions = {
          'ID': ImageId,
          'Option1': option1,
          'Option2': option2,
          'Option3': option3,
          'Question': question,
          'ImageUrl': getDownloadURL,
          'CorrectAns': CorrectAns
        };
        await FirebaseFirestore.instance
            .collection(SetValue)
            .add(QuizQuestions);

        // Notify the user that the image was uploaded successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Quiz Are Successfully Added")),
        );
      } else {
        // If no image is selected or any option is missing
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill all fields and select an image")),
        );
      }
    } on FirebaseException catch (e) {
      // Firebase-specific errors (e.g., storage errors)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Firebase Error: ${e.message}")),
      );
      print("Firebase Error: ${e.code} - ${e.message}");
    } catch (e) {
      // General exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An unexpected error occurred: $e")),
      );
      print("Error: $e");
    }
  }

  final _formkey = GlobalKey<FormState>();
  TextEditingController option1 = TextEditingController();
  TextEditingController option2 = TextEditingController();
  TextEditingController option3 = TextEditingController();
  TextEditingController question = TextEditingController();
  TextEditingController correctanswer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Quiz",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              image == null
                  ? Center(
                      child: GestureDetector(
                          onTap: imagepicker, // Use method directly
                          child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black)),
                              child: Icon((Iconsax.camera)))))
                  : Center(
                      child: Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(20),
                          child: GestureDetector(
                              onTap: imagepicker, // Use method directly
                              child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.black)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    ),
                                  ))))),
              const SizedBox(height: 20),
              Form(
                  key: _formkey,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        TextFormField(
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter The Question";
                            }
                            return null;
                          },
                          controller: question,
                          decoration: InputDecoration(
                              labelText: "Question",
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Option 1";
                            }
                            return null;
                          },
                          controller: option1,
                          decoration: InputDecoration(
                              labelText: "Option 1",
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Option 2";
                            }
                            return null;
                          },
                          controller: option2,
                          decoration: InputDecoration(
                              labelText: "Option 2",
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Option 3";
                            }
                            return null;
                          },
                          controller: option3,
                          decoration: InputDecoration(
                              labelText: "Option 3",
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder()),
                        ),
                        //  const SizedBox(height: 20),

                        const SizedBox(height: 20),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Correct Answer";
                            }
                            return null;
                          },
                          controller: correctanswer,
                          decoration: InputDecoration(
                              labelText: "Correct Answer",
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 20),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Choose Category")),
                        Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: DropdownButton<String>(
                                  value: SetValue,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      SetValue = newValue!;
                                    });
                                  },
                                  items: GridList.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(value),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ))),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: FloatingActionButton(
                                onPressed: () async {
                                  await SentDataIntoFirebase(
                                      option1.text.trim(),
                                      option2.text.trim(),
                                      option3.text.trim(),
                                      question.text.trim(),
                                      correctanswer.text.trim());
                                },
                                child: Text("Add Quiz"))),
                      ],
                    ),
                  )),
            ],
          ),
        )));
  }
}
