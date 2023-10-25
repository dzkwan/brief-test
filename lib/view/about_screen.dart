import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: const Text(
          "Tentang Aplikasi",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onInverseSurface,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Text.rich(
              TextSpan(
                text: "Pada aplikasi ini terdapat tab ",
                children: [
                  TextSpan(
                    text: "REST API",
                    style: TextStyle(color: Colors.red[400]),
                  ),
                  TextSpan(
                      text: " untuk fetch data dari jsonplaceholder, dan tab "),
                  TextSpan(
                    text: "DETEKSI",
                    style: TextStyle(color: Colors.red[400]),
                  ),
                  TextSpan(
                      text:
                          """ untuk mendeteksi alat musik tradisional. Untuk saat ini, aplikasi hanya dapat mendeteksi alat musik tradisional yang terdiri dari:
1. Angklung
2. Bundengan
3. Gambus
4. Gender
5. Hasapi
6. Karinding
7. Kecapi
8. Kendang
9. Kolintang
10. Ogung
11. Rebab
12. Rebana
13. Saluang
14. Sampe
15. Sasando
16. Serunai
17. Taganing
18. Tahuri
19. Tamborin
20. Tifa"""),
                ],
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
