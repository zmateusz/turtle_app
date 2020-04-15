require 'ostruct'

module TurtleApp
  class Table
    attr_reader :fields

    def initialize
      @fields = Array.new(5) { Array.new(5, nil) }
      @turtle = OpenStruct.new(x: nil, y: nil, direction: nil)
    end

    def place(x, y, direction)
      clear_table

      fields[x][y] = 'T'
      @turtle.x = x
      @turtle.y = y
      @turtle.direction = direction
    end

    def report
      {
        x: turtle.x,
        y: turtle.y,
        direction: turtle.direction
      }
    end

    private

    attr_reader :turtle

    def clear_table
      @fields[turtle.x][turtle.y] = nil if turtle.x && turtle.y
    end
  end
end
