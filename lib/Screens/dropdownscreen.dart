import 'package:flutter/material.dart';

class griddd extends StatefulWidget {
  const griddd({super.key});

  @override
  State<griddd> createState() => _gridddState();
}

class _gridddState extends State<griddd> {
  int selectedIdx = -1; // Index of the selected item

  List<String> items = List.generate(10, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return

      GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            // Update the selected index
            setState(() {
              selectedIdx = index;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: selectedIdx == index ? Colors.blue : Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                items[index],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
