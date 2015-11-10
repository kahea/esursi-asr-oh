module Wave
	
	module_function

	def sine(magnitude, frequency, sampling_rate, periods)
		ampltidues = []
		(sampling_rate * periods).times do |n|
			ampltidues.push(magnitude * Math.sin(2 * Math::PI * frequency.to_f * n * 1/sampling_rate.to_f))
		end
		ampltidues
	end

	def cosine(magnitude, frequency, sampling_rate, periods)
		ampltidues = []
		(sampling_rate * periods).times do |n|
			ampltidues.push(magnitude * Math.cos(2 * Math::PI * frequency.to_f * n * 1/sampling_rate.to_f))
		end
		ampltidues
	end


end