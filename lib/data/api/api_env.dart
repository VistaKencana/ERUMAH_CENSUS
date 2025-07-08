enum ApiEnv {
  dev(baseUrl: "https://epengurusanperumahan.com.my/api/censusUser"),
  stag(baseUrl: "https://epengurusanperumahan.com.my/api/censusUser"),
  prod(baseUrl: "https://epengurusanperumahan.com.my/api/censusUser"),
  ;

  final String baseUrl;
  const ApiEnv({required this.baseUrl});
}
