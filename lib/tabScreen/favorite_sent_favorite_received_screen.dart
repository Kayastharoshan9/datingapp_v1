import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:flutter/material.dart';

class FavoriteSentFavoriteReceivedScreen extends StatefulWidget {
  const FavoriteSentFavoriteReceivedScreen({super.key});

  @override
  State<FavoriteSentFavoriteReceivedScreen> createState() => _FavoriteSentFavoriteReceivedScreenState();
}

class _FavoriteSentFavoriteReceivedScreenState extends State<FavoriteSentFavoriteReceivedScreen>
{
  bool isFavoriteSentClicked = true;
  List<String> favoriteSentList = [];
  List<String> favoriteReceivedList = [];
  List favoritesList =[];


  getFavoriteListKeys() async
  {

    if(isFavoriteSentClicked) {
      var favoriteSentDocument = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(currentUserID.toString())
          .collection("favoriteSent")
          .get();
      for (int i = 0; i < favoriteSentDocument.docs.length; i++)
      {
        favoriteSentList.add(favoriteSentDocument.docs[i].id);
      }
      print("favoriteSentList = " + favoritesList.toString());
      getKeysDataFromUserCollection(favoriteSentList);
    }
      else
       {
        var favoriteReceivedDocument = await FirebaseFirestore
            .instance
            .collection("users")
            .doc(currentUserID.toString())
            .collection("favoriteReceived")
            .get();

    for(int i=0; i<favoriteReceivedDocument.docs.length; i++)
    {
      favoriteReceivedList.add(favoriteReceivedDocument.docs[i].id);
    }
        print("favoriteReceivedList = " + favoriteReceivedList.toString());
        getKeysDataFromUserCollection(favoriteReceivedList);
    }

  }

  getKeysDataFromUserCollection(List<String> keysList)async
  {
    var allUserDocument = await FirebaseFirestore.instance
        .collection("users")
        .get();
    favoritesList.clear();

    for (int i = 0; i < allUserDocument.docs.length; i++) {
      for (int k = 0; k < keysList.length; k++) {
        if (((allUserDocument.docs[i].data() as dynamic)["uid"]) ==
            keysList[k]) {
          favoritesList.add(allUserDocument.docs[i].data());
        }
      }
    }
      setState(() {
        favoritesList;
      });
      print("favoritesList = " + favoritesList.toString());
    }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavoriteListKeys();
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
                favoriteSentList.clear();
                favoriteSentList =[];
                favoriteReceivedList.clear();
                favoriteReceivedList = [];
                favoritesList.clear();
                favoritesList = [];

                setState(() {
                  isFavoriteSentClicked = true;
                });
                getFavoriteListKeys();
              },
              child: Text(
                "My Favorite",
                    style: TextStyle(
                      color: isFavoriteSentClicked ? Colors.black : Colors.grey,
                      fontWeight: isFavoriteSentClicked ? FontWeight.bold : FontWeight.normal,
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
                favoriteSentList.clear();
                favoriteSentList =[];
                favoriteReceivedList.clear();
                favoriteReceivedList = [];
                favoritesList.clear();
                favoritesList = [];

                setState(() {
                  isFavoriteSentClicked = false;
                });
                getFavoriteListKeys();
              },
              child: Text(
                "I am favorite",
                style: TextStyle(
                  color: isFavoriteSentClicked ? Colors.grey : Colors.black,
                  fontWeight: isFavoriteSentClicked ? FontWeight.normal : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
      body: favoritesList.isEmpty
          ? Center(
        child: Icon(Icons.person_off_sharp, color: Colors.black, size:60,),
      )
          : GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(8),
          children: List.generate(favoritesList.length,(index)
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
                          image: NetworkImage(favoritesList[index]["imageProfile"],),
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
                                favoritesList[index]["name"].toString() + "  " + favoritesList[index]["age"].toString(),
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
