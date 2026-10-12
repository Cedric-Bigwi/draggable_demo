import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShopPage(),
    ));

/// Simple data class carried by each Draggable.
class Product {
  final String name;
  final IconData icon;
  final double price;
  const Product(this.name, this.icon, this.price);
}

const products = [
  Product('Cookie', Icons.cookie, 1.20),
  Product('Coffee', Icons.coffee, 4.50),
  Product('Cake', Icons.cake, 3.80),
];

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});
  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final List<Product> cart = [];

  double get total => cart.fold(0, (sum, p) => sum + p.price);

  // The visual card for a product (reused for child / feedback).
  Widget productCard(Product p, {Color color = Colors.white, double elevation = 2}) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(12),
      color: color,
      child: SizedBox(
        width: 90,
        height: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(p.icon, size: 36),
            Text(p.name),
            Text('\$${p.price.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 8),
            Text(
              'Drag to Cart',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: products.map((p) {
              return Draggable<Product>(
                // data: what the DragTarget receives when we drop.
                data: p,

                // child: what is shown while idle.
                child: productCard(p),

                // feedback: what follows the finger (required).
                feedback: productCard(p, color: Colors.amber.shade200, elevation: 10),

                // childWhenDragging: what stays behind in the shelf.
                childWhenDragging: Opacity(opacity: 0.25, child: productCard(p)),
              );
            }).toList(),
          ),
          const Spacer(),
          // The drop zone.
          DragTarget<Product>(
            onAcceptWithDetails: (details) =>
                setState(() => cart.add(details.data)),
            builder: (context, candidate, rejected) {
              final hovering = candidate.isNotEmpty;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                height: 180,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: hovering ? Colors.green.shade100 : Colors.grey.shade200,
                  border: Border.all(
                      color: hovering ? Colors.green : Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_cart, size: 40),
                    Text(cart.isEmpty
                        ? 'Drop items here'
                        : '${cart.length} items - \$${total.toStringAsFixed(2)}'),
                    if (cart.isNotEmpty)
                      TextButton(
                        onPressed: () => setState(cart.clear),
                        child: const Text('Clear cart'),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}