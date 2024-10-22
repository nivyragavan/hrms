// import 'package:flutter/material.dart';
//
// class MyTabScreen extends StatefulWidget {
//   @override
//   _MyTabScreenState createState() => _MyTabScreenState();
// }
//
// class _MyTabScreenState extends State<MyTabScreen>
//     with SingleTickerProviderStateMixin {
//   TabController? _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tab Bar Demo'),
//         bottom: TabBar(
//           controller: _tabController,
//           onTap: (index) => null,
//           tabs: [
//             GestureDetector(
//               onTap: () => null,
//               child: Tab(text: 'Tab 1'),
//             ),
//             GestureDetector(
//               onTap: () => _onTabTapped(1),
//               child: Tab(text: 'Tab 2'),
//             ),
//             GestureDetector(
//               onTap: () => _onTabTapped(2),
//               child: Tab(text: 'Tab 3'),
//             ),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         physics: NeverScrollableScrollPhysics(),
//         children: [
//           Center(child: Text('Tab 1 Content')),
//           Center(child: Text('Tab 2 Content')),
//           Center(child: Text('Tab 3 Content')),
//         ],
//       ),
//     );
//   }
// }
