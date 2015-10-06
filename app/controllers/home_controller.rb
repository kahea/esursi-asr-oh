class HomeController < ApplicationController

	def index
		@dts = DTS.new(name: 'sine1', sampling_rate: 30, samples: 30)
		@dts.gen_sine_one(frequency: 1, amplitude: 1)

		@dts2 = DTS.new(name: 'sine2', sampling_rate: 30, samples: 30)
		@dts2.gen_sine_one(frequency: 0.5, amplitude: 1)

		@dts3 = @dts + @dts2

		@dts4 = DTS.new(name: 'test', sampling_rate: 8000, samples: 8)
		@dts4.gen_dft_example_1
		@dts4.calculate_dft
		puts @dts4.magnitudes[0]
	end

end
