import 'package:flutter/material.dart';
import 'package:ieee_week15_task1/screens/home_screen.dart';
import 'package:ieee_week15_task1/db/sqflite_db.dart';

import '../components/custom_text_field.dart';

class CustomBottomSheet extends StatelessWidget {
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController authorController = TextEditingController();
    TextEditingController urlController = TextEditingController();


    SqfliteDb sqflite = SqfliteDb();

    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => SizedBox(
            height: MediaQuery.of(context).size.height * .45,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      label: 'Book Title',
                      controller: titleController,
                      validation: (value){
                        if(value!.isEmpty){
                          return 'Title can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      label: 'Book Author',
                      controller: authorController,
                      validation: (value){
                        if(value!.isEmpty){
                          return 'Author can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      label: 'Book Cover Url',
                      controller: urlController,
                      validation: (value){
                        if(value!.isEmpty){
                          return 'Url can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if(formKey.currentState!.validate()){
                          await sqflite.insertData(
                            title: titleController.text,
                            author: authorController.text,
                            url: urlController.text,
                          );
                          Navigator.of(context).pop();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                                (route) => false,
                          );
                        }
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                          child: Text(
                            'ADD',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      backgroundColor: Colors.blue,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
