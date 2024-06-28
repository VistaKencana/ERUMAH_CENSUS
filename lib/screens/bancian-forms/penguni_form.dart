import 'package:eperumahan_bancian/components/custom_underline_field.dart';
import 'package:eperumahan_bancian/components/kad_pengenalan_tile.dart';
import 'package:flutter/material.dart';

class PenguniForm extends StatefulWidget {
  const PenguniForm({super.key});

  @override
  State<PenguniForm> createState() => _PenguniFormState();
}

class _PenguniFormState extends State<PenguniForm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 2), blurRadius: 10, color: Colors.black12)
          ],
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(10))),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.5),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const KadPengenalanTile(),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 16 / 8),
                  padding: const EdgeInsets.all(8.0),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: size.width * 0.4,
                      child: const CustomUnderlineField(
                        title: "Nama",
                        showEditIcon: true,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
