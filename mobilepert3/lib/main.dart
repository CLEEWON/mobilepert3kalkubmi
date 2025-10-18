import 'package:flutter/material.dart';

void main() {
  runApp(const KalkulatorApp());
}

class KalkulatorApp extends StatelessWidget {
  const KalkulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Kalkulator BMI",
      debugShowCheckedModeBanner: false,
      home: BmiPage(),
    );
  }
}

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  double? _bmiResult;
  String _bmiInterpretation = "Silahkan masukkan data Anda";
  String? _selectedGender; // <-- tambahan: jenis kelamin

  void _calculateBMI() {
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final double heightInCM = double.tryParse(_heightController.text) ?? 0;

    if (weight <= 0 || heightInCM <= 0 || _selectedGender == null) {
      setState(() {
        _bmiResult = null;
        _bmiInterpretation = "Mohon isi semua data dengan benar";
      });
      return;
    }

    setState(() {
      final double heightInM = heightInCM / 100;
      final double bmi = weight / (heightInM * heightInM);
      _bmiResult = bmi;

      // Rumus interpretasi berdasarkan gender
      if (_selectedGender == "Laki-laki") {
        if (bmi < 18.5) {
          _bmiInterpretation = "Kekurangan Berat Badan";
        } else if (bmi < 24.9) {
          _bmiInterpretation = "Berat Badan Ideal";
        } else if (bmi < 29.9) {
          _bmiInterpretation = "Kelebihan Berat Badan";
        } else {
          _bmiInterpretation = "Obesitas";
        }
      } else if (_selectedGender == "Perempuan") {
        if (bmi < 18.0) {
          _bmiInterpretation = "Kekurangan Berat Badan";
        } else if (bmi < 24.0) {
          _bmiInterpretation = "Berat Badan Ideal";
        } else if (bmi < 29.0) {
          _bmiInterpretation = "Kelebihan Berat Badan";
        } else {
          _bmiInterpretation = "Obesitas";
        }
      }
    });
  }

  void _resetFields() {
    setState(() {
      _weightController.clear();
      _heightController.clear();
      _selectedGender = null;
      _bmiResult = null;
      _bmiInterpretation = "Silahkan masukkan data Anda";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalkulator BMI"),
        backgroundColor: Colors.amberAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Pilih jenis kelamin
            const Text(
              "Pilih Jenis Kelamin",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: "Laki-laki",
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                const Text("Laki-laki"),
                const SizedBox(width: 20),
                Radio<String>(
                  value: "Perempuan",
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                const Text("Perempuan"),
              ],
            ),
            const SizedBox(height: 20),

            // Input berat
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Berat Badan (Kg)",
                icon: const Icon(Icons.monitor_weight),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Input tinggi
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Tinggi Badan (Cm)",
                icon: const Icon(Icons.height_sharp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol hitung & reset
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _calculateBMI,
                  child: const Text("Hitung BMI"),
                ),
                ElevatedButton(
                  onPressed: _resetFields,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  child: const Text("Reset"),
                ),
              ],
            ),

            const SizedBox(height: 40),
            const Text(
              "Hasil",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 16),

            // Kotak hasil
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    _bmiResult == null
                        ? "-"
                        : "BMI Anda: ${_bmiResult!.toStringAsFixed(1)}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _bmiInterpretation,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
