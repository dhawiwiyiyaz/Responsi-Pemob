import 'package:flutter/material.dart';
import '../bloc/produk_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/produk.dart';
import 'rating_page.dart';

// ignore: must_be_immutable
class ProdukForm extends StatefulWidget {
  Produk? produk;
  ProdukForm({Key? key, this.produk}) : super(key: key);
  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PRODUK";
  String tombolSubmit = "SIMPAN";
  final _average_ratingTextboxController = TextEditingController();
  final _total_reviewsTextboxController = TextEditingController();
  final _best_seller_rankTextboxController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _average_ratingTextboxController.text =
            widget.produk!.average_rating.toString();
        _total_reviewsTextboxController.text =
            widget.produk!.total_reviews.toString();
        _best_seller_rankTextboxController.text =
            widget.produk!.best_seller_rank.toString();
      });
    } else {
      judul = "TAMBAH PRODUK";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _average_ratingTextField(),
                _total_reviewsTextField(),
                _best_seller_rankTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

//Membuat Textbox average rating
  Widget _average_ratingTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "kode produk"),
      keyboardType: TextInputType.number,
      controller: _average_ratingTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Average Rating harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox total reviews
  Widget _total_reviewsTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "nama produk"),
      keyboardType: TextInputType.number,
      controller: _total_reviewsTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Total Reviews harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox best seller rank
  Widget _best_seller_rankTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "harga"),
      keyboardType: TextInputType.number,
      controller: _best_seller_rankTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Best Seller Rank harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
        child:
            _isLoading ? const CircularProgressIndicator() : Text(tombolSubmit),
        onPressed: _isLoading
            ? null
            : () {
                var validate = _formKey.currentState!.validate();
                if (validate) {
                  if (widget.produk != null) {
                    ubah();
                  } else {
                    simpan();
                  }
                }
              });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });

    try {
      Produk createProduk = Produk(id: null);
      createProduk.average_rating =
          int.parse(_average_ratingTextboxController.text);
      createProduk.total_reviews =
          int.parse(_total_reviewsTextboxController.text);
      createProduk.best_seller_rank =
          int.parse(_best_seller_rankTextboxController.text);

      ProdukBloc.addProduk(produk: createProduk).then((value) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const ProdukPage()));
      }, onError: (error) {
        showDialog(
            context: context,
            builder: (BuildContext context) => const WarningDialog(
                  description: "Simpan gagal, silahkan coba lagi",
                ));
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description:
                    "Input tidak valid. Pastikan semua field berisi angka yang benar",
              ));
    }

    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Produk updateProduk = Produk(id: widget.produk!.id!);
    updateProduk.average_rating =
        int.parse(_average_ratingTextboxController.text);
    updateProduk.total_reviews =
        int.parse(_total_reviewsTextboxController.text);
    updateProduk.best_seller_rank =
        int.parse(_best_seller_rankTextboxController.text);
    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ProdukPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
