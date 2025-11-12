import 'package:cryptx/features/homepage/controller/crypto_data_provider.dart';
import 'package:cryptx/features/homepage/widgets/crypto_list_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/colors.dart';
import '../../../constants/dimensions.dart';

class FavouritePage extends ConsumerWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cryptoProvider);

   final favourites = state.data.where((crypto) => crypto.isFavourite).toList();

    return Scaffold(
      backgroundColor: kPrimaryBlackColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kHorizontalPadding,
                vertical: kVerticalPadding,
              ),
              child: Row(
                children: [
                  Text(
                    'Favourites',
                    style: TextStyle(
                      color: kPrimaryWhiteColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  if (favourites.isNotEmpty)
                    Text(
                      '${favourites.length} ${favourites.length == 1 ? "item" : "items"}',
                      style: TextStyle(
                        color: kPrimaryWhiteColor.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            ),

            // Content
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

                  // Empty state
                  if (favourites.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 100,
                            color: kPrimaryWhiteColor.withOpacity(0.3),
                          ),
                          SizedBox(height: 24),
                          Text(
                            'No Favourites Yet',
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              'Start adding your favourite cryptocurrencies by tapping the heart icon',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kPrimaryWhiteColor.withOpacity(0.6),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // List of favourites
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    itemCount: favourites.length,
                    itemBuilder: (context, index) {
                      final crypto = favourites[index];
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