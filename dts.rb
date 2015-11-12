require 'chart'

class DTS
	attr_reader :name, :function, :sampling_rate, :samples, :seconds, :amplitudes, :magnitudes, :dft_data, :print

	def initialize(name, sampling_rate, amplitudes)
		@name = name
		@sampling_rate = sampling_rate
		@amplitudes = amplitudes
	end

	def [](i)
		self.amplitudes[i]
	end

	def []=(i, val)
		self.amplitudes[i] = val
	end

	def +(dts)
		if dts.class != DTS
			return false
		end
		
		amplitudes = []

		larger = self.amplitudes.size > dts.amplitudes.size ? self : dts
		smaller = self == larger ? dts : self

		larger.amplitudes.each_with_index do |a, i|
			amplitudes.push(a + (i < smaller.amplitudes.size ? smaller[i] : 0))
		end

		return amplitudes
	end

	def print()
		Chart.print(self.amplitudes)
	end

	# def jsid
	# 	self.name.gsub(' ', '-').gsub('+', 'plus')
	# end

	# def calculate_dft

	# 	@dft_data = { real: Array.new(@samples), imag: Array.new(@samples) }

	# 	@samples.times do |m|	# frequency

	# 		@dft_data[:real][m] = { cos: Array.new(@samples), cor: Array.new(@samples)}
	# 		@dft_data[:imag][m] = { sin: Array.new(@samples), cor: Array.new(@samples)}

	# 		real_sum = 0.0
	# 		imag_sum = 0.0

	# 		@samples.times do |n|

	# 			@dft_data[:real][m][:cos][n] = Math.cos(2 * Math::PI * n * m / @samples.to_f)
	# 			@dft_data[:imag][m][:sin][n] = -Math.sin(2 * Math::PI * n * m / @samples.to_f)

	# 			@dft_data[:real][m][:cor][n] = @amplitudes[n] * @dft_data[:real][m][:cos][n]
	# 			@dft_data[:imag][m][:cor][n] = @amplitudes[n] * @dft_data[:imag][m][:sin][n]

	# 			real_sum += @amplitudes[n] * Math.cos(2 * Math::PI * n * m / @samples.to_f)
	# 			imag_sum += @amplitudes[n] * -Math.sin(2 * Math::PI * n * m / @samples.to_f)

	# 		end
	# 		@magnitudes[m] = 2 * Math.sqrt(real_sum**2 + imag_sum**2) / @samples.to_f
	# 	end

	# 	puts @dft_data[:real][1][:cos]
	# 	# puts "read: #{@magnitudes_real[1]}, imag: #{@magnitudes_imag[1]}"
	# end

	# def calculate_fft
	# 	pad = 1
	# 	while(pad < @amplitudes.size)
	# 		pad *= 2
	# 	end
	# 	@amplitudes.fill(0, @amplitudes.size..pad-1)

	# 	@magnitudes = fft(@amplitudes).map { |i| i.magnitude.round(2) }
	# 	# @magnitudes = fft(@amplitudes).map { |i| (i.magnitude**2) / @samples.to_f }

	# 	# @magnitudes = @magnitudes.slice(0, @magnitudes.size/2)
	# end

	# #####################################################################################
	# # http://www.gregfjohnson.com/fftruby/
	# #####################################################################################
	# def fft(vec)
 #    return vec if vec.size <= 1

 #    even = Array.new(vec.size / 2) { |i| vec[2 * i] }
 #    odd  = Array.new(vec.size / 2) { |i| vec[2 * i + 1] }

 #    fft_even = fft(even)
 #    fft_odd  = fft(odd)

 #    fft_even.concat(fft_even)
 #    fft_odd.concat(fft_odd)

 #    Array.new(vec.size) {|i| (fft_even[i] + fft_odd [i] * omega(-i, vec.size)) }
	# end

	# def omega(k, n)
	# 	Math::E ** Complex(0, 2 * Math::PI * k / n)
	# end
	# ####################################################################################

	# def sampling_rate_str
	# 	"#{@sampling_rate} Hz"
	# end

	# def sampling_period
	# 	1/@sampling_rate.to_f
	# end

	# def gen_sine_one(options = {})
	# 	@amplitudes.size.times do |n|
	# 		self[n] = options[:amplitude] * Math.sin(2 * Math::PI * options[:frequency].to_f/@sampling_rate.to_f * n)
	# 	end
	# 	@function = "#{options[:amplitude]} * Math.sin(2 * Math::PI * #{options[:frequency]}/#{@sampling_rate} * n)"
	# end

	# def gen_cos_one(options = {})
	# 	@amplitudes.size.times do |n|
	# 		self[n] = Math.cos(2*Math::PI*(1/(options[:frequency] * @sampling_rate).to_f)*n) * options[:amplitude]
	# 	end
	# 	@function = "Math.sin(2*Math::PI*(1/(#{options[:frequency]} * #{@sampling_rate})*n) * #{options[:amplitude]}"
	# end

	# def gen_dft_example_1
	# 	@samples.times do |n|
	# 		a = Math.sin(2 * Math::PI * 1000.0 * n * 1/8000.0 )
	# 		b = 0.5 * Math.sin(2 * Math::PI * 2000.0 * n * 1/8000.0)
	# 		self[n] = a + b
	# 	end
	# 	@function = "Math.sin(2 * Math::PI * 1000.0 * n * 1/8000.0 ) + 0.5 * Math.sin(2 * Math::PI * 2000.0 * n * 1/8000.0)"
	# end

	# def gen_dft_example_2
	# 	@samples.times do |n|
	# 		a = Math.sin(2 * Math::PI * 1000.0 * n * 1/8000.0 )
	# 		b = 0.5 * Math.sin(2 * Math::PI * 2000.0 * n * 1/8000.0 + 3 * Math::PI / 4)
	# 		self[n] = a + b
	# 	end
	# 	@function = "Math.sin(2 * Math::PI * 1000.0 * n * 1/8000.0 ) + 0.5 * Math.sin(2 * Math::PI * 2000.0 * n * 1/8000.0  + 3 * Math::PI / 4)"
	# end

	# def gen_dft_example_3
	# 	@samples.times do |n|
	# 		self[n] = Math.sin(2 * Math::PI * n / 64)
	# 	end
	# 	@function = "Math.sin(2 * Math::PI * n / 64)"
	# end

	# def amplitudes_granular(granularity)
	# 	@amplitudes.each_with_index.map { |x, n| x if n % granularity == 0}.compact
	# end

end