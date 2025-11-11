class MoreInfoModel {
  final String id;
  final String symbol;
  final String name;
  final String? hashingAlgorithm;
  final String description;
  final double currentPriceUsd;
  final CryptoImage image; // new property

  MoreInfoModel({
    required this.id,
    required this.symbol,
    required this.name,
    this.hashingAlgorithm,
    required this.description,
    required this.currentPriceUsd,
    required this.image,
  });

  factory MoreInfoModel.fromJson(Map<String, dynamic> json) {
    return MoreInfoModel(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      hashingAlgorithm: json['hashing_algorithm'],
      description: json['description']['en'] ?? '',
      currentPriceUsd: (json['market_data']['current_price']['usd'] as num).toDouble(),
      image: CryptoImage.fromJson(json['image']), // parse image
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'hashing_algorithm': hashingAlgorithm,
      'description': description,
      'current_price_usd': currentPriceUsd,
      'image': image.toJson(), // serialize image
    };
  }
}

class CryptoImage {
  final String thumb;
  final String small;
  final String large;

  CryptoImage({
    required this.thumb,
    required this.small,
    required this.large,
  });

  factory CryptoImage.fromJson(Map<String, dynamic> json) {
    return CryptoImage(
      thumb: json['thumb'] ?? '',
      small: json['small'] ?? '',
      large: json['large'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'thumb': thumb,
      'small': small,
      'large': large,
    };
  }
}
