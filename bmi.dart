
import 'package:flutter/material.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  final bbController = TextEditingController();
  final tbController = TextEditingController();

  double? _bmiResult;
  String _keterangan = "Silakan masukkan data Anda";
  String _gender = "Perempuan";

  void _hitung() {
    final double? bb = double.tryParse(bbController.text);
    final double? tb = double.tryParse(tbController.text);

    if (bb == null || tb == null || bb <= 0 || tb <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Masukkan berat dan tinggi badan yang valid!"),
        ),
      );
      return;
    }

    final double tbM = tb / 100;
    final double bmi = bb / (tbM * tbM);

    setState(() {
      _bmiResult = bmi;

      if (bmi < 18.5) {
        _keterangan = "Berat Badan Kurang";
      } else if (bmi < 25) {
        _keterangan = "Berat Badan Ideal";
      } else if (bmi < 30) {
        _keterangan = "Berat Badan Berlebih";
      } else {
        _keterangan = "Obesitas";
      }
    });
  }

  void _reset() {
    bbController.clear();
    tbController.clear();

    setState(() {
      _bmiResult = null;
      _keterangan = "Silakan masukkan data Anda";
      _gender = "Perempuan";
    });
  }

  @override
  void dispose() {
    bbController.dispose();
    tbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      appBar: AppBar(
        title: const Text(
          "Kalkulator BMI",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.favorite,
                size: 65,
                color: Colors.pinkAccent,
              ),
              const SizedBox(height: 10),
              const Text(
                "Cek Indeks Massa Tubuh",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Masukkan data untuk menghitung BMI Anda",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 25),

              // Pilihan jenis kelamin
              Card(
                elevation: 3,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Jenis Kelamin",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ChoiceChip(
                              avatar: const Icon(Icons.male),
                              label: const Text("Laki-laki"),
                              selected: _gender == "Laki-laki",
                              selectedColor: Colors.pink.shade100,
                              onSelected: (selected) {
                                setState(() {
                                  _gender = "Laki-laki";
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ChoiceChip(
                              avatar: const Icon(Icons.female),
                              label: const Text("Perempuan"),
                              selected: _gender == "Perempuan",
                              selectedColor: Colors.pink.shade100,
                              onSelected: (selected) {
                                setState(() {
                                  _gender = "Perempuan";
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Input berat badan
              Card(
                elevation: 3,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: bbController,
                    keyboardType:
                        const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: "Berat Badan (kg)",
                      prefixIcon: const Icon(
                        Icons.monitor_weight,
                        color: Colors.pinkAccent,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Input tinggi badan
              Card(
                elevation: 3,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: tbController,
                    keyboardType:
                        const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: "Tinggi Badan (cm)",
                      prefixIcon: const Icon(
                        Icons.height,
                        color: Colors.pinkAccent,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Tombol Hitung
              ElevatedButton.icon(
                onPressed: _hitung,
                icon: const Icon(Icons.calculate),
                label: const Text("Hitung BMI"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Tombol Reset
              OutlinedButton.icon(
                onPressed: _reset,
                icon: const Icon(Icons.refresh),
                label: const Text("Reset"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.all(14),
                  side: const BorderSide(
                    color: Colors.pinkAccent,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Hasil BMI
              Card(
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                    color: Colors.pinkAccent,
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      const Text(
                        "Hasil Perhitungan BMI",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _bmiResult?.toStringAsFixed(2) ?? "--",
                        style: const TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Jenis Kelamin: $_gender",
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _keterangan,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Catatan: Kategori BMI ini menggunakan "
                "batas standar untuk orang dewasa.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
