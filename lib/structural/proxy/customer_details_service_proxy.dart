import 'customer/customer_details.dart';
import 'icustomer_details_service.dart';
//! collect the data 

class CustomerDetailsServiceProxy implements ICustomerDetailsService {
  final ICustomerDetailsService service;
  final Map<String, CustomerDetails> customerDetailsCache = {};

  CustomerDetailsServiceProxy(this.service);
  @override
  Future<CustomerDetails> getCustomerDetails(String id) async {
    if (customerDetailsCache.containsKey(id)) {
      return customerDetailsCache[id]!;
    }

    final CustomerDetails customerDetails = await service.getCustomerDetails(id);
    customerDetailsCache[id] = customerDetails;

    return customerDetails;
  }
}
