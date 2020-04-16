require_relative 'turtle_app/table'
require_relative 'turtle_app/command_resolver'

module TurtleApp
  def self.start(table: Table.new, command_resolver: CommandResolver.new)
    system('clear')
    puts 'TurtleApp. Please place turtle to start.'

    loop do
      begin
        render_to_console(table)

        command = gets.chomp
        exit(0) if command.empty?

        result = command_resolver.call(table: table, command: command)
        puts result if result
      rescue CommandResolver::UnknownCommandError => e
        puts e.message
      rescue TurtleApp::TurtleNotPlaced => e
        puts e.message
      rescue TurtleApp::IncorrectPlace => e
        puts e.message
      rescue TurtleApp::IncorrectDirection => e
        puts e.message
      end
    end
  end

  def self.render_to_console(table)
    puts '_______'
    table.fields.reverse.each do |row|
      print '|'
      row.each do |field|
        if field == 'T'
          print field
        else
          print ' '
        end
      end
      puts '|'
    end
    puts '⎻⎻⎻⎻⎻⎻⎻'
  end
end
