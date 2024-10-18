class Produk {
  int? id;
  int? average_rating;
  int? total_reviews;
  int? best_seller_rank;
  Produk({this.id, this.average_rating, this.total_reviews, this.best_seller_rank});
  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
        id: obj['id'],
        average_rating: obj['average_rating'],
        total_reviews
    : obj['total_reviews'],
        best_seller_rank
    : obj['best_seller_rank']);
  }
}
