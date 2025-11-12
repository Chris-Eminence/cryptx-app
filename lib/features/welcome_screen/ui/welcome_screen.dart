import 'package:cryptx/constants/colors.dart';
import 'package:cryptx/constants/dimensions.dart';
import 'package:cryptx/features/homepage/ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../services/internet_checker_stream_provider.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnected = ref.watch(internetProvider);
    return Scaffold(
      backgroundColor: kPrimaryBlackColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: kVerticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Crypt",
                    style: GoogleFonts.poppins(
                      color: kPrimaryWhiteColor,
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "X",
                    style: GoogleFonts.poppins(
                      fontSize: 64,
                      color: kPrimaryPurpleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentGeometry.centerRight,
                child: Image.asset("assets/png/welcome-image.png"),
              ),
              Spacer(),

              Text(
                "Find all your Crypto \nInformation",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  color: kPrimaryWhiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 22),

              Text(
                "All the information you ever need about \na coin in one place",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: kPrimaryWhiteColor,
                ),
              ),
              SizedBox(height: 44),


              GestureDetector(
                onTap: isConnected.hasError ? null : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                },
                child: isConnected.when(data: (connected){
                  if(connected){
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 16),

                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kPrimaryPurpleColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: isConnected.isLoading ? CircularProgressIndicator(color: kPrimaryWhiteColor)  : Text(

                          "Get Started",
                          style: GoogleFonts.poppins(
                            color: kPrimaryWhiteColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }else{
                    return Center(
                      child: Text("Checking for Internet Connection", style: GoogleFonts.poppins(fontSize: 16, color: kPrimaryWhiteColor),),
                    );
                  }
                }, loading: () => Center(child: CircularProgressIndicator(color: kPrimaryWhiteColor,)),
                    error: (_, __) => const Text("Error Occurred"))

              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
