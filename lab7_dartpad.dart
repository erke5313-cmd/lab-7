import 'package:flutter/material.dart';

// Simple data model for one product. The whole object is passed to DetailScreen.
class Product {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final String category;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
  });
}

// Hard coded list of products for the feed
const List<Product> products = [
  Product(
    id: 1,
    title: 'Air Runner Pro',
    description:
        'Lightweight running sneakers with a breathable mesh upper and a '
        'cushioned sole. Great for daily runs and long walks.',
    imageUrl:
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800',
    price: 129.99,
    category: 'Running',
  ),
  Product(
    id: 2,
    title: 'Street Classic',
    description:
        'Everyday casual sneakers with a clean look. Soft inner lining and '
        'a durable rubber outsole that goes with any outfit.',
    imageUrl:
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800',
    price: 89.50,
    category: 'Casual',
  ),
  Product(
    id: 3,
    title: 'Court Master',
    description:
        'High support basketball shoes with extra ankle padding and strong '
        'grip for quick moves on the court.',
    imageUrl:
        'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?w=800',
    price: 149.00,
    category: 'Basketball',
  ),
  Product(
    id: 4,
    title: 'Urban Flex',
    description:
        'Flexible and comfortable lifestyle sneakers for the city. Light '
        'weight design, easy to wear all day.',
    imageUrl:
        'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=800',
    price: 99.90,
    category: 'Lifestyle',
  ),
];

// One row in the list: image, title, category, price and a favorite button
class ProductCard extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        // Navigator.push opens the detail screen and passes the full object
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(product: product),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.imageUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) => Container(
                    width: 90,
                    height: 90,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image_not_supported),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Expanded gives the text all the free space, so no overflow
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.category,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onFavoriteToggle,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Detail screen receives the complete Product object from the previous screen
class DetailScreen extends StatelessWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar shows the back arrow automatically because the screen was pushed
      appBar: AppBar(
        title: Text(
          product.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: Image.network(
                product.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Container(
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image_not_supported, size: 48),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Chip(label: Text(product.category)),
                  const SizedBox(height: 16),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 15, height: 1.4),
                  ),
                  const SizedBox(height: 24),
                  // In-body back button, works the same as the AppBar arrow
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back to list'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
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

// Tab 1: list of all products
class FeedScreen extends StatelessWidget {
  final List<Product> products;
  final Set<int> favoriteIds;
  final void Function(int id) onToggleFavorite;

  const FeedScreen({
    super.key,
    required this.products,
    required this.favoriteIds,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sneaker Feed')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            isFavorite: favoriteIds.contains(product.id),
            onFavoriteToggle: () => onToggleFavorite(product.id),
          );
        },
      ),
    );
  }
}

// Tab 2: only the products the user marked with a heart
class FavoritesScreen extends StatelessWidget {
  final List<Product> products;
  final Set<int> favoriteIds;
  final void Function(int id) onToggleFavorite;

  const FavoritesScreen({
    super.key,
    required this.products,
    required this.favoriteIds,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: products.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No favorites yet.\nTap the heart in the feed to save an item.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  isFavorite: favoriteIds.contains(product.id),
                  onFavoriteToggle: () => onToggleFavorite(product.id),
                );
              },
            ),
    );
  }
}

// Tab 3: simple profile and settings screen
class ProfileScreen extends StatefulWidget {
  final int favoritesCount;

  const ProfileScreen({super.key, required this.favoritesCount});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Local settings state, kept alive by IndexedStack when switching tabs
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 44,
              child: Icon(Icons.person, size: 48),
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Student User',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const Center(child: Text('student@narxoz.kz')),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Saved items'),
            trailing: Text(
              '${widget.favoritesCount}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            value: _notifications,
            onChanged: (value) {
              setState(() {
                _notifications = value;
              });
            },
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('App version'),
            trailing: Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}

// Root screen: holds BottomNavigationBar and the shared favorites state
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final Set<int> _favoriteIds = {};

  void _toggleFavorite(int id) {
    setState(() {
      if (_favoriteIds.contains(id)) {
        _favoriteIds.remove(id);
      } else {
        _favoriteIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProducts =
        products.where((p) => _favoriteIds.contains(p.id)).toList();

    return Scaffold(
      // IndexedStack keeps every tab alive, so state is not lost on tab switch
      body: IndexedStack(
        index: _currentIndex,
        children: [
          FeedScreen(
            products: products,
            favoriteIds: _favoriteIds,
            onToggleFavorite: _toggleFavorite,
          ),
          FavoritesScreen(
            products: favoriteProducts,
            favoriteIds: _favoriteIds,
            onToggleFavorite: _toggleFavorite,
          ),
          ProfileScreen(favoritesCount: favoriteProducts.length),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

void main() {
  runApp(const SneakerApp());
}

class SneakerApp extends StatelessWidget {
  const SneakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sneaker Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
