import 'package:cryptx/constants/colors.dart';
import 'package:cryptx/features/more_details_page/more_details_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/dimensions.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryBlackColor,
        body: Container(
          padding: EdgeInsets.symmetric(vertical: kVerticalPadding),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
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

              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: _CryptoListItem(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CryptoListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoreDetailsPage(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tapped:  '),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF18171c),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Left section - Icon and Text
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
                    child: const Icon(
                      Icons.currency_bitcoin,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "crypto.name",
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
                          "crypto.symbol",
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

            // Middle section - Graph icon
            Expanded(flex: 1, child: Center(child: SizedBox())),

            // Right section - Price info
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$34,568.00',
                    style: GoogleFonts.aBeeZee(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '+1.6%', // Shortened to prevent overflow
                          style: GoogleFonts.aBeeZee(
                            color: kPrimaryWhiteColor,
                            fontSize: 10,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
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
