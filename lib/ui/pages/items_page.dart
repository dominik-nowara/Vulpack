import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vulpack/ui/pages/widgets.dart';
import 'package:vulpack/ui/pages/theme/app_colors.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> clothingItems = [
    '🧦 Socks',
    '👕 T-Shirt',
    '👖 Jeans',
    '🧥 Jacket',
    '🧢 Cap',
    '👗 Dress',
    '👚 Blouse',
    '🧤 Gloves',
    '🥿 Flats',
    '🥾 Boots',
    '🩳 Shorts',
    '🧣 Scarf',
    '👟 Sneakers',
  ];

  final List<String> cosmeticItems = [
    '🧴 Shampoo',
    '🪒 Razor',
    '🧼 Soap',
    '🪥 Toothbrush',
    '🧽 Sponge',
    '💄 Lipstick',
    '🧴 Lotion',
    '🧻 Tissues',
  ];

  // Custom Items Lists
  final List<String> customClothingItems = [
    '🧸 Cuddly Toy',
    '🧩 Puzzle',
    '🎨 Art Supplies',

  ];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.background,
    appBar: const CustomAppBarWithAdd(
      title: 'Items',
      addButtonRoute: '/create-items',
    ),
    body: Column(
      children: [
        const SizedBox(height: 10),
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildStandardItemListView(),
              _buildCustomItemListView(),
            ],
          ),
        ),
      ],
    ),
  );
}
  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF1EEF5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFFB5AFC3),
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        tabs: const [
          Tab(text: 'Standard'),
          Tab(text: 'Custom'),
        ],
      ),
    );
  }

  Widget _buildStandardItemListView() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      children: [
        _buildSectionTitle('Clothing'),
        ...clothingItems.map(_buildItemCard).toList(),
        const SizedBox(height: 16),
        _buildSectionTitle('Cosmetics'),
        ...cosmeticItems.map(_buildItemCard).toList(),
      ],
    );
  }

  Widget _buildCustomItemListView() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      children: [
        _buildSectionTitle('Custom'),
        ...customClothingItems.map(_buildItemCard).toList(),
        const SizedBox(height: 16),

      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildItemCard(String label) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}