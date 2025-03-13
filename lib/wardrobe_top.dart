import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class WardrobeTop extends StatelessWidget {
  const WardrobeTop({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          toolbarHeight: 60,
          backgroundColor: const Color(0xFFC1DB3C),
          bottom: TabBar(
            labelColor: Color(0xE6CC4385),
            labelStyle: GoogleFonts.jacquesFrancois(fontSize: 16, color: Colors.black),
            unselectedLabelStyle: GoogleFonts.jacquesFrancois(fontSize: 16, color: Colors.black),
            dividerColor: Colors.transparent,
            indicatorColor: Color(0xE6CC4385),
            tabs: const [
              Tab(text: 'TOP'),
              Tab(text: 'BOTTOM'),
              Tab(text: 'DRESS'),
              Tab(text: 'FOOTWEAR')
            ],
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: AnimatedRoundedTabbarFilled(),
                ),
                Expanded(
                  child: const TabBarView(
                    children: [
                      Center(child: Text('top page')),
                      Center(child: Text('bottom page')),
                      Center(child: Text('dress page')),
                      Center(child: Text('footwear page')),
                    ],
                  ),
                ),
              ],
            ),
            // Animated Button Positioned at Bottom Right
            Positioned(
              bottom: 20, // Above the bottom navigation bar
              right: 25,  // Right side of the screen
              child: const AnimatedHoverButton(),
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomBar(),
      ),
    );
  }
}

class AnimatedHoverButton extends StatefulWidget {
  const AnimatedHoverButton({super.key});

  @override
  State<AnimatedHoverButton> createState() => _AnimatedHoverButtonState();
}

class _AnimatedHoverButtonState extends State<AnimatedHoverButton> {
  double _padding = 6;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _padding = 0;
        });
      },
      onTapUp: (details) {
        setState(() {
          _padding = 6;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: EdgeInsets.only(bottom: _padding),
        decoration: BoxDecoration(
            color: const Color(0xE6CC4385), borderRadius: BorderRadius.circular(30)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              color: const Color(0xFFEDF9B1), borderRadius: BorderRadius.circular(30)),
          child: Text('ADD CLOTHES',
              style: GoogleFonts.jacquesFrancois(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class TwoDListViewBuilderWidget extends StatelessWidget {
  const TwoDListViewBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Section ${index + 1}',
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 150, // Height for horizontal scrollable area
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10, // Number of horizontal items
                itemBuilder: (context, index) {
                  return Container(
                    width: 120,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(12), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset:
                          const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      'https://images.pexels.com/photos/1553783/pexels-photo-1553783.jpeg?auto=compress&cs=tinysrgb&w=600${index + 1}',
                      fit:
                      BoxFit.cover, // Ensure the image covers the container
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class AnimatedRoundedTabbarFilled extends StatefulWidget {
  final double borderRadius;
  const AnimatedRoundedTabbarFilled({super.key, this.borderRadius = 30});

  @override
  State<AnimatedRoundedTabbarFilled> createState() =>
      _AnimatedRoundedTabbarFilledState();
}

class _AnimatedRoundedTabbarFilledState
    extends State<AnimatedRoundedTabbarFilled> {
  late List<bool> isHoverList = [false, false, false, false, false, false];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Row with 3 options
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0), // Adds padding to the sides
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              return buildTab(index);
            }),
          ),
        ),
        const SizedBox(height: 8), // Space between rows
        // Second Row with 3 options
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0), // Adds padding to the sides
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              return buildTab(index + 3); // Start from the 4th item
            }),
          ),
        ),
      ],
    );
  }

  // A helper method to avoid code repetition
  Widget buildTab(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      onHover: (value) {
        setState(() {
          isHoverList[index] = value;
        });
      },
      child: AnimatedContainer(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: _currentIndex == index || isHoverList[index]
              ? const Color(0xFFEDF9B1)
              : null,
        ),
        child: Text(
          ['T-Shirt', 'Shirt', 'Hoodie', 'Sweater', 'Polo Shirt', 'Other'][index],
          style: GoogleFonts.jacquesFrancois(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}


class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25)));
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(12);

  int _selectedItemPosition = 2;
  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Color(0xE6CC4385);
  Color unselectedColor = Colors.black;

  Gradient selectedGradient =
  const LinearGradient(colors: [Color(0xE6CC4385), Color(0xFFC1DB3C)]);
  Gradient unselectedGradient =
  const LinearGradient(colors: [Color(0xE6CC4385), Colors.black]);

  Color? containerColor;
  List<Color> containerColors = [
    const Color(0xFFC1DB3C),
    const Color(0xFFC1DB3C),
    const Color(0xFFC1DB3C),
    const Color(0xFFC1DB3C),
  ];

  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.color(
      behaviour: snakeBarStyle,
      snakeShape: snakeShape,
      shape: bottomBarShape,
      padding: padding,
      snakeViewColor: selectedColor,
      selectedItemColor:
      snakeShape == SnakeShape.indicator ? selectedColor : null,
      unselectedItemColor: unselectedColor,
      showUnselectedLabels: showUnselectedLabels,
      showSelectedLabels: showSelectedLabels,
      currentIndex: _selectedItemPosition,
      onTap: (index) => setState(() => _selectedItemPosition = index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.checkroom), label: 'Wardrobe'),
        BottomNavigationBarItem(icon: Icon(Icons.accessibility_new), label: 'Generate'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
      ],
      selectedLabelStyle: const TextStyle(fontSize: 14),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
      backgroundColor: const Color(0xFFC1DB3C),
    );
  }

  void _onPageChanged(int page) {
    containerColor = containerColors[page];
    switch (page) {
      case 0:
        setState(() {
          snakeBarStyle = SnakeBarBehaviour.floating;
          snakeShape = SnakeShape.circle;
          padding = const EdgeInsets.all(12);
          bottomBarShape =
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25));
          showSelectedLabels = false;
          showUnselectedLabels = false;
        });
        break;
      case 1:
        setState(() {
          snakeBarStyle = SnakeBarBehaviour.pinned;
          snakeShape = SnakeShape.circle;
          padding = EdgeInsets.zero;
          bottomBarShape = RoundedRectangleBorder(borderRadius: _borderRadius);
          showSelectedLabels = false;
          showUnselectedLabels = false;
        });
        break;

      case 2:
        setState(() {
          snakeBarStyle = SnakeBarBehaviour.pinned;
          snakeShape = SnakeShape.rectangle;
          padding = EdgeInsets.zero;
          bottomBarShape = BeveledRectangleBorder(borderRadius: _borderRadius);
          showSelectedLabels = true;
          showUnselectedLabels = true;
        });
        break;
      case 3:
        setState(() {
          snakeBarStyle = SnakeBarBehaviour.pinned;
          snakeShape = SnakeShape.indicator;
          padding = EdgeInsets.zero;
          bottomBarShape = null;
          showSelectedLabels = false;
          showUnselectedLabels = false;
        });
        break;
    }
  }
}