import 'package:artitecture/src/core/utils/colors.dart';
import 'package:artitecture/src/presentation/view/main/tab_one.dart';
import 'package:artitecture/src/presentation/view/main/tab_three.dart';
import 'package:artitecture/src/presentation/view/main/tab_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MainPage extends HookWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTabIndex = useState(0);
    final List<Widget> _children = [const TabOne(), const TabTwo(), const TabThree()];

    return Scaffold(
      body: Center(
        child: _children[selectedTabIndex.value]
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
        ],
        onTap: (int index) => selectedTabIndex.value = index,
        currentIndex: selectedTabIndex.value,
        backgroundColor: primaryColor,
      ),
    );
  }
}