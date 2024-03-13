# frozen_string_literal: true

RACK_APP_CONFIG = "#{__dir__}/app/config.ru"
RACK_EXAMPLE_APP = Rack::Builder.parse_file(RACK_APP_CONFIG)
ENV["RACK_ENV"] ||= "production"

def handler(event:, context:)
  SRack::AWSLambdaHandler
    .new(RACK_EXAMPLE_APP)
    .handle(event:   event,
      context: context)
end

RSpec.describe SRack do
  it "has a version number" do
    expect(SRack::VERSION).not_to be nil
  end

  it "calls application and return expected response" do
    event = {"version" => "2.0",
             "routeKey" => "$default",
             "rawPath" => "/foobar",
             "rawQueryString" => "",
             "headers" =>
    {"sec-fetch-mode" => "navigate",
     "referer" =>
    "https://vsm7uzziw4c56pnb55xr3bdg340mwhna.lambda-url.eu-west-1.on.aws/",
     "x-amzn-tls-version" => "TLSv1.3",
     "sec-fetch-site" => "same-origin",
     "x-forwarded-proto" => "https",
     "accept-language" => "en-GB,en;q=0.9",
     "x-forwarded-port" => "443",
     "x-forwarded-for" => "2001:67c:8fc:300:79fb:4b22:ee9c:67b2",
     "accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
     "x-amzn-tls-cipher-suite" => "TLS_AES_128_GCM_SHA256",
     "x-amzn-trace-id" => "Root=1-65f21453-12fea99c0f073ae4050a4b84",
     "host" => "vsm7uzziw4c56pnb55xr3bdg340mwhna.lambda-url.eu-west-1.on.aws",
     "accept-encoding" => "gzip, deflate, br",
     "user-agent" =>
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15",
     "sec-fetch-dest" => "document"},
             "requestContext" =>
    {"accountId" => "anonymous",
     "apiId" => "vsm7uzziw4c56pnb55xr3bdg340mwhna",
     "domainName" =>
    "vsm7uzziw4c56pnb55xr3bdg340mwhna.lambda-url.eu-west-1.on.aws",
     "domainPrefix" => "vsm7uzziw4c56pnb55xr3bdg340mwhna",
     "http" =>
    {"method" => "GET",
     "path" => "/foobar",
     "protocol" => "HTTP/1.1",
     "sourceIp" => "2001:67c:8fc:300:79fb:4b22:ee9c:67b2",
     "userAgent" =>
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15"},
     "requestId" => "3e106d3c-5a1a-4aa0-8fdf-8d3271f3c2b0",
     "routeKey" => "$default",
     "stage" => "$default",
     "time" => "13/Mar/2024:21:02:11 +0000",
     "timeEpoch" => 1710363731400},
             "isBase64Encoded" => false}

    response = handler(event: event, context: nil)

    expect(response["statusCode"]).to eq(404)
    expect(response["body"]).to match(/404/)
  end
end
