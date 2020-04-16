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

      expect(subject.turtle).to have_attributes(x: 4, y: 4, direction: 'SOUTH')
    end

    context 'when turtle is placed two times' do
      it 'is placed on the latest given field' do
        subject.place(4, 4, 'SOUTH')
        subject.place(0, 4, 'NORTH')

        expect(subject.fields).to eq(
          [
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            ['T', nil, nil, nil, nil]
          ]
        )

        expect(subject.turtle).to have_attributes(x: 0, y: 4, direction: 'NORTH')
      end
    end
  end

  describe '#rotate_left' do
    it 'rotates turtle in left direction' do
      subject.place(4, 4, 'SOUTH')

      subject.rotate_left

      expect(subject.turtle).to have_attributes(direction: 'EAST')
    end
  end

  describe '#rotate_right' do
    it 'rotates turtle in right direction' do
      subject.place(4, 4, 'WEST')

      subject.rotate_right

      expect(subject.turtle).to have_attributes(direction: 'NORTH')
    end
  end

  describe '#report' do
    it 'returns turtle coordinates and direction' do
      subject.place(4, 4, 'SOUTH')

      expect(subject.report).to eq({x: 4, y: 4, direction: 'SOUTH'})
    end
  end
end
