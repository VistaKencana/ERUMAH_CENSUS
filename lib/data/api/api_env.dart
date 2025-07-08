enum ApiEnv {
  dev(baseUrl: "https://pppa.orasyn.com/api/censusUser"),
  stag(baseUrl: "https://pppa.orasyn.com/api/censusUser"),
  prod(baseUrl: "https://pppa.orasyn.com/api/censusUser"),
  ;

  final String baseUrl;
  const ApiEnv({required this.baseUrl});
}
