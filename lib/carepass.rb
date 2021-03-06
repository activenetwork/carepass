require "carepass/version"

module Carepass

  USER_ENDPOINT = 'https://api.carepass.com/user-directory-api/users/currentUser'
  ACTIVITY_ENDPOINT = USER_ENDPOINT + '/fitness/activities'
  ACTIVITY_TYPES_ENDPOINT = 'https://api.carepass.com/user-directory-api/fitness/activities/types'

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
      response = self.get(USER_ENDPOINT)
      response['id']
      # todo: add catch on failure
    end

    def info
      self.get(USER_ENDPOINT)
      # todo: add catch on failure
    end

    def upload_workout(query_parameters)
      if query_parameters.first.include? :id or query_parameters.first.include? 'id'
        response = self.put(ACTIVITY_ENDPOINT, query_parameters)
      else
        response = self.post(ACTIVITY_ENDPOINT, query_parameters)
      end
      response
    end

    def destroy_workout(id)
      self.destroy(ACTIVITY_ENDPOINT,id)
    end

    def post(url, query_parameters)
      post_headers = @headers
      post_headers['Content-Type'] = 'application/json'
      response = HTTParty.post(url, :headers => post_headers, :body => query_parameters.to_json)
      Rails.logger.info(response)
      response.parsed_response
    end

    def put(url, query_parameters)
      put_headers = @headers
      put_headers['Content-Type'] = 'application/json'
      response = HTTParty.put(url, :headers => put_headers, :body => query_parameters.to_json)
      response.parsed_response
    end

    def get(url, query_parameters=nil)
      response = HTTParty.get(url, :headers => @headers, :query => query_parameters)
    end

    def destroy(url,id)
      response = HTTParty.delete(url, :headers => @headers, :query => id)
    end

  end

end
