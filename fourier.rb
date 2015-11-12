module Fourier

	module_function

	def dft(data)
		size = data.size
		dft = []
		size.times do |m|
			sum = Complex(0)
			size.times do |n|
				angle = 2 * Math::PI * n * m / size.to_f
				sum += data[n] * Complex(Math.cos(angle), -Math.sin(angle))
			end
			dft.push(sum.magnitude)
		end
		dft
	end

	def idft(data)
		size = data.size
		idft = []
		size.times do |m|
			sum = Complex(0)
			size.times do |n|
				angle = 2 * Math::PI * n * m / size.to_f
				sum += data[n] * Complex(Math.cos(angle), Math.sin(angle)) / size.to_f
			end
			idft.push(sum.real < 0 ? sum.magnitude * -1 : sum.magnitude)
		end
		idft
	end

	def fft(data)

	end

end