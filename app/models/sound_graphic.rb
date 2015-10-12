class SoundGraphic

	attr_reader :name, :width, :height

	def initialize(options = {})
		@name = options[:name]
		@width = options[:width]
		@height = options[:height]
	end

	def jsid
		@name
	end

end