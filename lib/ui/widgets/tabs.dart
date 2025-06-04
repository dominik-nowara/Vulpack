import 'package:flutter/material.dart';

class VulpackTabsWidget extends StatefulWidget {
  final List<String> tabs;
  final Function(int)? onTabChanged;

  const VulpackTabsWidget({
    Key? key,
    required this.tabs,
    this.onTabChanged,
  }) : super(key: key);

  @override
  State<VulpackTabsWidget> createState() => _VulpackTabsWidgetState();
}

class _VulpackTabsWidgetState extends State<VulpackTabsWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F7),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: widget.tabs.asMap().entries.map((entry) {
          int index = entry.key;
          String tabText = entry.value;
          bool isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onTabChanged?.call(index);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 20.0,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  color: isSelected 
                    ? const Color(0xFF6B6B7D) 
                    : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  tabText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF2C2C2E),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}