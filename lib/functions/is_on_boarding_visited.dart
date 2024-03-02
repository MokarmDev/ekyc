import '../database/cache/cache_helper.dart';
import '../services/service_locator.dart';

void isOnBoardingVisited() {
  getIt<CacheHelper>().saveData(key: "isOnBoardingVisited", value: true);
}
