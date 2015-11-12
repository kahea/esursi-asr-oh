include Math

module Window

	module_function

	def hamming(input)
		output = []
		size = input.size
		size.times do |p|
			output.push(input[p] * (0.54 - 0.46 * Math.cos(2 * Math::PI * p / (size - 1))))
		end
		output
	end

	def hanning(input)
		output = []
		size = input.size
		size.times do |p|
			output.push(input[p] * (0.5 * (1 - Math.cos(2 * Math::PI * p / (size - 1)))))
		end
		output
	end

	def rectangular(n)
		data = Array.new(n, 1)
	end

	def triangular(input)
		output = []
		n = input.size - 1
		n.times do |p|
			output.push(input[p] * (1 - ((p - ((n-1)/2).to_f) / (n/2).to_f).abs))
		end
		output
	end

end