module Chart

  module_function

  def print(data, options = {})

    height = options[:height] ? options[:height] : 43
    xscale = options[:xscale] ? options[:xscale] : 2

    max = data.max 
    min = data.min
    span = max - min
    width = data.size * xscale
    chart = ''

    if min < 0
     height += 1
    end

    yscale = ((span) / height.to_f)

    chart << "\n"

    (height+1).times do |i|

      y = (max - (yscale*i))


      chart << (y < 0 ? "" : " ") << ("%6.2f" % y) << " "

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