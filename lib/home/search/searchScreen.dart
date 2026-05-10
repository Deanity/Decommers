import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/components/product_card.dart';
import 'package:decommers/components/section_header.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  final List<String> _recentSearches = [
    'TMA2 Wireless',
    'Cable',
    'Macbook',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF5BC33C);

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
          'Search',
          style: GoogleFonts.outfit(
            color: const Color(0xFF1A1A1A),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Input Field
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          _isSearching = value.isNotEmpty;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search Product Name',
                        hintStyle: GoogleFonts.outfit(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (_isSearching)
                    GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        setState(() {
                          _isSearching = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 14, color: Colors.white),
                      ),
                    )
                  else
                    Icon(Icons.search_rounded, color: Colors.grey[800], size: 28),
                ],
              ),
            ),

            const SizedBox(height: 10),
            // Terakhir Dicari Section
            if (!_isSearching && _recentSearches.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Terakhir Dicari',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              
              // Recent Search List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _recentSearches.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Row(
                      children: [
                        Icon(Icons.access_time_rounded, color: Colors.grey[400], size: 24),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            _recentSearches[index],
                            style: GoogleFonts.outfit(
                              fontSize: 15,
                              color: const Color(0xFF1A1A1A),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _recentSearches.removeAt(index);
                            });
                          },
                          child: Icon(Icons.close_rounded, color: Colors.grey[800], size: 22),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],

            const SizedBox(height: 30),
            
            // Featured Product Section - Hidden when searching
            if (!_isSearching) ...[
              SectionHeader(
                title: 'Featured Product', 
                onSeeAll: () {}
              ),
              
              // Featured Products Horizontal List
              SizedBox(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: const [
                    ProductCard(
                      title: 'TMA-2 HD Wireless',
                      price: 'Rp. 1.500.000',
                      rating: '4.6',
                      reviews: '86',
                    ),
                    ProductCard(
                      title: 'TMA-2 HD Wireless',
                      price: 'Rp. 1.500.000',
                      rating: '4.6',
                      reviews: '86',
                    ),
                    ProductCard(
                      title: 'TMA-2 HD Wireless',
                      price: 'Rp. 1.500.000',
                      rating: '4.6',
                      reviews: '86',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
            
            // Search Results Placeholder
            if (_isSearching)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Icon(Icons.search_off_rounded, size: 80, color: Colors.grey[300]),
                      const SizedBox(height: 20),
                      Text(
                        'Searching for "${_searchController.text}"...',
                        style: GoogleFonts.outfit(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
