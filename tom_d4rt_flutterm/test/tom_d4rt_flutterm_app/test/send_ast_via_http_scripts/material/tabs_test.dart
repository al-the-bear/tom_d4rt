// D4rt test script: Tests TabBar, TabBarView, DefaultTabController, Tab from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Tab widgets test executing');

  // ========== TAB ==========
  print('--- Tab Tests ---');

  // Test basic Tab with text
  final textTab = Tab(text: 'Home');
  print('Tab with text created');

  // Test Tab with icon
  final iconTab = Tab(icon: Icon(Icons.star));
  print('Tab with icon created');

  // Test Tab with text and icon
  final textIconTab = Tab(icon: Icon(Icons.settings), text: 'Settings');
  print('Tab with text and icon created');

  // Test Tab with iconMargin
  final marginTab = Tab(
    icon: Icon(Icons.person),
    iconMargin: EdgeInsets.only(bottom: 8.0),
    text: 'Profile',
  );
  print('Tab with iconMargin created');

  // Test Tab with height
  final heightTab = Tab(height: 60.0, text: 'Tall Tab');
  print('Tab with height created');

  // Test Tab with child
  final childTab = Tab(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(Icons.notifications), SizedBox(width: 4), Text('Custom')],
    ),
  );
  print('Tab with child created');

  // ========== DEFAULTTABCONTROLLER ==========
  print('--- DefaultTabController Tests ---');

  // Test basic DefaultTabController
  final basicTabController = DefaultTabController(
    length: 3,
    child: Column(
      children: [
        TabBar(
          tabs: [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(child: Text('Content 1')),
              Center(child: Text('Content 2')),
              Center(child: Text('Content 3')),
            ],
          ),
        ),
      ],
    ),
  );
  print('Basic DefaultTabController created');

  // Test DefaultTabController with initialIndex
  final initialIndexController = DefaultTabController(
    length: 3,
    initialIndex: 1,
    child: Column(
      children: [
        TabBar(
          tabs: [
            Tab(text: 'First'),
            Tab(text: 'Second'),
            Tab(text: 'Third'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(child: Text('First content')),
              Center(child: Text('Second content')),
              Center(child: Text('Third content')),
            ],
          ),
        ),
      ],
    ),
  );
  print('DefaultTabController with initialIndex created');

  // Test DefaultTabController with animationDuration
  final durationController = DefaultTabController(
    length: 2,
    animationDuration: Duration(milliseconds: 500),
    child: Column(
      children: [
        TabBar(
          tabs: [
            Tab(text: 'A'),
            Tab(text: 'B'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(child: Text('A content')),
              Center(child: Text('B content')),
            ],
          ),
        ),
      ],
    ),
  );
  print('DefaultTabController with animationDuration created');

  // ========== TABBAR ==========
  print('--- TabBar Tests ---');

  // Test TabBar with icon tabs
  final iconTabs = DefaultTabController(
    length: 4,
    child: Column(
      children: [
        TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.business)),
            Tab(icon: Icon(Icons.school)),
            Tab(icon: Icon(Icons.work)),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(child: Text('Home')),
              Center(child: Text('Business')),
              Center(child: Text('School')),
              Center(child: Text('Work')),
            ],
          ),
        ),
      ],
    ),
  );
  print('TabBar with icon tabs created');

  // Test TabBar with indicatorColor
  final indicatorColorTabs = DefaultTabController(
    length: 2,
    child: Column(
      children: [
        TabBar(
          indicatorColor: Colors.red,
          tabs: [
            Tab(text: 'Red 1'),
            Tab(text: 'Red 2'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(child: Text('Content 1')),
              Center(child: Text('Content 2')),
            ],
          ),
        ),
      ],
    ),
  );
  print('TabBar with indicatorColor created');

  // Test TabBar with indicatorSize
  final indicatorSizeTabs = DefaultTabController(
    length: 2,
    child: Column(
      children: [
        TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(text: 'Label Size'),
            Tab(text: 'Indicator'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(child: Text('Content 1')),
              Center(child: Text('Content 2')),
            ],
          ),
        ),
      ],
    ),
  );
  print('TabBar with indicatorSize created');

  // Test TabBar with indicatorWeight
  final indicatorWeightTabs = DefaultTabController(
    length: 2,
    child: Column(
      children: [
        TabBar(
          indicatorWeight: 4.0,
          tabs: [
            Tab(text: 'Thick'),
            Tab(text: 'Indicator'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(child: Text('Content 1')),
              Center(child: Text('Content 2')),
            ],
          ),
        ),
      ],
    ),
  );
  print('TabBar with indicatorWeight created');

  // Test TabBar with indicatorPadding
  final indicatorPaddingTabs = DefaultTabController(
    length: 2,
    child: Column(
      children: [
        TabBar(
          indicatorPadding: EdgeInsets.symmetric(horizontal: 16.0),
          tabs: [
            Tab(text: 'Padded'),
            Tab(text: 'Indicator'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(child: Text('Content 1')),
              Center(child: Text('Content 2')),
            ],
          ),
        ),
      ],
    ),
  );
  print('TabBar with indicatorPadding created');

  // Test TabBar with custom indicator
  final customIndicatorTabs = DefaultTabController(
    length: 2,
    child: Column(
      children: [
        TabBar(
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.blue.shade100,
          ),
          tabs: [
            Tab(text: 'Custom'),
            Tab(text: 'Box'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(child: Text('Content 1')),
              Center(child: Text('Content 2')),
            ],
          ),
        ),
      ],
    ),
  );
  print('TabBar with custom indicator created');

  // Test TabBar with labelColor
  final labelColorTabs = DefaultTabController(
    length: 2,
    child: Column(
      children: [
        TabBar(
          labelColor: Colors.purple,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: 'Purple'),
            Tab(text: 'Grey'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(child: Text('Content 1')),
              Center(child: Text('Content 2')),
            ],
          ),
        ),
      ],
    ),
  );
  print('TabBar with labelColor created');

  // Test TabBar with labelStyle
  final labelStyleTabs = DefaultTabController(
    length: 2,
    child: Column(
      children: [
        TabBar(
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14.0,
          ),
          tabs: [
            Tab(text: 'Bold'),
            Tab(text: 'Normal'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(child: Text('Content 1')),
              Center(child: Text('Content 2')),
            ],
          ),
        ),
      ],
    ),
  );
  print('TabBar with labelStyle created');

  // Test TabBar with isScrollable
  final scrollableTabs = DefaultTabController(
    length: 6,
    child: Column(
      children: [
        TabBar(
          isScrollable: true,
          tabs: [
            Tab(text: 'First'),
            Tab(text: 'Second'),
            Tab(text: 'Third'),
            Tab(text: 'Fourth'),
            Tab(text: 'Fifth'),
            Tab(text: 'Sixth'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: List.generate(
              6,
              (i) => Center(child: Text('Tab ${i + 1}')),
            ),
          ),
        ),
      ],
    ),
  );
  print('TabBar isScrollable created');

  // Test TabBar with dividerColor
  final dividerTabs = DefaultTabController(
    length: 2,
    child: Column(
      children: [
        TabBar(
          dividerColor: Colors.orange,
          tabs: [
            Tab(text: 'Orange'),
            Tab(text: 'Divider'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(child: Text('Content 1')),
              Center(child: Text('Content 2')),
            ],
          ),
        ),
      ],
    ),
  );
  print('TabBar with dividerColor created');

  // Test TabBar with tabAlignment
  final alignedTabs = DefaultTabController(
    length: 2,
    child: Column(
      children: [
        TabBar(
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          tabs: [
            Tab(text: 'Start'),
            Tab(text: 'Aligned'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(child: Text('Content 1')),
              Center(child: Text('Content 2')),
            ],
          ),
        ),
      ],
    ),
  );
  print('TabBar with tabAlignment created');

  // Test TabBar with onTap
  final onTapTabs = DefaultTabController(
    length: 2,
    child: Column(
      children: [
        TabBar(
          onTap: (int index) {
            print('Tab tapped: $index');
          },
          tabs: [
            Tab(text: 'Tap 1'),
            Tab(text: 'Tap 2'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(child: Text('Content 1')),
              Center(child: Text('Content 2')),
            ],
          ),
        ),
      ],
    ),
  );
  print('TabBar with onTap created');

  // Test TabBar with padding
  final paddedTabs = DefaultTabController(
    length: 2,
    child: Column(
      children: [
        TabBar(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          tabs: [
            Tab(text: 'Padded'),
            Tab(text: 'Tabs'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(child: Text('Content 1')),
              Center(child: Text('Content 2')),
            ],
          ),
        ),
      ],
    ),
  );
  print('TabBar with padding created');

  // Test TabBar.secondary
  final secondaryTabs = DefaultTabController(
    length: 3,
    child: Column(
      children: [
        TabBar.secondary(
          tabs: [
            Tab(text: 'Secondary 1'),
            Tab(text: 'Secondary 2'),
            Tab(text: 'Secondary 3'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(child: Text('Secondary Content 1')),
              Center(child: Text('Secondary Content 2')),
              Center(child: Text('Secondary Content 3')),
            ],
          ),
        ),
      ],
    ),
  );
  print('TabBar.secondary created');

  // ========== TABBARVIEW ==========
  print('--- TabBarView Tests ---');

  // Test TabBarView with physics
  final physicsTabView = DefaultTabController(
    length: 2,
    child: Column(
      children: [
        TabBar(
          tabs: [
            Tab(text: 'Physics'),
            Tab(text: 'Test'),
          ],
        ),
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Center(child: Text('Cannot swipe')),
              Center(child: Text('Only tap')),
            ],
          ),
        ),
      ],
    ),
  );
  print('TabBarView with physics created');

  // Test TabBarView with dragStartBehavior
  final dragTabView = DefaultTabController(
    length: 2,
    child: Column(
      children: [
        TabBar(
          tabs: [
            Tab(text: 'Drag'),
            Tab(text: 'Start'),
          ],
        ),
        Expanded(
          child: TabBarView(
            dragStartBehavior: DragStartBehavior.down,
            children: [
              Center(child: Text('Content 1')),
              Center(child: Text('Content 2')),
            ],
          ),
        ),
      ],
    ),
  );
  print('TabBarView with dragStartBehavior created');

  // Test TabBarView with clipBehavior
  final clipTabView = DefaultTabController(
    length: 2,
    child: Column(
      children: [
        TabBar(
          tabs: [
            Tab(text: 'Clip'),
            Tab(text: 'Behavior'),
          ],
        ),
        Expanded(
          child: TabBarView(
            clipBehavior: Clip.antiAlias,
            children: [
              Center(child: Text('Content 1')),
              Center(child: Text('Content 2')),
            ],
          ),
        ),
      ],
    ),
  );
  print('TabBarView with clipBehavior created');

  print('Tab widgets test completed');

  return DefaultTabController(
    length: 4,
    child: Scaffold(
      appBar: AppBar(
        title: Text('Tab Widgets Test'),
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home), text: 'Basic'),
            Tab(icon: Icon(Icons.style), text: 'Styled'),
            Tab(icon: Icon(Icons.list), text: 'Scrollable'),
            Tab(icon: Icon(Icons.more), text: 'Secondary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Basic tab content
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Basic Tab Example',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 100),
                SizedBox(height: 300, child: basicTabController),
              ],
            ),
          ),
          // Styled tab content
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Styled Tabs',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 100),
                SizedBox(height: 300, child: customIndicatorTabs),
              ],
            ),
          ),
          // Scrollable tab content
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scrollable Tabs',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 100),
                SizedBox(height: 300, child: scrollableTabs),
              ],
            ),
          ),
          // Secondary tab content
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secondary Tabs',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 100),
                SizedBox(height: 300, child: secondaryTabs),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
