import 'package:doggy_do/core/models/dog_model.dart';
import 'package:flutter/material.dart';

class DogCard extends StatelessWidget {
  final DogModel dog;

  const DogCard({Key? key, required this.dog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FutureBuilder(
                future: loadImage(context),
                builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Image.asset(
                      "assets/images/profile_image_hold.png",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    );
                  } else {
                    return snapshot.data!;
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dog.dogName!, // Assuming there's a 'name' property in your Dog model
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Future<Image> loadImage(BuildContext context) async {
    final Image image = Image.network(
      "https://doggydo-upload-bucket.s3.eu-west-2.amazonaws.com/${dog.dogImageLink}",
      height: 100,
      width: 100,
      fit: BoxFit.cover,
    );
    await precacheImage(image.image, context);
    return image;
  }
}
