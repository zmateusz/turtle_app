require 'ostruct'
require_relative 'table_errors'

module TurtleApp
  class Table
    DIRECTIONS = ['NORTH', 'EAST', 'SOUTH', 'WEST'].freeze

    attr_reader :fields, :turtle

    def initialize
      @fields = Array.new(5) { Array.new(5, nil) }
      @turtle = OpenStruct.new(x: nil, y: nil, direction: nil)
    end

    def place_turtle(x, y, direction)
      raise IncorrectPlace if x == -1 || y == -1 || x == fields.size || y == fields.size
      raise IncorrectDirection unless DIRECTIONS.include?(direction)

      clear_table

      fields[y][x] = 'T'
      turtle.x = x
      turtle.y = y
      turtle.direction = direction
    end

    def move_turtle
      verify_turtle_is_placed

      case turtle.direction
      when 'SOUTH' then
        new_y = turtle.y - 1
        place_turtle(turtle.x, new_y, turtle.direction) and return if new_y >= 0
      when 'WEST' then
        new_x = turtle.x - 1
        place_turtle(new_x, turtle.y, turtle.direction) and return if new_x >= 0
      when 'NORTH' then
        new_y = turtle.y + 1
        place_turtle(turtle.x, new_y, turtle.direction) and return if new_y < fields.size
      when 'EAST' then
        new_x = turtle.x + 1
        place_turtle(new_x, turtle.y, turtle.direction) and return if new_x < fields.size
      end

      'Table edge reached. Can not move forward'
    end

    def rotate_turtle_left
      verify_turtle_is_placed

      turtle.direction = next_direction(DIRECTIONS.reverse, turtle.direction)
    end

    def rotate_turtle_right
      verify_turtle_is_placed

      turtle.direction = next_direction(DIRECTIONS, turtle.direction)
    end

    def report
      verify_turtle_is_placed

      {
        x: turtle.x,
        y: turtle.y,
        direction: turtle.direction
      }
    end

    private

    def clear_table
      fields[turtle.y][turtle.x] = nil if turtle.x && turtle.y
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

    def verify_turtle_is_placed
      raise TurtleNotPlaced unless turtle.x && turtle.y
    end
  end
end
