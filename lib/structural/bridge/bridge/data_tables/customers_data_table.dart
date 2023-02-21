import 'package:flutter/material.dart';

import '../../entities/customer.dart';



class CustomersDatatable extends StatelessWidget {
  final List<Customer> customers;

  const CustomersDatatable({
    required this.customers,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 12,
        horizontalMargin: 12,
        headingRowHeight: 12,
        dataRowHeight: 12,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Name',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
          ),
          DataColumn(
            label: Text(
              'E-mail',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
          ),
        ],
        rows: <DataRow>[
          for (var customer in customers)
            DataRow(
              cells: <DataCell>[
                DataCell(Text(customer.name)),
                DataCell(Text(customer.email)),
              ],
            ),
        ],
      ),
    );
  }
}
