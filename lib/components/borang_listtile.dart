import 'package:flutter/material.dart';

class BorangTile extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final String subtitle;
  const BorangTile({
    super.key,
    this.onTap,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: PhysicalModel(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black26,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.description,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title),
                    Text(
                      subtitle,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
