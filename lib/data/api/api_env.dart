enum ApiEnv {
  dev(baseUrl: "https://dev-eperumahan.fastsystem.com.my/api/censusUser"),
  stag(baseUrl: "https://dev-eperumahan.fastsystem.com.my/api/censusUser"),
  prod(baseUrl: "https://eperumahan.fastsystem.com.my/api/censusUser"),
  ;

  final String baseUrl;
  const ApiEnv({required this.baseUrl});
}
