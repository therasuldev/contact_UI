
import '../components/body.dart';
import '../constant/const_list.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var _currentIndex = 0;
  bool _flag = true;

  Animation<double>? _myAnimation;
  AnimationController? _controller;

 

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _myAnimation = CurvedAnimation(curve: Curves.linear, parent: _controller!);
  }

  void _onTap() {
    if (_flag) {
      _controller!.forward();
    } else {
      _controller!.reverse();
    }
    _flag = !_flag;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body:  Body(isV: _flag),
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
      backgroundColor:white,
    );
  }



  void _changeIndex(int value) => setState(() => _currentIndex = value);
}
