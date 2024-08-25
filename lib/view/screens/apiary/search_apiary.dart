import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/models/apiary_model.dart';
import 'package:beekeep/view/screens/apiary/apiary_details.dart';
import 'package:beekeep/view/screens/home/Custom_Apiary_Information_widget.dart';
import 'package:beekeep/view/widget/custom_search_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_styling.dart';

class SearchApiary extends StatefulWidget {
  const SearchApiary({super.key});

  @override
  State<SearchApiary> createState() => _SearchApiaryState();
}

TextEditingController searchController = TextEditingController();

class _SearchApiaryState extends State<SearchApiary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        title: Text("Search Apiary"),
      ),
      body: Padding(
        padding: all(context, 20),
        child: Column(
          children: [
            CustomSearchBar(
              onChanged: (value){
                setState(() {

                });
              },
              controller: searchController,
            ),
            SizedBox(height: 20,),
            Expanded(
                child: FutureBuilder(
              future: FirebaseConstants.apiaryCollectionReference
                  .where(Filter.and(
                      Filter("apiaryName",
                          isGreaterThanOrEqualTo: searchController.text.toLowerCase()),
                      Filter("apiaryName",
                          isLessThan: '${searchController.text.toLowerCase()}\uf8ff')))
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData) {
                  return const Text("No result found");
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      ApiaryModel apiaryModel = ApiaryModel.fromMap(
                          snapshot.data?.docs[index].data()
                              as Map<String, dynamic>);

                      return GestureDetector(
                        onTap: (){
                          Get.to(()=>ApiaryDetailsView(apiaryModel: apiaryModel));
                        },
                        child: ApiaryInformationWidget(
                          apiaryModel: apiaryModel,
                        ),
                      );
                    },
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
