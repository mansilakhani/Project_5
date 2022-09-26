import 'package:flutter/material.dart';
import 'package:sky_scrapper_randomuser_data/helpers/userdetails_helpers.dart';
import 'package:sky_scrapper_randomuser_data/screens/userDetailpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String menOrWomen(gender) {
    String imageUrl = "";
    if (gender == "male") {
      imageUrl = "assets/images/male_.png";
    } else {
      imageUrl = "assets/images/female_.png";
    }
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          "Random Users",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        //centerTitle: true,
      ),
      body: FutureBuilder(
        future: APIHelper.apiHelper.fetchUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Hero(
                          tag: "$i",
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data![i].pictureSmall),
                          ),
                        ),
                        trailing: SizedBox(
                          height: 20,
                          child: Image.asset(
                            menOrWomen(snapshot.data![i].gender),
                          ),
                        ),
                        subtitle: Text(snapshot.data![i].email),
                        title: Text(
                          "${snapshot.data![i].first}   ${snapshot.data![i].last}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Details(
                          //               user: snapshot.data![i],
                          //               index: i,
                          //             )));

                          ///
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Details((snapshot.data![i]), i)),
                          );
                        },
                      ),
                    ),
                  );
                });
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.refresh),
      // ),
    );
  }
}
