class DTS

	attr_reader :name, :sampling_rate, :samples, :amplitudes, :magnitudes, :magnitude_frequencies

	def initialize(options = {})
		@name = options[:name]
		@sampling_rate = options[:sampling_rate]
		@samples = options[:samples]
		@amplitudes = Array.new(self.samples)
		@magnitudes = Array.new(self.samples)
		@magnitude_frequencies = Array.new(self.samples)
		@magnitudes.size.times do |i|
			self.magnitude_frequencies[i] = i * (self.sampling_rate/self.samples.to_f)
		end
	end

	def calculate_dft
		real = Array.new(@samples, 0)
		imag = Array.new(@samples, 0)

		@magnitudes.size.times do |m|
			next if m == 0
			@magnitudes.size.times do |n|
				x = @amplitudes[n]

				realn = Math.cos(2 * Math::PI * n * m / @samples.to_f)
				imagn = -Math.sin(2 * Math::PI * n * m / @samples.to_f)

				real[m] += x * realn
				imag[m] += x * imagn

			end

			mag = Math.sqrt(real[m] ** 2 + imag[m] ** 2)
			magrel = 2 * Math.sqrt(real[m] ** 2 + imag[m] ** 2) / @samples.to_f

			puts "real: #{real[m].round(2)} imag: #{imag[m].round(2)} mag: #{mag.round(2)} magrel: #{magrel.round(2)}"

		end

	end

	def sampling_rate_str
		"#{@sampling_rate} Hz"
	end

	def sampling_period
		1/@sampling_rate.to_f
	end

	def gen_sine_one(options = {})
		@amplitudes.size.times do |n|
			self[n] = Math.sin(2*Math::PI*(1/(options[:frequency] * @sampling_rate).to_f)*n) * options[:amplitude]
		end
	end

	def gen_dft_example_1
		@samples.times do |n|
			a = Math.sin(2 * Math::PI * 1000.0 * n * 1/8000.0 )
			b = 0.5 * Math.sin(2 * Math::PI * 2000.0 * n * 1/8000.0 + 3 * Math::PI / 4)
			# self[n] = a + b
			self[n] = b #+ b
		end
	end

	def amplitudes_granular(granularity)
		@amplitudes.each_with_index.map { |x, n| x if n % granularity == 0}.compact
	end

	def [](i)
		self.amplitudes[i]
	end

	def []=(i, val)
		self.amplitudes[i] = val
	end

	def +(dts)
		if @sampling_rate != dts.sampling_rate
			return 4
		end
		if self.samples >= dts.samples ? self : dts
			dtslonger = self
			dtsshorter = dts
		else
			dtslonger = dts
			dtsshorter = self
		end

		dtsnew = DTS.new(name: self.name + ' + ' + dts.name, sampling_rate: self.sampling_rate, samples: dtslonger.samples)
		
		dtslonger.amplitudes.each_with_index do |a, i|
			dtsnew[i] = a + (dtsshorter.amplitudes.size > i ? dtsshorter[i] : 0)
		end

		return dtsnew
	end

end