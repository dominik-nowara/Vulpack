import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vulpack/ui/widgets/button.dart';
import 'package:vulpack/ui/widgets/card.dart';
import 'package:vulpack/ui/widgets/checkboxes.dart';
import 'package:vulpack/ui/widgets/datetimepicker.dart';
import 'package:vulpack/ui/widgets/dropdown.dart';
import 'package:vulpack/ui/widgets/input.dart';
import 'package:vulpack/ui/widgets/listitem.dart';
import 'package:vulpack/ui/widgets/switch.dart';
import 'package:vulpack/ui/widgets/tabs.dart';

class DesignsPage extends StatefulWidget {
  const DesignsPage({super.key});

  @override
  State<DesignsPage> createState() => _DesignsPageState();
}

class _DesignsPageState extends State<DesignsPage> {
  // State variables
  bool isChecked = false;
  bool isToggled = false;
  int? selectedId = 0;
  DateTime dateTime = DateTime.now();
  String inputText = '';

  @override
  Widget build(BuildContext context) {
    const String pageTitle = 'Luggage Page';

    return Scaffold(
      appBar: AppBar(
        title: const Text(pageTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Primary buttons
              const Text('Primary Buttons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              VulpackButton(
                text: 'Primary',
                onPressed: () {},
                variant: ButtonVariant.primary,
                buttonStyle: VulpackButtonStyle.filled,
              ),
              const SizedBox(height: 8),
              VulpackButton(
                text: 'Primary',
                onPressed: () {},
                variant: ButtonVariant.primary,
                buttonStyle: VulpackButtonStyle.outlined,
              ),
              const SizedBox(height: 8),
              VulpackButton(
                text: 'Primary',
                onPressed: null, // Disabled
                variant: ButtonVariant.primary,
                buttonStyle: VulpackButtonStyle.filled,
              ),
              const SizedBox(height: 16),
              
              // Secondary buttons
              const Text('Secondary Buttons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              VulpackButton(
                text: 'Secondary',
                onPressed: () {},
                variant: ButtonVariant.secondary,
                buttonStyle: VulpackButtonStyle.filled,
              ),
              const SizedBox(height: 8),
              VulpackButton(
                text: 'Secondary',
                onPressed: () {},
                variant: ButtonVariant.secondary,
                buttonStyle: VulpackButtonStyle.outlined,
              ),
              const SizedBox(height: 8),
              VulpackButton(
                text: 'Secondary',
                onPressed: null, // Disabled
                variant: ButtonVariant.secondary,
                buttonStyle: VulpackButtonStyle.filled,
              ),
              const SizedBox(height: 16),
              
              // Dangerous buttons
              const Text('Dangerous Buttons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              VulpackButton(
                text: 'Dangerous',
                onPressed: () {},
                variant: ButtonVariant.dangerous,
                buttonStyle: VulpackButtonStyle.filled,
              ),
              const SizedBox(height: 8),
              VulpackButton(
                text: 'Dangerous',
                onPressed: () {},
                variant: ButtonVariant.dangerous,
                buttonStyle: VulpackButtonStyle.outlined,
              ),
              const SizedBox(height: 8),
              VulpackButton(
                text: 'Dangerous',
                onPressed: null, // Disabled
                variant: ButtonVariant.dangerous,
                buttonStyle: VulpackButtonStyle.filled,
              ),
              const SizedBox(height: 16),
              
              // Positive buttons
              const Text('Positive Buttons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              VulpackButton(
                text: 'Positive',
                onPressed: () {},
                variant: ButtonVariant.positive,
                buttonStyle: VulpackButtonStyle.filled,
              ),
              const SizedBox(height: 8),
              VulpackButton(
                text: 'Positive',
                onPressed: () {},
                variant: ButtonVariant.positive,
                buttonStyle: VulpackButtonStyle.outlined,
              ),
              const SizedBox(height: 8),
              VulpackButton(
                text: 'Positive',
                onPressed: null, // Disabled
                variant: ButtonVariant.positive,
                buttonStyle: VulpackButtonStyle.filled,
              ),
              const SizedBox(height: 24),

              // Interactive widgets section
              const Text('Interactive Widgets', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // Checkbox
              Row(
                children: [
                  VulpackCheckbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  Text('Checkbox is ${isChecked ? 'checked' : 'unchecked'}'),
                ],
              ),
              const SizedBox(height: 16),

              // Toggle Switch
              Row(
                children: [
                  VulpackToggleSwitch(
                    value: isToggled,
                    onChanged: (value) {
                      setState(() {
                        isToggled = value;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  Text('Switch is ${isToggled ? 'on' : 'off'}'),
                ],
              ),
              const SizedBox(height: 16),

              // Input Field
              VulpackInputField(
                hintText: 'Enter your name',
                onChanged: (value) {
                  setState(() {
                    inputText = value;
                  });
                },
              ),
              if (inputText.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text('You entered: $inputText'),
              ],
              const SizedBox(height: 16),

              // Dropdown
              Row(
                children: [
                  Expanded(
                    child: VulpackDropdown<int>(
                      value: selectedId,
                      items: const [
                        DropdownMenuItem(value: 0, child: Text('Select an item')),
                        DropdownMenuItem(value: 1, child: Text('Item 1')),
                        DropdownMenuItem(value: 2, child: Text('Item 2')),
                        DropdownMenuItem(value: 3, child: Text('Item 3')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedId = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              if (selectedId != null && selectedId != 0) ...[
                const SizedBox(height: 8),
                Text('Selected: Item $selectedId'),
              ],
              const SizedBox(height: 16),

              // Date picker
              VulpackDatePicker(
                selectedDate: dateTime,
                onDateChanged: (date) {
                  setState(() {
                    dateTime = date;
                  });
                },
              ),
              const SizedBox(height: 8),
              Text('Selected date: ${dateTime.day}/${dateTime.month}/${dateTime.year}'),
              const SizedBox(height: 24),

              // Cards section
              const Text('Cards', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              
              VulpackCard(
                title: "Card",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et",
                onTap: () {
                  print("Simple card tapped");
                },
              ),
              const SizedBox(height: 16),
              
              // Short description card
              VulpackCard(
                title: "Card",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, se...",
                onTap: () {
                  print("Short card tapped");
                },
              ),
              const SizedBox(height: 16),
              
              // Card with image
              VulpackCard(
                title: "Card",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed diam nonumy eirmod tempor invidunt",
                imageUrl: "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
                onTap: () {
                  print("Image card tapped");
                },
              ),
              const SizedBox(height: 16),
              
              // Card with date range and image
              VulpackCard(
                title: "Card",
                dateRange: "00/00/00 - 00/00/00",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed diam nonumy eirmod tempor invidunt",
                imageUrl: "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
                onTap: () {
                  print("Date range card tapped");
                },
              ),
              const SizedBox(height: 24),

              // Tabs section
              const Text('Tabs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              
              VulpackTabsWidget(
                tabs: const ['Text 1', 'Text 2'],
                onTabChanged: (index) {
                  print('Tab changed to index: $index');
                },
              ),
              const SizedBox(height: 20),
              // Second tab example (showing different initial state)
              VulpackTabsWidget(
                tabs: const ['Text 1', 'Text 2'],
                onTabChanged: (index) {
                  print('Second tab changed to index: $index');
                },
              ),
              const SizedBox(height: 20),
              // Example with more tabs
              VulpackTabsWidget(
                tabs: const ['Home', 'Profile', 'Settings'],
                onTabChanged: (index) {
                  print('Three-tab widget changed to index: $index');
                },
              ),
              const SizedBox(height: 24),

              // List Item section
              const Text('List Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              
              VulpackListItem(
                spacing: 12.0, // Custom spacing
                children: [
                  const Text(
                    'Title',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text('Description text here'),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Text(' 4.5 rating'),
                    ],
                  ),
                  VulpackButton(
                    text: "Test", 
                    onPressed: () => print("Works"),
                    variant: ButtonVariant.primary,
                    buttonStyle: VulpackButtonStyle.filled,
                  )
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}