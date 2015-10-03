class DTS

	attr_reader :name, :sample_rate, :seconds, :amplitudes

	def initialize(options = {})
		@name = options[:name]
		@sampling_rate = options[:sampling_rate]
		@seconds = options[:seconds]
		@amplitudes = Array.new(@seconds * @sampling_rate)
	end

	def sampling_rate_str
		"#{@sampling_rate} Hz"
	end

	def sampling_period
		1/@sampling_rate.to_f
	end

	def gen_sine_one(options = {})
		@amplitudes.size.times do |n|
			@amplitudes[n] = Math.sin(2*Math::PI*(1/(options[:frequency] * @sampling_rate).to_f)*n) * options[:amplitude]
		end
	end

	def amplitudes_granular(granularity)
		@amplitudes.each_with_index.map { |x, n| x if n % granularity == 0}.compact
	end

end