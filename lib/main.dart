import 'dart:convert';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:task/userModel.dart';
import 'Updater.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Updater()),
    ],
    child: Consumer<Updater>(
        builder: (context, provider, child) => const MaterialApp(
              home: Test(),
            )),
  ));
}

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

enum BottomIcons { Home, Favorite, Search, Account }

class _TestState extends State<Test> {
  getData() async {
    var res = await http.get(Uri.parse("https://gorest.co.in/public/v1/users"));
    print(res.statusCode.toString());
    if (res.statusCode == 200) {
      log(res.body);
      Provider.of<Updater>(context, listen: false)
          .getData(UserModel.fromJson(json.decode(res.body)));
    }
  }

  int _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  UserModel? data;
  @override
  Widget build(BuildContext context) {
    data = Provider.of<Updater>(context, listen: true).model;
    return Scaffold(
      backgroundColor: Color(0xfff9d7e6),
      body: data != null
          ? Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          height: MediaQuery.of(context).size.height / 2,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          "https://m.media-amazon.com/images/I/81KkA4bASoL._SS500_.jpg",
                                          height: 150,
                                          width: 150,
                                        )),
                                  )),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Rohit Saini",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text("Jaipur , India",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text.rich(TextSpan(
                                  text: "Religion: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                        text: "Hindu",
                                        style: TextStyle(
                                            color: Color(0xffda2a78),
                                            fontWeight: FontWeight.bold))
                                  ])),
                              const SizedBox(
                                height: 15,
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xffda2a78)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)))),
                                  onPressed: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 6),
                                    child: Text(
                                      "My Visitors",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Expanded(
                          //flex: 0,
                          child: Container(
                            margin: const EdgeInsets.only(top: 30),
                            height: MediaQuery.of(context).size.height / 2,
                            child: CarouselSlider(
                                items: data?.data
                                    .map((e) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.network(
                                                        "https://m.media-amazon.com/images/I/81KkA4bASoL._SS500_.jpg",
                                                        height: 150,
                                                        width: 150,
                                                      )),
                                                )),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    e.name,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(e.email,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text.rich(TextSpan(
                                                      text: "Gender: ",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: [
                                                        TextSpan(
                                                            text: e.gender,
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xffda2a78),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))
                                                      ])),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 22.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffda2a78),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13)),
                                                    child: IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        CupertinoIcons.heart,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffda2a78),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13)),
                                                    child: IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        Icons.message,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffda2a78),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13)),
                                                    child: IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        Icons.arrow_downward,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ))
                                    .toList(),
                                options: CarouselOptions(
                                    viewportFraction: 1,
                                    enableInfiniteScroll: false,
                                    scrollDirection: Axis.vertical)),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 280.0, left: 10),
                      child: Icon(
                        CupertinoIcons.heart_solid,
                        size: 80,
                        color: const Color(0xffda2a78),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 280.0, left: 10),
                      child: const Text(
                        "70%",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: BottomNavyBar(
          showElevation: false,
          backgroundColor: Colors.transparent,
          selectedIndex: _selectedIndex,
          items: [
            BottomNavyBarItem(
                inactiveColor: Color(0xffededed),
                activeColor: Color(0xffda2a78),
                textAlign: TextAlign.center,
                icon: Icon(Icons.home_outlined),
                title: Text("Home")),
            BottomNavyBarItem(
                textAlign: TextAlign.center,
                inactiveColor: Color(0xffededed),
                activeColor: Color(0xffda2a78),
                icon: Icon(Icons.message),
                title: Text("Chat")),
            BottomNavyBarItem(
                textAlign: TextAlign.center,
                inactiveColor: Color(0xffededed),
                activeColor: Color(0xffda2a78),
                icon: Icon(Icons.email_outlined),
                title: Text("Message")),
            BottomNavyBarItem(
                textAlign: TextAlign.center,
                inactiveColor: Color(0xffededed),
                activeColor: Color(0xffda2a78),
                icon: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CircleAvatar(
                        radius: 15,
                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQEZrATmgHOi5ls0YCCQBTkocia_atSw0X-Q&usqp=CAU",
                          fit: BoxFit.fill,
                        ))),
                title: Text("Profile")),
          ],
          onItemSelected: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
