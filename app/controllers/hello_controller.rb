require 'base_controller'

class HelloController < BaseController
	
	def self.build(api_key = ENV['ORCHESTRATE_KEY'])
		new(Orchestrate::Client.new(:api_key => api_key))
	end

	def initialize(client)
		@client = client
	end

	def index
		@greeting =  "Hello World!"
		@client.search(:DailyAuditorData, "*", {:sort => 'key:asc'}) 
	end

end
