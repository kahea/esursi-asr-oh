class HomeController < ApplicationController

	def index
		@dts = DTS.new(name: 'sine1', sampling_rate: 20, seconds: 1)
		@dts.gen_sine_one(frequency: 1, amplitude: 1)
	end

end
