require 'securerandom'

module Chart

  module_function

  def print(data, options = {})

    height = options[:height] ? options[:height] : 43
    xscale = options[:xscale] ? options[:xscale] : 2

    max = data.max 
    min = data.min
    span = max - min
    width = (data.size * xscale).to_i
    chart = ''

    if min < 0
     height += 1
    end

    yscale = ((span) / height.to_f)

    chart << "\n"

    (height+1).times do |i|

      y = (max - (yscale*i))

      chart << (y < 0 ? "" : "") << ("%8.2f" % y) << " "

      width.times do |j|

        if j % xscale == 0

          d = data[j/xscale]

          if (d <= y) and (d > (y - yscale))
            if i != height
              y2 = (max - (yscale*(i+1)))
              if y2.round(2) == 0
                chart << ' '
              else
                chart << '*'
              end
            else
              chart << '*'
            end
          elsif y.round(2) == 0
            if d.round(2) == 0
              chart << '*'
            else
              chart << '-'
            end
          elsif d > 0 and y > 0
            if y < d
              chart << '|'
            else
              chart << ' '
            end
          elsif d < 0 and y < 0
            if y > d
              chart << '|'
            else
              chart << ' '
            end
          else
            chart << ' '
          end

        else
          if y == 0
            chart << '-'
          else
            chart << ' '
          end
        end

      end

      chart << "\n"
    end

    chart << "\n"
    puts chart

  end
end

module Wave 
  module_function

  def sine(magnitude, frequency, sampling_rate, periods)
    ampltidues = []
    (sampling_rate * periods).to_i.times do |n|
      ampltidues.push(magnitude * Math.sin(2 * Math::PI * frequency.to_f * n * 1/sampling_rate.to_f))
    end
    ampltidues
  end

  def cosine(magnitude, frequency, sampling_rate, periods)
    ampltidues = []
    (sampling_rate * periods).to_i.times do |n|
      ampltidues.push(magnitude * Math.cos(2 * Math::PI * frequency.to_f * n * 1/sampling_rate.to_f))
    end
    ampltidues
  end
end

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
      # dft.push(sum)
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

  def fft(input)
    return input if input.empty?
    # pad input so it is a power of 2
    ((2 ** (Math.log2(input.size).ceil)) - input.size).times { |i| input << 0.0 }
    fft_r(input).map { |i| i.magnitude }
  end

  def ifft(input)

  end

  # def fftr(input)
  #   return input if input.size <= 1

  #   even = Array.new(input.size / 2) { |i| input[2 * i] }
  #   odd  = Array.new(input.size / 2) { |i| input[2 * i + 1] }

  #   fft_even = fft(even)
  #   fft_odd  = fft(odd)
  #   fft_even.concat(fft_even)
  #   fft_odd.concat(fft_odd)

  #   Array.new(input.size) {|i| (fft_even[i] + fft_odd[i] * (Math::E ** Complex(0, 2 * Math::PI * (-i) / input.size)) ) }
  # end

  #####################################################################################
  # http://www.gregfjohnson.com/fftruby/
  #####################################################################################
  def fft_r(vec)
    return vec if vec.size <= 1

    even = Array.new(vec.size / 2) { |i| vec[2 * i] }
    odd  = Array.new(vec.size / 2) { |i| vec[2 * i + 1] }

    fft_even = fft(even)
    fft_odd  = fft(odd)

    fft_even.concat(fft_even)
    fft_odd.concat(fft_odd)

    Array.new(vec.size) {|i| (fft_even[i] + fft_odd [i] * omega(-i, vec.size)) }
  end

  def omega(k, n)
    Math::E ** Complex(0, 2 * Math::PI * k / n)
  end
  ####################################################################################

end

module Frame
  module_function

  def new(data, t)
    output = []
    frame_len = (data.size * t).ceil
    frame_cnt = (data.size / frame_len).ceil

    i = 0
    frame_cnt.times do
      frame_arr = []
      frame_len.times do 
        frame_arr.push(i < data.size ? data[i] : 0)
        i += 1
      end
      output.push frame_arr
    end
    output
  end
end

module Sound
  module_function

  def record(rate, name)
    file  = "/tmp/sigproc.#{SecureRandom.hex}"
    puts 'press any key to start recording'
    gets
    system("arecord -d 1 -t raw -f FLOAT_LE -r #{rate} #{file}")
    output = IO.binread(file).unpack('e*')
    File.delete(file)
    output
  end

  def play(rate, data)
    file  = "/tmp/sigproc.#{SecureRandom.hex}"
    f = File.open(file, "w+")
    f.write(data.pack('e*'))
    system("aplay -t raw -f FLOAT_LE -r #{rate} #{file}")
    File.delete(file)
    true
  end
end

class DTS

  attr_reader :rate, :data, :p

  def initialize(name, rate, data)
    @name = name
    @rate = rate
    @data = data
  end

  def print
    Chart.print(@data)
  end

  def write_raw
    f = File.open("sounds/#{@name}.raw", "w+")
    f.write(@data.pack('e*')) # single precision little endian
    f.close
  end

  def play
    Sound.play(@rate, @data)
  end

  def ==(dts)
    self.data.each_with_index do |d, i|
      if d != dts.data[i]
        return i
      end
    end
    true
  end
end

D1 = DTS.new('sine1', 8000, Wave.sine(1, 200, 8000, 1))
D2 = DTS.new('sine2', 8000, Wave.sine(1, 700, 8000, 1))
D3 = DTS.new('sine3', 8000, Window.hamming(Wave.sine(1, 700, 8000, 1)))
D4 = DTS.new('sine3', 8000, Wave.sine(1, 10000, 8000, 1))
# D5 = DTS.new('sine3', 8000, Sound.record(8000, 'test'))

