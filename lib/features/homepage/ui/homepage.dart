import 'package:cryptx/features/favourites_page/ui/favourite_page.dart';
import 'package:cryptx/features/homepage/controller/crypto_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/colors.dart';
import '../../../constants/dimensions.dart';
import '../widgets/crypto_list_items.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cryptoProvider);

    // Filter crypto data based on search query
    final filteredData = state.data.where((crypto) {
      if (_searchQuery.isEmpty) return true;

      final query = _searchQuery.toLowerCase();
      final name = crypto.name?.toLowerCase() ?? '';
      final symbol = crypto.symbol?.toLowerCase() ?? '';

      return name.contains(query) || symbol.contains(query);
    }).toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryBlackColor,
        body: Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kHorizontalPadding,
                vertical: kVerticalPadding,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: kPrimaryWhiteColor),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value;
                                });
                              },
                              style: TextStyle(color: kPrimaryWhiteColor),
                              decoration: InputDecoration(
                                hintText: 'Search',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: kPrimaryWhiteColor.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                          if (_searchQuery.isNotEmpty)
                            IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: kPrimaryWhiteColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchQuery = '';
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavouritePage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: kPrimaryWhiteColor),
                      ),
                      child: Icon(
                        Icons.favorite_rounded,
                        color: Color(0xFFbd74a0),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Banner
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/png/bg-line.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(16),

                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: kHorizontalPadding,
                  vertical: kVerticalPadding,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: kGradientColor,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    Text(
                      "Explore all crypto. Designed with flow",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "—Focuses on the aesthetics and seamless navigation.",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // List
            Expanded(
              child: Builder(
                builder: (_) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.error != null) {
                    return Center(
                      child: Text(
                        'Error: ${state.error}',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  if (state.data.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Data Found',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  if (filteredData.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: kPrimaryWhiteColor.withOpacity(0.5),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No results found for "$_searchQuery"',
                            style: TextStyle(color: kPrimaryWhiteColor),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      final crypto = filteredData[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: CryptoListItem(crypto: crypto),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
