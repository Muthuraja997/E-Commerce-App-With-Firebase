
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double price;
  final String offertag;
  final String description;
  final Function onTap;
  const ProductCard({super.key, required this.name, required this.imageUrl, required this.price, required this.offertag, required this.onTap, required this.description});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(imageUrl,
              fit: BoxFit.cover, 
              width: double.maxFinite,
              height: 120,
            
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.error));
              },
          
              ),
             
              const SizedBox(height: 9),
               Text(name,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,),
              const SizedBox(height: 9,),
               Text('Rs: $price',
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(4),
      
                ),
                child: Text('$offertag offer',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                
              ),
              Text('$description',
              style: const TextStyle(fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              
              ),
            ],
          ),
        ),
      ),
    );
  }
}