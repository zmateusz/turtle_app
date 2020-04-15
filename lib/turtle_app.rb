require_relative 'turtle_app/table'

module TurtleApp
  class Error < StandardError; end

  def self.start
    table = Table.new

    while true
      system('clear')

      table.place(1, 4)
      render_to_console(table)

      command = gets.chomp
      exit(0) if command.empty?
    end
  end

  def self.render_to_console(table)
    puts '_______'
    table.fields.each do |row|
      print '|'
      row.each do |field|
        if field == 'T'
          print 'T'
        else
          print ' '
        end
      end
      puts '|'
    end
    puts '⎻⎻⎻⎻⎻⎻⎻'
  end
end
