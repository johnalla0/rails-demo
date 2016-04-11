require 'base_controller'
require_relative "../helpers/results_helper"

class HelloController < BaseController
	
	def self.build(api_key = ENV['ORCHESTRATE_KEY'])
		new(Orchestrate::Client.new(:api_key => api_key), Time, nil)
	end

	def initialize(client, time, results_helper)
		@client = client
		@time = time
		@results_helper = results_helper
	end

	def index
		date = params[:date]
		if date != nil
			timestamp = "key:" + date.gsub("-", "?")
		else
			timestamp = @time.now.gmtime.strftime("key:%Y-%m-%d")
		end
		search_results = @client.search(:DailyAuditorData, timestamp, {:sort => 'key:asc'}) 
		formatted_results = @results_helper.handle_results(search_results)
	end

end
