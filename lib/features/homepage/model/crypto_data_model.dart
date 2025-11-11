class CryptoDataModel {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double marketCap;
  final int marketCapRank;
  final double? fullyDilutedValuation;
  final double? totalVolume;
  final double high24h;
  final double low24h;
  final double priceChange24h;
  final double priceChangePercentage24h;
  final double? marketCapChange24h;
  final double? marketCapChangePercentage24h;
  final double? circulatingSupply;
  final double? totalSupply;
  final double? maxSupply;
  final double ath;
  final double athChangePercentage;
  final String athDate;
  final double atl;
  final double atlChangePercentage;
  final String atlDate;
  final String? lastUpdated;

  CryptoDataModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    this.fullyDilutedValuation,
    this.totalVolume,
    required this.high24h,
    required this.low24h,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
    this.marketCapChange24h,
    this.marketCapChangePercentage24h,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    this.lastUpdated,
  });

  factory CryptoDataModel.fromJson(Map<String, dynamic> json) {
    return CryptoDataModel(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      currentPrice: (json['current_price'] ?? 0).toDouble(),
      marketCap: (json['market_cap'] ?? 0).toDouble(),
      marketCapRank: json['market_cap_rank'],
      fullyDilutedValuation: json['fully_diluted_valuation']?.toDouble(),
      totalVolume: json['total_volume']?.toDouble(),
      high24h: (json['high_24h'] ?? 0).toDouble(),
      low24h: (json['low_24h'] ?? 0).toDouble(),
      priceChange24h: (json['price_change_24h'] ?? 0).toDouble(),
      priceChangePercentage24h:
      (json['price_change_percentage_24h'] ?? 0).toDouble(),
      marketCapChange24h: json['market_cap_change_24h']?.toDouble(),
      marketCapChangePercentage24h:
      json['market_cap_change_percentage_24h']?.toDouble(),
      circulatingSupply: json['circulating_supply']?.toDouble(),
      totalSupply: json['total_supply']?.toDouble(),
      maxSupply: json['max_supply']?.toDouble(),
      ath: (json['ath'] ?? 0).toDouble(),
      athChangePercentage:
      (json['ath_change_percentage'] ?? 0).toDouble(),
      athDate: json['ath_date'] ?? '',
      atl: (json['atl'] ?? 0).toDouble(),
      atlChangePercentage:
      (json['atl_change_percentage'] ?? 0).toDouble(),
      atlDate: json['atl_date'] ?? '',
      lastUpdated: json['last_updated'],
    );
  }

  static List<CryptoDataModel> listFromJson(List<dynamic> list) {
    return list.map((e) => CryptoDataModel.fromJson(e)).toList();
  }
}
