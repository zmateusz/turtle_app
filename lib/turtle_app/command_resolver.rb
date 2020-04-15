module TurtleApp
  class CommandResolver
    class UnknownCommandError < StandardError; end

    def call(table:, command:)
      command_parts = command.split
      command_name = command_parts[0]
      command_args = command_parts[1]

      if command_name == 'PLACE'
        parsed_args = command_args.split(',')
        table.place(parsed_args[0].to_i, parsed_args[1].to_i, parsed_args[2])
      else
        raise UnknownCommandError, "Unknown command: #{command}"
      end
    end
  end
end
