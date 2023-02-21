
import 'package:flutter/material.dart';

import '../entities/customer.dart';
import '../entities/order.dart';
import '../repositories/customer_repository.dart';
import '../repositories/irepository.dart';
import '../repositories/order_repository.dart';
import '../data_source.dart/file_storage.dart';
import '../data_source.dart/istorage.dart';
import '../data_source.dart/sql_storage.dart';
import 'data_tables/customers_data_table.dart';
import 'data_tables/orders_data_table.dart';
import 'storage_selection.dart';

class BridgeExample extends StatefulWidget {
  const BridgeExample();
  
  @override
  State<StatefulWidget> createState() => _BridgeExampleState();


}

class _BridgeExampleState extends State<BridgeExample> {
  final List<IStorage> _storages = [SqlStorage(), FileStorage()];

  late IRepository _customersRepository;
  late IRepository _ordersRepository;

  late List<Customer> _customers;
  late List<Order> _orders;

  int _selectedCustomerStorageIndex = 0;
  int _selectedOrderStorageIndex = 0;

  void _onSelectedCustomerStorageIndexChanged(int? index) {
    setState(() {
      _selectedCustomerStorageIndex = index!;
      _customersRepository = CustomersRepository(_storages[index]);
      _customers = _customersRepository.getAll() as List<Customer>;
    });
  }

  void _onSelectedOrderStorageIndexChanged(int? index) {
    setState(() {
      _selectedOrderStorageIndex = index!;
      _ordersRepository = OrdersRepository(_storages[index]);
      _orders = _ordersRepository.getAll() as List<Order>;
    });
  }

  void _addCustomer() {
    _customersRepository.save(Customer());

    setState(() {
      _customers = _customersRepository.getAll() as List<Customer>;
    });
  }

  void _addOrder() {
    _ordersRepository.save(Order());

    setState(() {
      _orders = _ordersRepository.getAll() as List<Order>;
    });
  }

  @override
  void initState() {
    super.initState();

    _customersRepository =
        CustomersRepository(_storages[_selectedCustomerStorageIndex]);
    _customers = _customersRepository.getAll() as List<Customer>;

    _ordersRepository = OrdersRepository(_storages[_selectedOrderStorageIndex]);
    _orders = _ordersRepository.getAll() as List<Order>;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Select customers storage:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              StorageSelection(
                storages: _storages,
                selectedIndex: _selectedCustomerStorageIndex,
                onChanged: _onSelectedCustomerStorageIndexChanged,
              ),
              PlatformButton(
                materialColor: Colors.black,
                materialTextColor: Colors.white,
                onPressed: _addCustomer,
                text: 'Add',
              ),
              if (_customers.isNotEmpty)
                CustomersDatatable(customers: _customers)
              else
                Text(
                  '0 customers found',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              const Divider(),
              Row(
                children: <Widget>[
                  Text(
                    'Select orders storage:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              StorageSelection(
                storages: _storages,
                selectedIndex: _selectedOrderStorageIndex,
                onChanged: _onSelectedOrderStorageIndexChanged,
              ),
              PlatformButton(
                materialColor: Colors.black,
                materialTextColor: Colors.white,
                onPressed: _addOrder,
                text: 'Add',
              ),
              if (_orders.isNotEmpty)
                OrdersDatatable(orders: _orders)
              else
                Text(
                  '0 orders found',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlatformButton extends StatelessWidget {
  final String text;
  final Color materialColor;
  final Color materialTextColor;
  final VoidCallback? onPressed;

  const PlatformButton({
    required this.text,
    required this.materialColor,
    required this.materialTextColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: MaterialButton(
          color: materialColor,
          textColor: materialTextColor,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.white,
          onPressed: onPressed,
          child: Text(text, textAlign: TextAlign.center),
        ));
  }
}
