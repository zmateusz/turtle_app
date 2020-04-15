require_relative '../../lib/turtle_app/command_resolver'

RSpec.describe TurtleApp::CommandResolver do
  subject { described_class.new }

  let(:table) { instance_double(TurtleApp::Table) }

  describe '#call' do
    context 'when PLACE command is passed' do
      it 'calls Table#place method' do
        expect(table).to receive(:place).with(4, 4, 'SOUTH')

        subject.call(table: table, command: 'PLACE 4,4,SOUTH')
      end
    end

    context 'when unknown command is passed' do
      it 'raises UnknownCommandError' do
        expect { subject.call(table: table, command: 'FOO 4,4') }
          .to raise_error(TurtleApp::CommandResolver::UnknownCommandError, 'Unknown command: FOO 4,4')
      end
    end
  end
end
