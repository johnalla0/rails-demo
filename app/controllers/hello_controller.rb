require 'base_controller'

class HelloController < BaseController
	
	def index
		@greeting =  "Hello World!"
	end


end
