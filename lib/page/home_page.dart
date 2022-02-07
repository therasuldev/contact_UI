import 'package:contact_ui/components/body_call_history.dart';

import '../components/body_chats.dart';
import '../constant/const_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var _currentIndex = 0;
  bool flag = true;
  Animation<double>? _myAnimation;
  AnimationController? _controller;
  PageController? controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    controller = PageController(initialPage: 0);

    _myAnimation = CurvedAnimation(curve: Curves.linear, parent: _controller!);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void _onTap() {
    if (flag) {
      _controller!.forward();
    } else {
      _controller!.reverse();
    }
    flag = !flag;
    setState(() {});
  }

  void _changeIndex(int value) => setState(() => _currentIndex = value);

  @override
  Widget build(BuildContext context) {
    List list = [BodyChats(isV: flag), BodyCallHistory(isV: flag)];
    return Scaffold(
      body: PageView(
          controller: controller,
          onPageChanged: _changeIndex,
          children: [list[_currentIndex]]),
      floatingActionButton: FloatingActionButton(
        child: AnimatedIcon(
            icon: AnimatedIcons.menu_close, progress: _myAnimation!),
        onPressed: _onTap,
        elevation: 5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _bottomNavigationbar(),
    );
  }

  BottomNavigationBar _bottomNavigationbar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: '')
      ],
      onTap: _changeIndex,
      backgroundColor: white,
    );
  }
}
