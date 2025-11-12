class CryptoDataModel {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double priceChangePercentage24h;
  final bool isFavourite;

  CryptoDataModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.priceChangePercentage24h,
    this.isFavourite = false,
  });

  factory CryptoDataModel.fromJson(Map<String, dynamic> json) {
    return CryptoDataModel(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      currentPrice: (json['current_price'] ?? 0).toDouble(),
      priceChangePercentage24h:
      (json['price_change_percentage_24h'] ?? 0).toDouble(),
      isFavourite: json['is_favourite'] ?? false,
    );
  }

  // Method to toggle favourite status
  CryptoDataModel toggleFavourite() {
    return copyWith(isFavourite: !isFavourite);
  }

  // CopyWith method for immutability
  CryptoDataModel copyWith({
    String? id,
    String? symbol,
    String? name,
    String? image,
    double? currentPrice,
    double? priceChangePercentage24h,
    bool? isFavourite,
  }) {
    return CryptoDataModel(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      image: image ?? this.image,
      currentPrice: currentPrice ?? this.currentPrice,
      priceChangePercentage24h:
      priceChangePercentage24h ?? this.priceChangePercentage24h,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  // Convert to JSON for persistence
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': image,
      'current_price': currentPrice,
      'price_change_percentage_24h': priceChangePercentage24h,
      'is_favourite': isFavourite,
    };
  }

  static List<CryptoDataModel> listFromJson(List<dynamic> list) {
    return list.map((e) => CryptoDataModel.fromJson(e)).toList();
  }
}