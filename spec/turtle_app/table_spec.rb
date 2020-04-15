require_relative '../../lib/turtle_app/table'

RSpec.describe TurtleApp::Table do
  subject { described_class.new }

  describe '#fields' do
    it 'returns empty 5x5 table' do
      expect(subject.fields).to eq(
        [
          [nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil]
        ]
      )
    end
  end

  describe '#place' do
    it 'places turtle on given field' do
      subject.place(4, 4)

      expect(subject.fields).to eq(
        [
          [nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, 'T']
        ]
      )
    end

    context 'when turtle is placed two times' do
      it 'is placed on the latest given field' do
        subject.place(4, 4)
        subject.place(0, 0)

        expect(subject.fields).to eq(
          [
            ['T', nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil]
          ]
        )
      end
    end
  end
end
