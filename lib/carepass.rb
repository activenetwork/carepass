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
      response = HTTParty.get('https://api.carepass.com/user-directory-api/users/currentUser', :headers => @headers)
      response['id']
      # todo: add catch on failure
    end    

    def info
      response = HTTParty.get('https://api.carepass.com/user-directory-api/users/currentUser', :headers => @headers)
      # todo: add catch on failure
    end


  end

end
