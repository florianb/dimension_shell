require 'json'

require 'httpclient'

module DimensionShell
  class CloudControl
    def initialize(args)
      @region = args[:region]
      @organization = args[:organization]
      @username = args[:username]
      @password = args[:password]
    end

    def get_server(servername)
      _invoke_get path: 'server/server', query: { name: servername }
    end

    def get_server_list
      _invoke_get path: 'server/server'
    end

  private
    def _api_header
      {'Accept' => 'application/json'}
    end

    def _api_base_uri
      "https://api-#{@region}.dimensiondata.com"
    end

    def _api_domain(*args)
      ([_api_base_uri, 'caas', '2.1', @organization] + args.flatten).join('/')
    end

    # Invokes a GET request against the dimensiondata-API
    #
    # @param [Hash] options The options hash.
    # @option options [Hash] :header HTTP-header-elements
    # @option options [Array/String] :path path-appendix of URL
    # @option options [Hash] :query HTTP-query-elements
    def _invoke_get(options)
      header = options[:header] || {}
      header.merge!(_api_header)

      client = HTTPClient.new(default_header: header, force_basic_auth: true)
      client.set_auth _api_base_uri, @username, @password
      #puts "Fetching url \"#{_api_domain(options[:path])}\""
      response = client.get(_api_domain(options[:path]), :query => options[:query])

      if response.ok? then
        JSON.parse(response.body)
      else
        { failure: "#{response.status.to_s} - #{response.reason.to_s}" }
      end
    end
  end
end
