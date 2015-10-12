class HomeController < ApplicationController

	def index

		@sound_graphic = SoundGraphic.new(name: 'foo', width: 700, height:300)


		# @dts = DTS.new(name: 'sine1', sampling_rate: 32, samples: 32 * 2)
		# @dts.gen_sine_one(frequency: 1, amplitude: 1)
		# @dts.calculate_dft

		# @dtsc = DTS.new(name: 'cos1', sampling_rate: 32, samples: 32 * 2)
		# @dtsc.gen_cos_one(frequency: 1, amplitude: 1)
		# @dtsc.calculate_dft

		# @dts2 = DTS.new(name: 'sine2', sampling_rate: 32, samples: 32)
		# @dts2.gen_sine_one(frequency: 0.5, amplitude: 1)
		# @dts2.calculate_dft

		# @dts3 = @dts + @dts2
		# @dts3.calculate_dft

		# @dts4 = DTS.new(name: 'amp test', sampling_rate: 8000, samples: 8)
		# @dts4.gen_dft_example_1
		# @dts4.calculate_dft

		# @dts5 = DTS.new(name: 'amp test shifted', sampling_rate: 8000, samples: 8)
		# @dts5.gen_dft_example_2
		# @dts5.calculate_dft

		# @dts6 = DTS.new(name: 'test', sampling_rate: 64, samples: 64)
		# @dts6.gen_dft_example_3
		# @dts6.calculate_dft

		# @dts7 = DTS.new(name: 'sine large', sampling_rate: 44100, samples: 44100 * 1)
		# @dts7.gen_sine_one(frequency: 1, amplitude: 1)
		# @dts7.calculate_dft

	end

end
