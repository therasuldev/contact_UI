import 'package:contact_ui/components/stories.dart';
import 'package:contact_ui/constant/const_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatefulWidget {
  bool isV = true;
  Body({Key? key, required this.isV}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  http.Response? response;

  bool isL = true;
  dynamic data;
  void getJsonData() async {
    var response = await http
        .get(Uri.parse('https://api.github.com/users/repository/followers'));
    setState(() {
      isL = false;
      data = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getJsonData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          child: Container(
            width: size.width,
            height: size.height * .25,
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _avatarAndDisplayName(),
                  _searchAndMoreIcons(),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: size.width,
            height: size.height * .75,
            decoration: _decoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 45),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: textCategory(context, text: 'Stories', color: black),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: isL
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: stories(
                                index: index,
                                username: data[index]['login'],
                                image: data[index]['avatar_url']),
                          ),
                          scrollDirection: Axis.horizontal,
                        ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: textCategory(context, text: 'Chats', color: black),
                ),
                Expanded(
                  child: isL
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (context, i) {
                            return ListTile(
                              title: Text(data[i]['login']),
                              subtitle: Text('Hi  ${data[i]['login']}'),
                              leading: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(data[i]['avatar_url']),
                                  ),
                                ),
                                child: i % 2 == 0
                                    ? Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              height: 12,
                                              width: 12,
                                              decoration: const BoxDecoration(
                                                color: activeColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : null,
                              ),
                              trailing: const Text('just now'),
                            );
                          },
                        ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          child: widget.isV
              ? const SizedBox.shrink()
              : Container(
                  height: size.height * .4,
                  width: size.width * .6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [.5, 1.0],
                      colors: [
                        Color.fromARGB(255, 199, 185, 236),
                        Color.fromARGB(255, 161, 140, 218),
                      ],
                    ),
                  ),
                  child: componentsDialoq(),
                ),
        )
      ],
    );
  }

  Text textCategory(
    BuildContext context, {
    required String text,
    required Color color,
  }) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontSize: 20, fontWeight: FontWeight.bold, color: color),
    );
  }

  Row _searchAndMoreIcons() {
    return Row(children: const [
      Icon(Icons.search, color: white),
      SizedBox(width: 7),
      Icon(Icons.more_vert, color: white)
    ]);
  }

  Row _avatarAndDisplayName() {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/img/musk.jpg'),
            ),
          ),
        ),
        const SizedBox(width: 5),
        textCategory(context, text: 'Celine', color: white)
      ],
    );
  }

  BoxDecoration _decoration() => const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
        color: white,
      );

  ListView componentsDialoq() {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, i) => ListTile(
          iconColor: white,
          textColor: white,
          enabled: true,
          leading: Icon(icons[i]),
          title: Text(title[i], softWrap: true)),
      separatorBuilder: (context, i) => const Divider(
        color: dividerColor,
        height: 2,
        thickness: 1.5,
        indent: 1,
        endIndent: 1,
      ),
      itemCount: icons.length,
    );
  }
}
