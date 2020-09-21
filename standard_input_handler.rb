require_relative "quadrocopter"

class StandardInputHandler
  def call(solution_class = QueadrocopterPath)
    puts "Give transmitter count"
    transmitter_count = gets.chomp.to_i
    puts "Input trasmitters one in line, format: x y power"
    transmitters = []

    transmitter_count.times do
      x,y,power = gets.chomp.split(" ")
      transmitters << {x: x, y: y, power: power }.transform_values { |v| v.to_i }
    end
    puts "Input start_point"
    start_x, start_y = gets.chomp.split(" ")
    end_x, end_y = gets.chomp.split(" ")

    start_point = { x: start_x, y: start_y }.transform_values{|v| v.to_i}
    end_point = { x: end_x, y: end_y }.transform_values{|v| v.to_i}

    path = solution_class.new(transmitters: transmitters, start_point: start_point, end_point: end_point)

    if path.safe?
      puts "path is safe" 
    else
      puts "there is no safe route"
    end
  end
end
