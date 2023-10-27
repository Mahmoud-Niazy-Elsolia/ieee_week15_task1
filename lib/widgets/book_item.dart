import 'package:flutter/material.dart';
import 'package:ieee_week15_task1/db/sqflite_db.dart';

import '../components/custom_icon_button.dart';
import '../models/book_model.dart';
import '../components/custom_text_button.dart';
import '../screens/home_screen.dart';

class BookItem extends StatelessWidget {
  final BookModel book;

  const BookItem({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 140,
          width: MediaQuery.of(context).size.width * .35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(book.imageUrl),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                book.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black54),
              ),
              Text(
                'Author: ${book.author}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
        CustomIconButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text(
                  'Delete Book',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.black45),
                ),
                content: const Text(
                  'Are you sure you want to delet this book',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                actions: [
                  CustomTextButton(
                    onPressed: () async{
                      await SqfliteDb().deleteData(
                        id: book.id,
                      );
                      Navigator.of(context).pop();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                            (route) => false,
                      );
                    },
                    label:'Delete',
                    color: Colors.red,
                  ),
                  CustomTextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: 'cancel',
                    color: Colors.grey,
                  ),
                ],
              ),
            );
          },
          icon:  Icons.delete_forever,
          size: 40,
          color: Colors.black87,
        ),
      ],
    );
  }
}
