import 'package:flutter/material.dart';
import 'package:ieee_week15_task1/widgets/book_item.dart';
import 'package:ieee_week15_task1/models/book_model.dart';
import 'package:ieee_week15_task1/widgets/bottom_sheet.dart';
import 'package:ieee_week15_task1/db/sqflite_db.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SqfliteDb sqflite = SqfliteDb();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Available Books',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: sqflite.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: ListView.separated(
                itemBuilder: (context,index){
                  BookModel book = BookModel.fromJson(snapshot.data![index] as Map<String,dynamic>);
                  return BookItem(book: book);

                },
                separatorBuilder: (context,index)=> const SizedBox(
                  height: 15,
                ),
                itemCount: snapshot.data!.length,
              ),
            );
          }
          else if (snapshot.hasError) {
            return const Text('ERROR');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: const CustomBottomSheet(),
    );
  }
}
