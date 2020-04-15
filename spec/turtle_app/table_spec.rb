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
      subject.place(4, 4, 'SOUTH')

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
        subject.place(4, 4, 'SOUTH')
        subject.place(0, 0, 'SOUTH')

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

  describe '#report' do
    it 'returns turtle coordinates and direction' do
      subject.place(4, 4, 'SOUTH')

      expect(subject.report).to eq({x: 4, y: 4, direction: 'SOUTH'})
    end
  end
end
