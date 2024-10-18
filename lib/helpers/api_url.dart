class ApiUrl {
  static const String baseUrl =
      'http://responsi.webwizards.my.id'; //sesuaikan dengan ip laptop / localhost teman teman / url server Codeigniter

  static const String baseUrlBuku = baseUrl + '/api/buku';
  static const String registrasi = baseUrl + '/api/registrasi';
  static const String login = baseUrl + '/api/login';
  static const String listProduk = baseUrlBuku + '/rating';
  static const String createProduk = baseUrlBuku + '/rating';

  static String updateProduk(int id) {
    return baseUrl + '/rating/' + id.toString() + '/update';
  }

  static String showProduk(int id) {
    return baseUrl + '/rating/' + id.toString();
  }

  static String deleteProduk(int id) {
    return baseUrl + '/rating/' + id.toString() + '/delete';
  }
}
