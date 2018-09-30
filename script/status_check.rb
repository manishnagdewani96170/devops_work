#!/usr/bin/env ruby

require 'net/http'
require 'net/https'
require 'uri'
require 'json'

uri = URI.parse("https://git.soma.salesforce.com/api/v3/repos/${GIT_ORG}/${GIT_REPO}/statuses/${GIT_SHA}")

header = {'Content-Type': 'application/json'}

File.open("./status-check-names.txt", "r") do |f|
  f.each_line do |line|
    params = {
      state: "pending",
      context: line
    }
    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request['authorization'] = "Bearer ${BEARER_TOKEN}"
    request.add_field("Accept", "application/vnd.github.v3+json")
    request.body = params.to_json


    # Send the request
    begin
      response = http.request(request)
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
       Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
      puts "-----Error-----"+ e.message
    end
  end
end


