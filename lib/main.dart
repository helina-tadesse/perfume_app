import 'package:flutter/material.dart';

void main() {
  runApp(const PerfumeApp());
}

class PerfumeApp extends StatelessWidget {
  const PerfumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perfume E-Commerce',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
      ),
      home: const HomeScreen(),
    );
  }
}

// ==========================================
// DATA MODEL
// ==========================================
class Perfume {
  final String id;
  final String name;
  final String brand;
  final String description;
  final double price;
  final String imageUrl;
  final String rating;

  Perfume({
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
  });
}

final List<Perfume> samplePerfumes = [
  Perfume(
    id: '1',
    name: 'Bleu de Chanel',
    brand: 'CHANEL',
    description: 'An unexpected and undeniably bold fragrance. Fresh, clean, and profoundly sensual.',
    price: 145.00,
    imageUrl: 'https://images.unsplash.com/photo-1541643600914-78b084683601?q=80&w=600&auto=format&fit=crop',
    rating: '4.9',
  ),
  Perfume(
    id: '2',
    name: 'Sauvage',
    brand: 'DIOR',
    description: 'A radically fresh composition, dictated by a name that has the ring of a manifesto.',
    price: 135.00,
    imageUrl: 'https://images.unsplash.com/photo-1594035910387-fea47794261f?q=80&w=600&auto=format&fit=crop',
    rating: '4.8',
  ),
];

// ==========================================
// HOME SCREEN
// ==========================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.notes, color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Find Your\nSignature Scent',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.2, height: 1.2),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5)),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  hintText: 'Search fragrances...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('All', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Container(width: 16, height: 2, color: Colors.black),
                  ],
                ),
                const Text('Floral', style: TextStyle(color: Colors.grey, fontSize: 16)),
                const Text('Woody', style: TextStyle(color: Colors.grey, fontSize: 16)),
                const Text('Citrus', style: TextStyle(color: Colors.grey, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 25),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.68,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: samplePerfumes.length,
                itemBuilder: (context, index) {
                  final perfume = samplePerfumes[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailsScreen(perfume: perfume)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Hero(
                              tag: perfume.id,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                child: Image.network(perfume.imageUrl, fit: BoxFit.cover, width: double.infinity),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(perfume.brand, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1)),
                                const SizedBox(height: 4),
                                Text(perfume.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('\$${perfume.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.amber, size: 14),
                                        const SizedBox(width: 2),
                                        Text(perfume.rating, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// PRODUCT DETAILS SCREEN
// ==========================================
class DetailsScreen extends StatelessWidget {
  final Perfume perfume;
  const DetailsScreen({super.key, required this.perfume});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Hero(
              tag: perfume.id,
              child: Image.network(perfume.imageUrl, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
                ),
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.favorite_border, color: Colors.black),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Container(
              padding: const EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(perfume.brand, style: const TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 2)),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(perfume.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Text('\$${perfume.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 5),
                      Text(perfume.rating, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      const Text('(124 reviews)', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(perfume.description, style: const TextStyle(color: Colors.grey, height: 1.5, fontSize: 14)),
                  const SizedBox(height: 25),
                  const Text('Size', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    children: ['50 ml', '100 ml', '200 ml'].map((size) {
                      bool isSelected = size == '100 ml'; 
                      return Container(
                        margin: const EdgeInsets.only(right: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(size, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text('Add to Bag', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}