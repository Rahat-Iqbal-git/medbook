abstract final class AppRoutes {
  const AppRoutes._();

  static const home = '/';
  static const search = '/search';
  static const diseaseDetails = '/diseases/:id';
  static const medicineDetails = '/medicines/:id';

  static String disease(int id) => '/diseases/$id';
  static String medicine(int id) => '/medicines/$id';
}
