require 'ostruct'

module TurtleApp
  class Table
    DIRECTIONS = ['NORTH', 'EAST', 'SOUTH', 'WEST'].freeze

    attr_reader :fields, :turtle

    def initialize
      @fields = Array.new(5) { Array.new(5, nil) }
      @turtle = OpenStruct.new(x: nil, y: nil, direction: nil)
    end

    def place(x, y, direction)
      clear_table

      fields[x][y] = 'T'
      turtle.x = x
      turtle.y = y
      turtle.direction = direction
    end

    def rotate_left
      turtle.direction = next_direction(DIRECTIONS.reverse, turtle.direction)
    end

    def rotate_right
      turtle.direction = next_direction(DIRECTIONS, turtle.direction)
    end

    def report
      {
        x: turtle.x,
        y: turtle.y,
        direction: turtle.direction
      }
    end

    private

    def clear_table
      fields[turtle.x][turtle.y] = nil if turtle.x && turtle.y
    end

    def next_direction(directions, current_direction)
      directions_cycle = directions.cycle
      new_direction = nil

      directions.size.times do
        direction = directions_cycle.next

        if direction == current_direction
          new_direction = directions_cycle.next
          break
        end
      end

      new_direction
    end
  end
end
