module TurtleApp
  class Error < StandardError; end

  class TurtleNotPlaced < Error
    def initialize(msg = 'Turtle not placed')
      super
    end
  end

  class IncorrectPlace < Error
    def initialize(msg = 'Incorrect place')
      super
    end
  end

  class IncorrectDirection < Error
    def initialize(msg = 'Incorrect direction')
      super
    end
  end
end
