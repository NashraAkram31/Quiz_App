import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quizapp/State_Management/get.dart';
import 'package:quizapp/app_view/quiz_home.dart';

class QuizQuestions extends StatefulWidget {
  QuizQuestions({super.key, required this.collectionname});
  String collectionname;

  @override
  State<QuizQuestions> createState() => _QuizQuestionsState();
}

class _QuizQuestionsState extends State<QuizQuestions> {
  Stream<QuerySnapshot> GetQuizQuestion() {
    return FirebaseFirestore.instance
        .collection(widget.collectionname)
        .snapshots();
  }

  Color borderlinescolor = Colors.black;

  @override
  Widget build(BuildContext context) {
    var controllar = Get.put(ScreenController());
    print('Quiz related questions get kiye hen ');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  if (controllar.indexvalue.value > 0) {
                    controllar.decrement();
                  } else {
                    // Navigate to home screen and clear the navigation stack
                    Get.offAll(() => QuizHome());
                  }
                },
                icon: Icon(
                  Iconsax.arrow_circle_left,
                  size: 50,
                ),
              ))
        ],
        title: Text(
          '',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: GetQuizQuestion(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    CircularProgressIndicator()); // Jab tak data load ho raha hai
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}')); // Error handling
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available')); // No data handling
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;

          // Clear previous questions
          controllar.quizquestions.clear();

          // Loop through each document and add to the controller's quiz questions
          documents.forEach((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            controllar.quizquestions.add(data);
          });

          if (controllar.indexvalue.value < controllar.quizquestions.length) {
            return Obx(() {
              return Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(controllar
                                    .quizquestions[controllar.indexvalue.value]
                                ['ImageUrl']),
                          )),
                      Text(
                        'Question: ${controllar.quizquestions[controllar.indexvalue.value]['Question']}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                          onTap: () {
                            controllar.optionBorderColors[0] = Colors.black;
                            controllar.optionBorderColors[1] = Colors.black;
                            controllar.optionBorderColors[2] = Colors.black;
                            if (controllar.quizquestions[
                                    controllar.indexvalue.value]['Option1'] ==
                                controllar.quizquestions[controllar
                                    .indexvalue.value]['CorrectAns']) {
                              controllar.optionBorderColors[0] = controllar
                                  .borderlinescolor.value = Colors.green;
                            } else {
                              controllar.optionBorderColors[0] = controllar
                                  .borderlinescolor.value = Colors.red;
                            }
                          },
                          child: Padding(
                              padding: EdgeInsets.only(left: 0, right: 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color:
                                            controllar.optionBorderColors[0]),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Option1: ${controllar.quizquestions[controllar.indexvalue.value]['Option1']}',
                                      style: TextStyle(fontSize: 18),
                                    )),
                              ))),
                      SizedBox(height: 10),
                      InkWell(
                          onTap: () {
                            controllar.optionBorderColors[0] = Colors.black;
                            controllar.optionBorderColors[1] = Colors.black;
                            controllar.optionBorderColors[2] = Colors.black;
                            if (controllar.quizquestions[
                                    controllar.indexvalue.value]['Option2'] ==
                                controllar.quizquestions[controllar
                                    .indexvalue.value]['CorrectAns']) {
                              controllar.optionBorderColors[1] = controllar
                                  .borderlinescolor.value = Colors.green;
                            } else {
                              controllar.optionBorderColors[1] = controllar
                                  .borderlinescolor.value = Colors.red;
                            }
                          },
                          child: Padding(
                              padding: EdgeInsets.only(left: 0, right: 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color:
                                            controllar.optionBorderColors[1]),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Option2: ${controllar.quizquestions[controllar.indexvalue.value]['Option2']}',
                                      style: TextStyle(fontSize: 18),
                                    )),
                              ))),
                      SizedBox(height: 10),
                      InkWell(
                          onTap: () {
                            controllar.optionBorderColors[0] = Colors.black;
                            controllar.optionBorderColors[1] = Colors.black;
                            controllar.optionBorderColors[2] = Colors.black;
                            if (controllar.quizquestions[
                                    controllar.indexvalue.value]['Option3'] ==
                                controllar.quizquestions[controllar
                                    .indexvalue.value]['CorrectAns']) {
                              controllar.optionBorderColors[2] = controllar
                                  .borderlinescolor.value = Colors.green;
                            } else {
                              controllar.optionBorderColors[2] = controllar
                                  .borderlinescolor.value = Colors.red;
                            }
                          },
                          child: Padding(
                              padding: EdgeInsets.only(left: 0, right: 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color:
                                            controllar.optionBorderColors[2]),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Option3: ${controllar.quizquestions[controllar.indexvalue.value]['Option3']}',
                                      style: TextStyle(fontSize: 18),
                                    )),
                              ))),
                    ],
                  )); // Assuming you have a 'question' field
            });
          } else {
            return Center(
              child: Text(
                'No more questions!',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            );
          }
        },
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          controllar.optionBorderColors[0] = Colors.black;
          controllar.optionBorderColors[1] = Colors.black;
          controllar.optionBorderColors[2] = Colors.black;
          // Increment index only if it is within the range
          if (controllar.indexvalue.value <
              controllar.quizquestions.length - 1) {
            controllar.incrementIndex();
          } else {
            // Optionally reset the index or show a message
            Text("No More Questions");
            controllar.indexvalue.value = 0; // Resets to the first question
            // You can show a message like "Reached end of questions" if needed
          }
        },
        icon: Icon(
          Iconsax.arrow_circle_right,
          size: 50,
        ),
      ),
    );
  }
}
