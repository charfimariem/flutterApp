import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room Booking App',
      theme: ThemeData(
        primaryColor: Colors.blueGrey[900], // Darker tone to reflect solitude
        scaffoldBackgroundColor: Colors.grey[200], // Light gray background
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.white, fontSize: 20), // Updated to titleLarge
          bodyMedium: TextStyle(color: Colors.black54), // Updated to bodyMedium
        ),
      ),
      home: RoomBookingApp(),
    );
  }
}

class RoomBookingApp extends StatelessWidget {
  final List<RoomData> rooms = [
    RoomData(
      imageUrl: 'assets/image1.jpg', // Replace with actual image URL
      title: "Bedroom in Luxury Home",
      price: "\$169/night", // Price will be bold in the UI
      rating: "5.0",
      description: "A spacious and elegantly designed bedroom with luxurious furnishings and a stunning view.",
    ),
    RoomData(
      imageUrl: 'assets/image2.jpg', // Replace with actual image URL
      title: "Bed Room Condo",
      price: "\$115/night", // Price will be bold in the UI
      rating: "5.1",
      description: "A cozy condo bedroom perfect for a relaxing getaway, equipped with modern amenities.",
    ),
    RoomData(
      imageUrl: 'assets/image3.jpg', // Replace with actual image URL
      title: "Queen Bed Room",
      price: "\$400/night", // Price will be bold in the UI
      rating: "4.5",
      description: "An elegant queen bed room featuring high-end decor and a private balcony.",
    ),
    RoomData(
      imageUrl: 'assets/image4.jpg', // Replace with actual image URL
      title: "Eleven Mirrors Room",
      price: "\$302/night", // Price will be bold in the UI
      rating: "5.2",
      description: "A unique room with stunning mirrors and art decor, offering a luxurious experience.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Find Your Room".toUpperCase(), // Convert to uppercase
          style: const TextStyle(
            fontWeight: FontWeight.bold, // Make text bold
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search field with a button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Space between the search field and button
                IconButton(
                  icon: const Icon(Icons.settings), // Changed from ElevatedButton to IconButton
                  onPressed: () {
                    // Add your button action here
                    print('Settings pressed!'); // For demonstration
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  crossAxisSpacing: 10, // Horizontal spacing
                  mainAxisSpacing: 10,  // Vertical spacing
                  childAspectRatio: 0.75, // Width/height ratio for the cards
                ),
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  return buildRoomCard(rooms[index], context);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.mail_outline), label: "Messages"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  // Room Card builder
  Widget buildRoomCard(RoomData room, BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isFavorite = false; // Variable to track if room is a favorite

        return GestureDetector(
          onTap: () {
            // Navigate to the detail page when the card is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RoomDetailPage(room: room),
              ),
            );
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(
                    // Change to Image.network if using URLs
                    room.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns title and favorite icon
                        children: [
                          Text(room.title,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              // Toggle favorite state
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(room.price,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 43, 3, 59),
                            fontWeight: FontWeight.bold, // Make price bold
                          )),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.orange, size: 18),
                          Text(room.rating),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RoomData {
  final String imageUrl;
  final String title;
  final String price;
  final String rating;
  final String description; // New field for description

  RoomData({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.rating,
    required this.description, // Added description
  });
}

// Detail Page for displaying larger image and details
class RoomDetailPage extends StatelessWidget {
  final RoomData room;

  const RoomDetailPage({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(room.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display the large image
          Center(
            child: Image.asset(
              // Change to Image.network if using URLs
              room.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  room.price,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold, // Make price bold
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 20),
                    const SizedBox(width: 4),
                    Text(room.rating, style: const TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  room.description, // Display the description here
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Action for the button
                    print("More details button pressed for ${room.title}");
                  },
                  child: const Text("En savoir plus"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
