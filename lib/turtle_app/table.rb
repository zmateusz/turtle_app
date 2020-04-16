require 'ostruct'

module TurtleApp
  class Table
    DIRECTIONS = ['NORTH', 'EAST', 'SOUTH', 'WEST'].freeze

    attr_reader :fields, :turtle

    def initialize
      @fields = Array.new(5) { Array.new(5, nil) }
      @turtle = OpenStruct.new(x: nil, y: nil, direction: nil)
    end

    def place_turtle(x, y, direction)
      clear_table

      fields[y][x] = 'T'
      turtle.x = x
      turtle.y = y
      turtle.direction = direction
    end

    def move_turtle
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
      turtle.direction = next_direction(DIRECTIONS.reverse, turtle.direction)
    end

    def rotate_turtle_right
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
  end
end
