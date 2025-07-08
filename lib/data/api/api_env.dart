enum ApiEnv {
  dev(baseUrl: "https://dbklperumahan.anjuranarena.com.my/api/censusUser"),
  stag(baseUrl: "https://dbklperumahan.anjuranarena.com.my/api/censusUser"),
  prod(baseUrl: "https://dbklperumahan.anjuranarena.com.my/api/censusUser"),
  ;

  final String baseUrl;
  const ApiEnv({required this.baseUrl});
}
