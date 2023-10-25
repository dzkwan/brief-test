import 'package:brieftest/viewmodel/deteksi_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';

class DeteksiScreen extends StatefulWidget {
  const DeteksiScreen({super.key});

  @override
  State<DeteksiScreen> createState() => _DeteksiScreenState();
}

class _DeteksiScreenState extends State<DeteksiScreen>
    with WidgetsBindingObserver {
  var isDialOpen = ValueNotifier<bool>(false);

  @override
  void initState() {
    context.read<DeteksiViewModel>().loadAsset();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    imageCache.clear();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final tfliteProvider = context.read<DeteksiViewModel>();
    if (state == AppLifecycleState.resumed &&
        tfliteProvider.isLoading == true) {
      tfliteProvider.changeState(DeteksiState.loading);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tfliteProvider = context.read<DeteksiViewModel>();

    return Center(
      child: Consumer<DeteksiViewModel>(
        builder: (context, value, _) => gambar(tfliteProvider),
      ),
    );
  }

  Widget gambar(DeteksiViewModel tfliteProvider) {
    final isLoading = tfliteProvider.state == DeteksiState.loading;

    if (isLoading) {
      return componenCenter().redacted(context: context, redact: true);
    } else if (tfliteProvider.img != null) {
      return Image.file(
        tfliteProvider.img!,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.contain,
      );
    } else {
      return componenCenter();
    }
  }

  Widget componenCenter() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Silahkan pilih gambar dari galeri atau ambil foto dengan kamera",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
