import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/main_widgets/users_show.dart';

import 'dogs_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedItem = 0;
  void onSelectTab(int index) {
    setState(() {
      if (_selectedItem == index) return;
      _selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
        ),
        body: IndexedStack(
          index: _selectedItem,
          children: [Center(child: DogsWidget()), UsersShow()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedItem,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.blueGrey,
              icon: Icon(Icons.api_rounded),
              label: 'Api info',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.verified_user_sharp,
              ),
              label: 'User Info',
            ),
          ],
          onTap: onSelectTab,
        ));
  }
}
