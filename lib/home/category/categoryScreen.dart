import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/components/product_card.dart';
import 'package:decommers/home/product/detailProduct.dart';
import 'package:decommers/components/toast_popup.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;

  const CategoryScreen({
    super.key,
    required this.categoryName,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  static const primaryGreen = Color(0xFF5BC33C);
  RangeValues _currentRangeValues = const RangeValues(50000, 100000);
  bool _isFilterTab = true;
  String _selectedSort = 'Name (A-Z)';
  final List<String> _sortOptions = [
    'Name (A-Z)',
    'Name (Z-A)',
    'Price (High-Low)',
    'Price (Low-High)',
  ];
  final List<Map<String, dynamic>> _subCategories = [
    {'name': 'Semua Sub Kategori', 'checked': false},
    {'name': 'Handphone', 'checked': true},
    {'name': 'Computer', 'checked': false},
    {'name': 'Laptop', 'checked': false},
  ];

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter & Sorting',
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF071221),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Color(0xFF071221)),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Tabs
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setModalState(() => _isFilterTab = true),
                        child: Column(
                          children: [
                            Text(
                              'Filter',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _isFilterTab ? const Color(0xFF071221) : Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 3,
                              width: 30,
                              decoration: BoxDecoration(
                                color: _isFilterTab ? primaryGreen : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      GestureDetector(
                        onTap: () => setModalState(() => _isFilterTab = false),
                        child: Column(
                          children: [
                            Text(
                              'Sorting',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: !_isFilterTab ? const Color(0xFF071221) : Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 3,
                              width: 30,
                              decoration: BoxDecoration(
                                color: !_isFilterTab ? primaryGreen : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 1, color: Color(0xFFF1F1F1)),
                  const SizedBox(height: 25),

                  if (_isFilterTab) ...[
                    Text(
                      'Range Harga',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF071221),
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    RangeSlider(
                      values: _currentRangeValues,
                      min: 0,
                      max: 200000,
                      divisions: 20,
                      activeColor: primaryGreen,
                      inactiveColor: const Color(0xFFE0E0E0),
                      onChanged: (RangeValues values) {
                        setModalState(() {
                          _currentRangeValues = values;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rp ${(_currentRangeValues.start).toInt()}',
                          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        Text(
                          'Rp ${(_currentRangeValues.end).toInt()}',
                          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Sub Categories List
                    Expanded(
                      child: ListView.builder(
                        itemCount: _subCategories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _subCategories[index]['name'],
                                      style: GoogleFonts.outfit(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF071221),
                                      ),
                                    ),
                                    Checkbox(
                                      value: _subCategories[index]['checked'],
                                      activeColor: primaryGreen,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      onChanged: (val) {
                                        setModalState(() {
                                          _subCategories[index]['checked'] = val;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const Divider(color: Color(0xFFF1F1F1)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ] else ...[
                    // Sorting List
                    Expanded(
                      child: ListView.builder(
                        itemCount: _sortOptions.length,
                        itemBuilder: (context, index) {
                          final option = _sortOptions[index];
                          final isSelected = _selectedSort == option;
                          return InkWell(
                            onTap: () {
                              setModalState(() {
                                _selectedSort = option;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        option,
                                        style: GoogleFonts.outfit(
                                          fontSize: 16,
                                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                          color: const Color(0xFF071221),
                                        ),
                                      ),
                                      if (isSelected)
                                        Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: const BoxDecoration(
                                            color: primaryGreen,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  const Divider(color: Color(0xFFF1F1F1), height: 1),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],

                  // Bottom Buttons
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 55,
                          child: OutlinedButton(
                            onPressed: () {
                              ToastPopup.show(
                                context,
                                title: 'Info',
                                message: 'Filter dikembalikan ke pengaturan awal.',
                                type: ToastType.info,
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF071221)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(
                              'Reset',
                              style: GoogleFonts.outfit(color: const Color(0xFF071221), fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: SizedBox(
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ToastPopup.show(
                                context,
                                title: 'Success',
                                message: 'Filter berhasil diterapkan!',
                                type: ToastType.success,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryGreen,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                            ),
                            child: Text(
                              'Apply',
                              style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1A1A1A), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Category',
          style: GoogleFonts.outfit(
            color: const Color(0xFF1A1A1A),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF1A1A1A)),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Text(
              widget.categoryName,
              style: GoogleFonts.outfit(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF071221),
              ),
            ),
          ),

          // Search Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 55,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Product Name',
                      hintStyle: GoogleFonts.outfit(
                        color: Colors.grey[400],
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Icon(Icons.search_rounded, color: Colors.grey[800], size: 24),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // Product Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8, // Adjusted for ProductCard height
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                final products = [
                  {
                    'title': 'TWS Airbuds Pro 2',
                    'price': 'Rp 450.000',
                    'rating': '4.8',
                    'reviews': '124',
                  },
                  {
                    'title': 'Smart Watch Series 7',
                    'price': 'Rp 850.000',
                    'rating': '4.9',
                    'reviews': '89',
                  },
                  {
                    'title': 'Leather Wallet Brown',
                    'price': 'Rp 150.000',
                    'rating': '4.7',
                    'reviews': '210',
                  },
                  {
                    'title': 'Smart Phone Pro',
                    'price': 'Rp 2.000.000',
                    'rating': '4.9',
                    'reviews': '150',
                  },
                  {
                    'title': 'Leather Wallet Brown',
                    'price': 'Rp 150.000',
                    'rating': '4.7',
                    'reviews': '210',
                  },
                  {
                    'title': 'Smart Phone Pro',
                    'price': 'Rp 2.000.000',
                    'rating': '4.9',
                    'reviews': '150',
                  },
                ];
                
                return ProductCard(
                  title: products[index]['title']!,
                  price: products[index]['price']!,
                  rating: products[index]['rating']!,
                  reviews: products[index]['reviews']!,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailProduct())),
                );
              },
            ),
          ),

          // Filter & Sorting Button
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                onPressed: _showFilterModal,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF071221)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Filter & Sorting',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFF071221),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
