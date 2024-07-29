import 'package:eperumahan_bancian/components/bg_image.dart';
import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../components/tingkat_chip.dart';

class BancianPprSearch extends StatefulWidget {
  final void Function(String data) onSelect;
  const BancianPprSearch({super.key, required this.onSelect});

  @override
  State<BancianPprSearch> createState() => _BancianPprSearchState();
}

class _BancianPprSearchState extends State<BancianPprSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: BgImage(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(180),
                child: Container(
                  decoration:
                      const BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                        blurRadius: 4),
                  ]),
                  padding: const EdgeInsets.only(right: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 14),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                textField(hintText: "Pilih Zon"),
                                const SizedBox(height: 8),
                                textField(hintText: "Pilih Kawasan"),
                                const SizedBox(height: 8),
                                textField(hintText: "Pilih Blok"),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  height: 65,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        20,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                              left: (index == 0) ? 14 : 0, right: 8),
                          child: TingkatChip(
                            isSelected: index == 0,
                            title: "${index + 1}",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView(
                  children: [
                    _newInfoTile(lawatan: 1),
                  ],
                ))
              ],
            ),
            bottomNavigationBar: Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color(0x33000000),
                    offset: Offset(2, 0),
                    blurRadius: 4),
              ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        child: const Text("Carian")),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  textField({required String hintText}) {
    return SizedBox(
        height: 45,
        child: TextFormField(
          readOnly: true,
          decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: const Icon(Icons.arrow_drop_down)),
        ));
  }

  _newInfoTile({required int lawatan}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () {
          widget.onSelect("Test Data");
          Navigator.pop(context);
        },
        minLeadingWidth: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.white,
        leading: Container(
          decoration: BoxDecoration(
            color: AppColors.midGrey.color,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 4),
          child: const Icon(Icons.location_on),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        isThreeLine: true,
        dense: true,
        title: const Text("NOMBOR UNIT"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("01-01-01"),
            Text("Kota Damansara • Lawatan $lawatan"),
          ],
        ),
        trailing: const Padding(
          padding: EdgeInsets.only(top: 13),
          child: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
