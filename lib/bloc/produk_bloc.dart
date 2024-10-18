import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/produk.dart';

class ProdukBloc {
  static Future<List<Produk>> getProduks() async {
    String apiUrl = ApiUrl.listProduk;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
    List<Produk> produks = [];
    for (int i = 0; i < listProduk.length; i++) {
      produks.add(Produk.fromJson(listProduk[i]));
    }
    return produks;
  }

  static Future addProduk({Produk? produk}) async {
  String apiUrl = ApiUrl.createProduk;

  // Sesuaikan nama field dengan API
  var body = {
    "average_rating": produk!.average_rating.toString(),
    "total_reviews": produk.total_reviews.toString(),
    "best_seller_rank": produk.best_seller_rank.toString()
  };

  try {
    print("Sending data to API: $body"); // Untuk debug
    var response = await Api().post(apiUrl, body);
    print("API Response: ${response.body}"); // Untuk debug
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  } catch (e) {
    print("Error in addProduk: $e"); // Untuk debug
    throw e; // Re-throw error untuk ditangkap di UI
  }
}

  static Future updateProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.updateProduk(produk.id!);
    print(apiUrl);

    var body = {
      "kode_produk": produk.average_rating,
      "nama_produk": produk.total_reviews,
      "harga": produk.best_seller_rank
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteProduk({int? id}) async {
    String apiUrl = ApiUrl.deleteProduk(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
