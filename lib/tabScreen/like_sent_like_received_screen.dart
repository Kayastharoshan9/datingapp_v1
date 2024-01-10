import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:flutter/material.dart';

class LikeSentLikeReceivedScreen extends StatefulWidget {
  const LikeSentLikeReceivedScreen({super.key});

  @override
  State<LikeSentLikeReceivedScreen> createState() => _LikeSentLikeReceivedScreenState();
}

class _LikeSentLikeReceivedScreenState extends State<LikeSentLikeReceivedScreen>
{
  bool isLikeSentClicked = true;
  List<String> likeSentList = [];
  List<String> likeReceivedList = [];
  List likesList =[];


  getLikedListKeys() async
  {

    if(isLikeSentClicked) {
      var likeSentDocument = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(currentUserID.toString())
          .collection("likeSent")
          .get();
      for (int i = 0; i < likeSentDocument.docs.length; i++)
      {
        likeSentList.add(likeSentDocument.docs[i].id);
      }
      print("likeSentList = " + likesList.toString());
      getKeysDataFromUserCollection(likeSentList);
    }
    else
    {
      var likeReceivedDocument = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(currentUserID.toString())
          .collection("likeReceived")
          .get();

      for(int i=0; i<likeReceivedDocument.docs.length; i++)
      {
        likeReceivedList.add(likeReceivedDocument.docs[i].id);
      }
      print("likeReceivedList = " + likeReceivedList.toString());
      getKeysDataFromUserCollection(likeReceivedList);
    }

  }

  getKeysDataFromUserCollection(List<String> keysList)async
  {
    var allUserDocument = await FirebaseFirestore.instance
        .collection("users")
        .get();
    likesList.clear();

    for (int i = 0; i < allUserDocument.docs.length; i++) {
      for (int k = 0; k < keysList.length; k++) {
        if (((allUserDocument.docs[i].data() as dynamic)["uid"]) ==
            keysList[k]) {
          likesList.add(allUserDocument.docs[i].data());
        }
      }
    }
    setState(() {
      likesList;
    });
    print("likedList = " + likesList.toString());
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLikedListKeys();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: ()
              {
                likeSentList.clear();
                likeSentList =[];
                likeReceivedList.clear();
                likeReceivedList = [];
                likesList.clear();
                likesList = [];

                setState(() {
                  isLikeSentClicked = true;
                });
                getLikedListKeys();
              },
              child: Text(
                "I Like",
                style: TextStyle(
                  color: isLikeSentClicked ? Colors.black : Colors.grey,
                  fontWeight: isLikeSentClicked ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),

            const Text(
              "   |   ",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            TextButton(
              onPressed: ()
              {
                likeSentList.clear();
                likeSentList =[];
                likeReceivedList.clear();
                likeReceivedList = [];
                likesList.clear();
                likesList = [];

                setState(() {
                  isLikeSentClicked = false;
                });
                getLikedListKeys();
              },
              child: Text(
                "Liked Me",
                style: TextStyle(
                  color: isLikeSentClicked ? Colors.grey : Colors.black,
                  fontWeight: isLikeSentClicked ? FontWeight.normal : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
      body: likesList.isEmpty
          ? Center(
        child: Icon(Icons.person_off_sharp, color: Colors.black, size:60,),
      )
          : GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        children: List.generate(likesList.length,(index)
        {
          return GridTile(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                color:Colors.blue.shade200,
                child: GestureDetector(
                  onTap: ()
                  {

                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(likesList[index]["imageProfile"],),
                          fit:BoxFit.cover,
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const Spacer(),

                            Text(
                              likesList[index]["name"].toString() + "  " + likesList[index]["age"].toString(),
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
