import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptx/constants/colors.dart';
import 'package:cryptx/features/favourites_page/ui/favourite_page.dart';
import 'package:cryptx/features/homepage/controller/crypto_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../more_details_page/ui/more_details_page.dart';

class CryptoListItem extends ConsumerWidget {
  final dynamic crypto;
  const CryptoListItem({required this.crypto});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: CachedNetworkImage(
                        imageUrl: crypto.image ?? '',
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(strokeWidth: 2),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      )
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
            Row(
              children: [
                Column(
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
                IconButton(
                  icon: Icon(
                    crypto.isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: crypto.isFavourite ?   Color(0xFFbd74a0) : Colors.white,
                  ),
                  onPressed: () {
                    ref.read(cryptoProvider.notifier).toggleFavourite(crypto.id);
                    // navigate to favourite page

                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}