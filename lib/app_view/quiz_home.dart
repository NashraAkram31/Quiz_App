import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/List/gridview_list.dart';
import 'package:quizapp/app_view/questions.dart';
import 'package:quizapp/constants/Image_String.dart';
import 'package:quizapp/widgets/Card.dart';

class QuizHome extends StatelessWidget {
  QuizHome({super.key});
  List<Map<String, dynamic>> usercategorylist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Fixed top container with profile and quiz information
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft:
                    Radius.circular(20.0), // Bottom left corner circular
                bottomRight:
                    Radius.circular(20.0), // Bottom right corner circular
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 15, right: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 50, // Adjust the size of the avatar
                        backgroundImage: AssetImage(
                          ImageString.profileimage,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Nashra Akram",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 15, right: 20),
                  child: Row(
                    children: [
                      Image.asset(
                        ImageString.quizimage,
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Play Quiz By\nGuessing Image",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // The "Top Quiz Category" title
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              "Top Quiz Category",
              style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Flexible grid view to allow scrolling
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items in a row
                crossAxisSpacing: 10.0, // Horizontal space between items
                mainAxisSpacing: 10.0, // Vertical space between items
                childAspectRatio: 1.0, // Width to height ratio
              ),
              itemCount: Appdata().homegridlist.length, // Total number of items
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    // List<Map<String, dynamic>> QuizQuestion = await GetQuizQues(
                    //   Appdata().homegridlist[index]['Name']);

                    Get.to(() => QuizQuestions(
                          collectionname: Appdata().homegridlist[index]['Name'],
                        ));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: HomeCard(
                      image: Appdata().homegridlist[index]['image'],
                      imagetext: Appdata().homegridlist[index]['Name'],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
