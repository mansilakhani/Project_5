import 'package:flutter/material.dart';
import 'package:sky_scrapper_randomuser_data/screens/randomuser_class.dart';

class Details extends StatelessWidget {
  final User user;
  final int index;

  Details(this.user, this.index);
  Widget _spacing(BuildContext context) {
    final responsive = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: responsive * 0.01,
            width: 500.0,
          ),
        )
      ],
    );
  }

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
    final double responsive = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          "${user.first} ${user.last}",
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  padding: EdgeInsets.only(top: responsive * 0.15),
                  child: Card(
                    elevation: 5,
                    color: Colors.white.withOpacity(0.9),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: responsive * 0.15, bottom: responsive * 0.05),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "${user.first} ${user.last}",
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                          _spacing(context),
                          Text(
                            user.email,
                            style: TextStyle(color: Colors.green.shade300),
                          ),
                          _spacing(context),
                          Text(user.phone),
                          _spacing(context),
                          Text(
                            user.dob.split("T")[0],
                          ),
                          _spacing(context),
                          _spacing(context),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(
                                  "assets/icons/facebook_logo (1).png",
                                  width: 30.0,
                                ),
                              ),
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(
                                  "assets/icons/instagram_logo.png",
                                  width: 30.0,
                                ),
                              ),
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(
                                  "assets/icons/website_logo.png",
                                  width: 30.0,
                                ),
                              ),
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(
                                  "assets/icons/linkedin_logo.png",
                                  width: 30.0,
                                ),
                              ),
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(
                                  "assets/icons/twitter_logo.png",
                                  width: 30.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 10.0,
                shape: const CircleBorder(),
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: responsive * 0.02),
                  child: Center(
                    child: Hero(
                      tag: "image$index",
                      child: CircleAvatar(
                        radius: 100.0,
                        backgroundImage: NetworkImage(user.pictureLarge),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: responsive * 0.2,
                    left: MediaQuery.of(context).size.width * 0.85),
                child: Image.asset(
                  menOrWomen(user.gender),
                  height: 20,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
