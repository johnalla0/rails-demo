require 'base_controller'

class HelloController < BaseController
	
	def self.build(api_key = ENV['ORCHESTRATE_KEY'])
		new(Orchestrate::Client.new(:api_key => api_key), Time)
	end

	def initialize(client, time)
		@client = client
		@time = time
	end

	def index
		@greeting = "Hello World!"
		timestamp = @time.now.gmtime.strftime("key:%Y-%m-%d")
		@client.search(:DailyAuditorData, timestamp, {:sort => 'key:asc'}) 
	end

end
