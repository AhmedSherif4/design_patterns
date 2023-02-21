import '../entities/customer.dart';
import '../entities/entity_base.dart';
import '../data_source.dart/istorage.dart';
import 'irepository.dart';

class CustomersRepository implements IRepository {
  final IStorage storage;

  const CustomersRepository(this.storage);

  @override
  List<EntityBase> getAll() {
    return storage.fetchAll<Customer>();
  }

  @override
  void save(EntityBase entityBase) {
    storage.store<Customer>(entityBase as Customer);
  }
}
