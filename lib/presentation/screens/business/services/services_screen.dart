import 'package:appointment_app/config/helpers/shared/services_firebase.dart';
import 'package:appointment_app/infrastructure/models/service_model.dart';
import 'package:appointment_app/presentation/screens/business/services/services_form.dart';
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

  Future<void> showDeleteDialog(BuildContext context, String name) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Yes'),
                onTap: () {
                  servicesFirebase.delService(name);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.circle),
                title: const Text('No'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil( // ! Remover en caso de error.
          context, '/home', (Route<dynamic> route) => false,
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Services'),
          centerTitle: true,
          elevation: 4,
          actions: [
            IconButton(
              icon: const Icon(FontAwesomeIcons.squarePlus),
              onPressed: () {              
                Navigator.pushNamed(context, '/add_service');
              },
            ),
          ],
        ),
        body: StreamBuilder<List<ServiceModel?>>(
          stream: servicesFirebase.getServices( ServicesFirebase.uid ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('There\'s no Services', style: Theme.of(context).textTheme.headlineLarge));
            } else {
              List<ServiceModel?> services = snapshot.data!;
              return ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Slidable(
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                        dismissible: DismissiblePane(onDismissed: () {
                          
                        }),
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            autoClose: true,
                            flex: 1,
                            onPressed: (value) {
                              showDeleteDialog(context, services[index]!.serviceName!);
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ServiceForm( serviceModel: services[index] )),
                              );
                            },
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                        ],
                      ),
                      child: Container(
                        color: Theme.of(context).highlightColor,
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Center(
                          child: Text(
                            services[index]!.serviceName!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }          
        ),
      ),
    );
  }
}