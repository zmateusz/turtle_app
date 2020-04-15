require 'ostruct'

module TurtleApp
  class Table
    attr_reader :fields

    def initialize
      @fields = Array.new(5) { Array.new(5, nil) }
      @turtle = nil
    end

    def place(x, y)
      clear_table

      fields[x][y] = 'T'
      @turtle = OpenStruct.new(x: x, y: y)
    end

    private

    attr_reader :turtle

    def clear_table
      @fields[turtle.x][turtle.y] = nil if turtle
    end
  end
end
