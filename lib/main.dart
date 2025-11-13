import 'package:flutter/material.dart';

void main() {
  runApp(const PixelMarketApp());
}

// --- TEMA Y COLORES MÁGICOS ---
class PixelTheme {
  static const Color bgDark = Color(0xFF1F1B2C); // Fondo muy oscuro
  static const Color cardBg = Color(0xFF362F4B); // Fondo de tarjetas
  static const Color accentGreen = Color(0xFF6DAA2C); // Botones comprar
  static const Color accentOrange = Color(0xFFD68910); // Botones acción
  static const Color textWhite = Color(0xFFE0E0E0);
  static const Color textGrey = Color(0xFF9E9E9E);
  
  // Estilo de texto "simulado" pixel art (Idealmente usar fuente 'VT323' o 'Press Start 2P')
  static const TextStyle headerStyle = TextStyle(
    fontFamily: 'Monospace', 
    fontWeight: FontWeight.bold, 
    fontSize: 24, 
    color: textWhite,
    letterSpacing: 1.5
  );
  
  static const TextStyle bodyStyle = TextStyle(
    fontFamily: 'Monospace', 
    fontWeight: FontWeight.bold, 
    fontSize: 14, 
    color: textWhite
  );
}

class PixelMarketApp extends StatelessWidget {
  const PixelMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixel Market',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: PixelTheme.bgDark,
        primaryColor: PixelTheme.cardBg,
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

// --- PANTALLA PRINCIPAL CON NAVEGACIÓN ---
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const Center(child: Text("Buscador - Próximamente", style: PixelTheme.headerStyle)),
    const CartPage(),
    const Center(child: Text("Perfil - Próximamente", style: PixelTheme.headerStyle)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white12, width: 2)),
          color: PixelTheme.bgDark,
        ),
        child: BottomNavigationBar(
          backgroundColor: PixelTheme.bgDark,
          selectedItemColor: PixelTheme.accentGreen,
          unselectedItemColor: PixelTheme.textGrey,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          ],
        ),
      ),
    );
  }
}

// --- PÁGINA DE INICIO (TIENDA) ---
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("HOLA, VIAJERO", style: TextStyle(color: PixelTheme.textGrey, fontFamily: 'Monospace')),
                  Text("PIXEL MARKET", style: PixelTheme.headerStyle),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: PixelTheme.cardBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white24, width: 2)
                ),
                child: const Icon(Icons.notifications, color: PixelTheme.textWhite),
              )
            ],
          ),
          const SizedBox(height: 20),
          
          // Banner Promocional
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: PixelTheme.accentOrange,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(4, 4))]
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("OFERTA ÉPICA", style: PixelTheme.headerStyle),
                      Text("30% EN POCIONES", style: PixelTheme.bodyStyle),
                    ],
                  ),
                ),
                Icon(Icons.science, size: 50, color: Colors.white), // Icono placeholder
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // Categorías
          const Text("CATEGORÍAS", style: PixelTheme.headerStyle),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _CategoryChip("ARMAS", true),
                _CategoryChip("ARMADURAS", false),
                _CategoryChip("POCIONES", false),
                _CategoryChip("RUNAS", false),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Grid de Productos
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _CategoryChip(String label, bool isSelected) {
  return Container(
    margin: const EdgeInsets.only(right: 10),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: isSelected ? PixelTheme.accentGreen : PixelTheme.cardBg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: isSelected ? Colors.white : Colors.white24, width: 2)
    ),
    child: Text(label, style: PixelTheme.bodyStyle.copyWith(color: isSelected ? Colors.white : PixelTheme.textGrey)),
  );
}

// --- WIDGET DE TARJETA DE PRODUCTO ---
class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PixelTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen (Placeholder)
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(product['icon'], size: 50, color: Colors.white54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product['name'], style: PixelTheme.bodyStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$${product['price']}", style: const TextStyle(color: PixelTheme.accentOrange, fontWeight: FontWeight.bold, fontFamily: 'Monospace', fontSize: 16)),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: PixelTheme.accentGreen,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(Icons.add, size: 16, color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

// --- PÁGINA DE CARRITO (MOCKUP) ---
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text("MI MOCHILA", style: PixelTheme.headerStyle),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: PixelTheme.cardBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white12)
                  ),
                  child: Row(
                    children: [
                      Container(width: 50, height: 50, color: Colors.black26, child: const Icon(Icons.shield, color: Colors.white)),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Item Legendario", style: PixelTheme.bodyStyle),
                          Text("x1", style: TextStyle(color: PixelTheme.textGrey)),
                        ],
                      ),
                      const Spacer(),
                      const Text("\$500", style: TextStyle(color: PixelTheme.accentOrange, fontFamily: 'Monospace', fontSize: 18)),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: PixelTheme.accentGreen,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(0, 4))]
            ),
            child: const Text("COMPRAR AHORA", textAlign: TextAlign.center, style: PixelTheme.headerStyle),
          )
        ],
      ),
    );
  }
}

// --- DATOS DE PRUEBA ---
final List<Map<String, dynamic>> products = [
  {'name': 'Espada de Pixel', 'price': 150, 'icon': Icons.landscape},
  {'name': 'Poción Roja', 'price': 50, 'icon': Icons.local_drink},
  {'name': 'Casco de Hierro', 'price': 300, 'icon': Icons.shield},
  {'name': 'Botas Veloces', 'price': 120, 'icon': Icons.flash_on},
  {'name': 'Mapa Antiguo', 'price': 25, 'icon': Icons.map},
  {'name': 'Cofre Misterioso', 'price': 999, 'icon': Icons.lock},
];
