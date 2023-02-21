import 'package:flutter/material.dart';

import '../customer/customer.dart';
import '../customer_details_service.dart';
import '../customer_details_service_proxy.dart';
import '../icustomer_details_service.dart';
import 'customer_details_dialog/customer_details_dialog.dart';

class ProxyExample extends StatefulWidget {
  const ProxyExample();

  @override
  State<StatefulWidget> createState() => _ProxyExampleState();
}

class _ProxyExampleState extends State<ProxyExample> {
  final ICustomerDetailsService _customerDetailsServiceProxy =
      CustomerDetailsServiceProxy(CustomerDetailsService());
  final List<Customer> _customerList = List.generate(10, (_) => Customer());

  void _showCustomerDetails(Customer customer) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return CustomerDetailsDialog(
          service: _customerDetailsServiceProxy,
          customer: customer,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            children: <Widget>[
              Text(
                'Press on the list tile to see more information about the customer',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              for (var customer in _customerList)
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Text(
                        customer.name[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    trailing: const Icon(Icons.info_outline),
                    title: Text(customer.name),
                    onTap: () => _showCustomerDetails(customer),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
