import 'package:cryptx/features/homepage/controller/crypto_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/colors.dart';
import '../../../constants/dimensions.dart';
import '../widgets/crypto_list_items.dart';

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


