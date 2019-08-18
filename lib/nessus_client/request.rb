require 'excon'
require 'json'

class NessusClient

  # Abstract base class for NessusClient. Provides some helper methods for
  class Request

    attr_reader   :url, :headers

    # Default HTTP header to be used on the requests.
    DEFAULT_HEADERS = {
      "User-Agent" => "Mozilla/5.0 (Linux x86_64)",
      "Content-Type" => "application/json"
    }

    def initialize( params )
      params = {:uri => nil, :ssl_verify_peer => false, :headers => {} }.merge( params )
      @@ssl_verify_peer = params.fetch(:ssl_verify_peer)
      @url = @@url = NessusClient::Request.uri_parse( params.fetch(:uri) )
      @headers = params.fetch( :headers ).merge( DEFAULT_HEADERS )
    end

    # @raise [NotImplementedError] Use update from Hash insted.
    def headers=(value)
      raise NotImplementedError.new("Use update from Hash insted.")
    end

    # Perform a HTTP GET to the endpoint.
    # @param [String] path The URI path to perform the request.
    # @param [String] payload The HTTP body to send.
    # @param [String] query The URI query to send.
    def get( path=nil, payload=nil, query=nil )
      http_request( :get, path, payload, query )
    end

    # Perform a HTTP POST to the endpoint.
    # @param [String] path The URI path to perform the request.
    # @param [String] payload The HTTP body to send.
    # @param [String] query The URI query to send.
    def post( path=nil, payload=nil, query=nil )
      http_request( :post, path, payload, query )
    end

    # Perform a HTTP DELETE to the endpoint.
    # @param [String] path The URI path to perform the request.
    # @param [String] payload The HTTP body to send.
    # @param [String] query The URI query to send.
    def delete( path=nil, payload=nil, query=nil )
      http_request( :delete, path, payload, query )
    end
    # Parse a receiveid URI
    # @param [String] uri A valid URI.
    # @return [String] A string uri.
    def self.uri_parse( uri )
      url = URI.parse( uri )
      raise URI::InvalidURIError unless url.scheme
      return url.to_s
    end

    private

    # @private HTTP request abstraction to be used.
    # @param [Symbol] method A HTTP method to be used could be `:get`, `:post` or `:delete`.
    # @param [String] path The URI path to perform the request.
    # @param [String] payload The HTTP body to send.
    # @param [String] query The URI query to send.
    def http_request( method=:get, path, payload, query )
      
      connection = Excon.new( @@url )
      
      body = payload ? payload.to_json : ''
      options = {
        method: method,
        path: path,
        body: body,
        query: query,
        headers: @headers,
        ssl_verify_peer: @@ssl_verify_peer,
        expects: [200, 201]
      }
      response = connection.request( options )
    
      return response.body if response.body.length > 0

    end

  end
  
end