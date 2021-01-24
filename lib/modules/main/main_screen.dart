import 'package:flutter/material.dart';
import 'package:room/modules/chat/chat_screen.dart';
import 'package:room/modules/settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTabWidget(
              text: 'Chat',
              index: 0,
            ),
            const SizedBox(width: 20.0),
            _buildTabWidget(
              text: 'Profile',
              index: 1,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ChatScreen(),
          SettingsScreen(),
        ],
      ),
    );
  }

  Widget _buildTabWidget({String text, int index}) {
    Color tabColor = _tabController.index == index
        ? Colors.black87
        : Colors.black87.withOpacity(0.4);
    return GestureDetector(
      onTap: () => _onTabTap(index),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color: tabColor,
            ),
          ),
          Container(
            width: 32.0,
            height: 5.0,
            color: tabColor,
          ),
        ],
      ),
    );
  }

  void _onTabTap(int index) {
    _tabController.animateTo(index, duration: Duration(milliseconds: 400));
    setState(() {});
  }
}
