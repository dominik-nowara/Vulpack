class Item {
  final String name;
  final String category;
  final bool cabinApproved;

  Item({
    required this.name,
    required this.category,
    required this.cabinApproved,
  });

  // Factory constructor for creating Item from JSON
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      cabinApproved: json['cabinApproved'] ?? false,
    );
  }

  // Method to convert Item to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'cabinApproved': cabinApproved,
    };
  }

  // Override toString for debugging
  @override
  String toString() {
    return 'Item(name: $name, category: $category, cabinApproved: $cabinApproved)';
  }
}