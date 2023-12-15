import 'package:app_view_trading/view/_product/service/service_keys.dart';

class ApiConstants {
  const ApiConstants._();

  static const String url =
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=50&convert=USD';

  static final Map<String, String> header = {
    'Accepts': 'application/json',
    'X-CMC_PRO_API_KEY': ServiceKeys.coinMarketApiKey,
  };
}
