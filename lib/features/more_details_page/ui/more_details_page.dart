import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptx/features/more_details_page/widgets/chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';
import '../../../constants/dimensions.dart';
import '../../../services/internet_checker_stream_provider.dart';
import '../controller/market_chart_controller/market_chart_provider.dart';
import '../controller/market_chart_controller/marrket_chart_state.dart';
import '../controller/more_info_provider.dart';
import '../controller/more_info_state.dart';

class MoreDetailsPage extends ConsumerStatefulWidget {
  final String cryptoId;

  MoreDetailsPage({super.key, required this.cryptoId});

  @override
  ConsumerState<MoreDetailsPage> createState() => _MoreDetailsPageState();
}

class _MoreDetailsPageState extends ConsumerState<MoreDetailsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(moreInfoNotifierProvider.notifier).getMoreInfo(widget.cryptoId);
      // fetch chart data
      ref
          .read(marketChartNotifierProvider.notifier)
          .fetchChart(widget.cryptoId, days: 7);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(moreInfoNotifierProvider);
    final chartState = ref.watch(marketChartNotifierProvider);
    final connection = ref.watch(internetProvider).value ?? false;

    return Scaffold(
      backgroundColor: kPrimaryBlackColor,
      body: Builder(
        builder: (context) {
          if (state is MoreInfoInitial || state is MoreInfoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MoreInfoLoaded) {
            final crypto = state.moreInfoModel;

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kHorizontalPadding,
                  vertical: kVerticalPadding,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Coin Image & Name
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                // ✅ use fetched image
                                Container(
                                  height: 38,
                                  width: 38,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(crypto.image.thumb),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        crypto.name,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        crypto.symbol,
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

                          Expanded(flex: 1, child: SizedBox()),

                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${crypto.currentPriceUsd.toStringAsFixed(2)}',
                                  style: GoogleFonts.aBeeZee(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "USD",
                                  style: GoogleFonts.aBeeZee(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      if (!connection)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.yellow.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.wifi_off, color: Colors.redAccent),
                              SizedBox(width: 8),
                              Text(
                                "You are currently browsing offline",
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            ],
                          ),
                        ),

                      SizedBox(height: 16),

                      SizedBox(
                        height: 200,
                        child: Builder(
                          builder: (_) {
                            if (chartState is MarketChartLoading ||
                                chartState is MarketChartInitial) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (chartState is MarketChartLoaded) {
                              final prices = chartState.chartData.prices
                                  .map((e) => e.value)
                                  .toList();
                              return CryptoLineChart(prices: prices);
                            }

                            if (chartState is MarketChartError) {
                              return Center(child: Text(chartState.message));
                            }

                            return const SizedBox();
                          },
                        ),
                      ),

                      const SizedBox(height: 24),

                      const SizedBox(height: 5),
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: crypto.image.large,
                          placeholder: (context, url) =>
                          const CircularProgressIndicator(strokeWidth: 2),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        )
                      ),

                      const SizedBox(height: 12),

                      // Description Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info,
                            size: 16,
                            color: Color(0xFFfbe1be),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Description",
                                  style: GoogleFonts.poppins(
                                    color: kPrimaryWhiteColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  crypto.description,
                                  style: GoogleFonts.poppins(
                                    color: kPrimaryWhiteColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
                const SizedBox(height: 16),
                Text(
                  'Error loading data\n(Nothing in cache, connect to internet and retry)',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    // Retry fetching data
                    ref
                        .read(moreInfoNotifierProvider.notifier)
                        .getMoreInfo(widget.cryptoId);

                    ref
                        .read(marketChartNotifierProvider.notifier)
                        .fetchChart(widget.cryptoId, days: 7);
                  },
                  icon: Icon(Icons.refresh),
                  label: Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryWhiteColor,
                    foregroundColor: kPrimaryBlackColor,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}