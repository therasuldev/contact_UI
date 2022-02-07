import '../constant/const_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BodyCallHistory extends StatefulWidget {
  bool isV = true;
  BodyCallHistory({Key? key, required this.isV}) : super(key: key);

  @override
  _BodyCallHistoryState createState() => _BodyCallHistoryState();
}

class _BodyCallHistoryState extends State<BodyCallHistory> {
  List<String> items = <String>['1', '2', '3', '4', '5'];

  void _reverse() {
    setState(() {
      items = items.reversed.toList();
    });
  }

  http.Response? response;

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
                  textCategory(context, color: white, text: 'Call Log'),
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
                  child: textCategory(context, text: 'Today', color: black),
                ),
                const SizedBox(height: 10),
                Expanded(
                    child: ListView.custom(
                  physics: const BouncingScrollPhysics(),
                  childrenDelegate: SliverChildBuilderDelegate(
                    (BuildContext context, index) {
                      return index % 3 == 0 && index != 0
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: textCategory(context,
                                  color: black,
                                  text: 'September ${index + 2}, 2021'),
                            )
                          : ListTile(
                              title: const Text('Aysun'),
                              subtitle: const Text('07:14PM'),
                              leading: Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/img/musk.jpg'),
                                  ),
                                ),
                              ),
                              trailing: index % 2 == 0
                                  ? const Icon(Icons.video_call,
                                      color: activeColor)
                                  : const Icon(Icons.call, color: red));
                    },
                    childCount: 12,
                  ),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  scrollDirection: Axis.vertical,
                ))
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
          .copyWith(fontSize: 20, color: color),
    );
  }

  Row _searchAndMoreIcons() {
    return Row(children: const [
      Icon(Icons.search, color: white),
      SizedBox(width: 7),
      Icon(Icons.more_vert, color: white)
    ]);
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
