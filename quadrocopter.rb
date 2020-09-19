require "rgl/adjacency"
require "rgl/path"
require "pry"

class PathBuilder
  attr_reader :transmitters

  def initialize(transmitters)
    @transmitters = transmitters
  end

  # Builds graph representation of transmitters
  def build
    graph = RGL::AdjacencyGraph.new
    transmitters.each do |current_transmitter|
      other_transmitters = transmitters.reject { |t| t.index == current_transmitter.index }
      other_transmitters.each do |other_transmitter|
        graph.add_edge(current_transmitter.index, other_transmitter.index) if current_transmitter.adjacent?(other_transmitter)
      end
    end
    graph
  end
end

class Transmitter < Struct.new(:index, :x, :y, :power)
  def initialize(index:, x:, y:, power:)
    self.index = index
    self.x = x
    self.y = y
    # Comparing int with float results in ignoring the fractional part
    self.power = power.to_f
  end

  def distance(x:, y:)
    Math.sqrt((self.x - x) ** 2 + (self.y - y) ** 2)
  end

  def adjacent?(other_transmitter)
    distance(x: other_transmitter.x, y: other_transmitter.y) <= power + other_transmitter.power
  end

  def belongs?(x:, y:)
    distance(x: x, y: y) <= power
  end
end

class QueadrocopterPath
  attr_reader :start_point, :end_point, :transmitters, :path
  def initialize(transmitters:, start_point:, end_point:)
    @start_point  = start_point
    @end_point    = end_point
    # Build transmitters objects out of input data
    @transmitters = transmitters.each_with_index.map{|t, index| Transmitter.new(t.merge(index: index + 1))}
    @path         = PathBuilder.new(@transmitters).build
  end

  def safe?
    start_transmitter = transmitter_for_point(**start_point)
    end_transmitter = transmitter_for_point(**end_point)

    return false if start_transmitter.nil? || end_transmitter.nil?
    return false if transmitters.empty?
    return true if start_transmitter.index == end_transmitter.index
    path.path?(start_transmitter.index, end_transmitter.index)
  end

  private
  # Finds first transmitter which covers the points
  def transmitter_for_point(x:, y:)
    transmitters.find { |t| t.belongs?(x: x, y: y) }
  end
end
