import 'package:appointment_app/config/helpers/shared/services_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}





class _ServicesScreenState extends State<ServicesScreen> {
  List myList = ["India", "Nepal", "Sri Lanka", "America", "United Kingdom"];
  ServicesFirebase servicesFirebase = ServicesFirebase(collection: 'service');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.squarePlus),
            onPressed: () {              
              Navigator.pushNamed(context, '/add_service');
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: servicesFirebase.getAll(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            ListView.builder(
              itemCount: myList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Slidable(
                    key: const ValueKey(0),
                    endActionPane: ActionPane(
                      dismissible: DismissiblePane(onDismissed: () {
                        // we can able to perform to some action here
                      }),
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          autoClose: true,
                          flex: 1,
                          onPressed: (value) {
                            myList.removeAt(index);
                            setState(() {});
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                        SlidableAction(
                          autoClose: true,
                          flex: 1,
                          onPressed: (value) {
                            myList.removeAt(index);
                            setState(() {});
                          },
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Edit',
                        ),
                      ],
                    ),
                    child: Container(
                      color: Colors.yellow,
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Center(
                          child: Text(
                        myList[index],
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: Text('There\'s no Services', style: Theme.of(context).textTheme.headlineLarge));
        }
      ),
    );
  }
}