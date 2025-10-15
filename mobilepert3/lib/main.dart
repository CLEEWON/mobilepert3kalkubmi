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

  void _calculateBMI() {
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final double heightInCM = double.tryParse(_heightController.text) ?? 0;

    if (weight <= 0 || heightInCM <= 0) {
      setState(() {
        _bmiResult = null;
        _bmiInterpretation = "Data tidak valid";
      });
      return;
    }

    setState(() {
      final double heightInM = heightInCM / 100;
      final double bmi = weight / (heightInM * heightInM);
      _bmiResult = bmi;

      if (bmi < 18.5) {
        _bmiInterpretation = "Kekurangan Berat Badan";
      } else if (bmi < 25) {
        _bmiInterpretation = "Berat Badan Ideal";
      } else if (bmi < 30) {
        _bmiInterpretation = "Kelebihan Berat Badan";
      } else {
        _bmiInterpretation = "Obesitas";
      }
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
            ElevatedButton(
              onPressed: _calculateBMI,
              child: const Text("Hitung BMI"),
            ),
            const SizedBox(height: 40),
            const Text(
              "Hasil",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 16),
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
