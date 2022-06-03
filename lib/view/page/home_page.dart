import 'package:flutter/material.dart';

import '../components/body_call_history.dart';
import '../components/body_chats.dart';
import '../constant/const_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var _currentIndex = 0;
  bool result = true;
  Animation<double>? _myAnimation;
  AnimationController? _controller;
  PageController? controller;
  final menuStyle = const TextStyle(color: white);
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

  _onTap() async {
    if (result) {
      _controller!.forward();
      await showMenu(
        
        context: context,
        color: backgroundColor,
        position: const RelativeRect.fromLTRB(80.0, 450.0, 190.0, 120),
        items: [
          PopupMenuItem(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                    title: Text('Contact', style: menuStyle),
                    leading: const Icon(Icons.contact_mail, color: white)),
                ListTile(
                    title: Text('Group', style: menuStyle),
                    leading: const Icon(Icons.group, color: white)),
                ListTile(
                    title: Text('Chat', style: menuStyle),
                    leading: const Icon(Icons.chat, color: white)),
                ListTile(
                    title: Text('Call', style: menuStyle),
                    leading: const Icon(Icons.call, color: white)),
              ],
            ),
          ),
        ],
      );
    } else {
      _controller!.reverse();
    }
    result = !result;
  }

  final list = [const BodyChats(), const BodyCallHistory()];

  void _changeIndex(int value) => setState(() => _currentIndex = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          onPageChanged: (value) => _changeIndex(value),
          children: [list.elementAt(_currentIndex)]),
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
