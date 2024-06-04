import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  void _openWebView(String url) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          Scaffold(
            appBar: AppBar(title: Text('Web Görünümü')),
            body: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(url)),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                ),
              ),
            ),
          ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),

        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            GestureDetector(
              onTap: () => _openWebView(
                  'https://www.transfermarkt.com.tr/2-bundesliganin-en-skorer-futbolcusu-olan-marcel-hartel-sozlesmesini-uzatmayacak/view/news/437847'), // Bağlantılarınızı uygun URL'lerle değiştirin
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "2. Bundesliga’nın en skorer futbolcusu olan Marcel Hartel, sözleşmesini uzatmayacak",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0,),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Image.network(
                          'https://tmssl.akamaized.net//images/foto/galerie/marcel-hartel-elias-saad-fc-st-pauli-2023-1690636131-112749.jpg'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            GestureDetector(
              onTap: () => _openWebView(
                  'https://www.aspor.com.tr/besiktas/2024/05/24/spor-yazarlari-besiktas-trabzonspor-macini-yorumladi'), // Bağlantılarınızı uygun URL'lerle değiştirin
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      'İki kişilik değil üç kişilik futbol oynadı!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0,),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Image.network(
                          'https://trthaberstatic.cdn.wp.trt.com.tr/resimler/2186000/besiktas-ali-muhammed-al-musrati-aa-2187074.jpg'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            GestureDetector(
              onTap: () => _openWebView(
                  'https://www.ntvspor.net/futbol/besiktas-ta-ghezzal-iki-mac-sonra-ilk-11-de-664f84f1b1df5e004efea044'), // Bağlantılarınızı uygun URL'lerle değiştirin
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      'Ghezzal iki maç sonra ilk 11',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0,),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Image.network(
                          'https://cdn.ntvspor.net/03e9bb0bd721496eab1272dc3326d123.jpg?mode=crop&w=940&h=626'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            GestureDetector(
              onTap: () => _openWebView(
                  'https://www.sozcu.com.tr/ademola-lookman-hat-trick-yapti-atalanta-avrupa-ligi-sampiyonu-oldu-p49294'), // Bağlantılarınızı uygun URL'lerle değiştirin
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "Ademola Lookman hat-trick yaptı, Atalanta Avrupa Ligi şampiyonu oldu",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0,),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Image.network(
                          'https://www.trtspor.com.tr/resimler/550000/551675.jpg'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            GestureDetector(
              onTap: () => _openWebView(
                  'https://www.sondakika.com/guncel/haber-genclik-ve-spor-bakani-bolu-ataturk-stadyumu-nu-ye-16952009/'), // Bağlantılarınızı uygun URL'lerle değiştirin
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "Real Madrid, Granada yı 4-0 mağlup ederek galibiyet serisini sürdürdü",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0,),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Image.network(
                          'https://cdnuploads.aa.com.tr/uploads/Contents/2023/07/06/thumbs_b_c_de4b36f2744445329eaa8247cb1d06f6.jpg?v=154852'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

          ],
        ),




      ),

    );
  }
}
