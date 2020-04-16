module TurtleApp
  class CommandResolver
    class UnknownCommandError < StandardError; end

    def call(table: Table.new, command:)
      command_parts = command.split
      command_name = command_parts[0]
      command_args = command_parts[1]

      result = nil

      case command_name
      when 'PLACE' then
        parsed_args = command_args.split(',')
        table.place(parsed_args[0].to_i, parsed_args[1].to_i, parsed_args[2])
      when 'MOVE' then
        result = table.move
      when 'LEFT' then
        table.rotate_left
      when 'RIGHT' then
        table.rotate_right
      when 'REPORT' then
        report = table.report
        result = "#{report[:x]},#{report[:y]},#{report[:direction]}"
      else
        raise UnknownCommandError, "Unknown command: #{command}"
      end

      result
    end
  end
end
