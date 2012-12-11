require "carepass/version"

module Carepass


  # test method
  def self.test
  	puts 'testing out cool'
  end

  class User
  	attr_accessor :token

  	def initialize (token)
      raise Error, 'access token is required' if token.nil?
      @token = token
      apikey = CAREPASS_CONFIG[:client_id]
      @headers = {'Authorization' => "Bearer #{@token}",
                  'Accept' => 'application/json',
                  'Apikey' => "#{apikey}"}
      self
  	end

    def id
      response = self.get('https://api.carepass.com/user-directory-api/users/currentUser')
      response['id']
      # todo: add catch on failure
    end

    def info
      self.get('https://api.carepass.com/user-directory-api/users/currentUser')
      # todo: add catch on failure
    end

    def post(url, query_parameters)
      post_headers = @headers
      post_headers['Content-Type'] = 'application/json'
      response = HTTParty.post(url, :headers => post_headers, :body => query_parameters)
      # todo: add catch on failure
    end

    def get(url, query_parameters=nil)
      response = HTTParty.get(url, :headers => @headers, :query => query_parameters)
    end
  end

end
