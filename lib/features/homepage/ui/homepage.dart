import 'package:cryptx/features/homepage/controller/crypto_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cryptx/features/more_details_page/more_details_page.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/colors.dart';
import '../../../constants/dimensions.dart';

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cryptoProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryBlackColor,
        body: Column(
          children: [
            // Search Bar
            Container(
              margin: EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: kPrimaryWhiteColor),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: kPrimaryWhiteColor),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      color: kPrimaryWhiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.search),
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
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: kGradientColor,
                  ),
                  borderRadius: BorderRadius.circular(16),
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
                    return Center(child: Text('Error: ${state.error}', style: TextStyle(color: Colors.white)));
                  }

                  if (state.data.isEmpty) {
                    return const Center(child: Text('No Data Found', style: TextStyle(color: Colors.white)));
                  }

                  return ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final crypto = state.data[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: _CryptoListItem(crypto: crypto),
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

class _CryptoListItem extends StatelessWidget {
  final dynamic crypto;
  const _CryptoListItem({required this.crypto});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MoreDetailsPage(cryptoId: crypto.id,)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF18171c),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Left section
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.network(
                      crypto.image,
                      width: 32,
                      height: 32,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          crypto.name,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          crypto.symbol.toUpperCase(),
                          style: GoogleFonts.aBeeZee(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Right section
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${crypto.currentPrice.toString()}',
                    style: GoogleFonts.aBeeZee(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
                    style: GoogleFonts.aBeeZee(
                      color: crypto.priceChangePercentage24h >= 0 ? Colors.green : Colors.red,
                      fontSize: 10,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
