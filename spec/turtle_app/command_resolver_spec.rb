RSpec.describe TurtleApp::CommandResolver do
  subject { described_class.new }

  let(:table) { instance_double(TurtleApp::Table) }

  describe '#call' do
    context 'when PLACE command is passed' do
      it 'calls Table#place method' do
        expect(table).to receive(:place).with(4, 4, 'SOUTH').once

        subject.call(table: table, command: 'PLACE 4,4,SOUTH')
      end
    end

    context 'when LEFT command is passed' do
      it 'calls Table#rotate_left method' do
        expect(table).to receive(:rotate_left).once

        subject.call(table: table, command: 'LEFT')
      end
    end

    context 'when RIGHT command is passed' do
      it 'calls Table#rotate_right method' do
        expect(table).to receive(:rotate_right).once

        subject.call(table: table, command: 'RIGHT')
      end
    end

    context 'when REPORT command is passed' do
      it 'calls Table#report method' do
        expect(table).to receive(:report).once.and_return({})

        subject.call(table: table, command: 'REPORT')
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
