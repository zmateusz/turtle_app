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

      expect(subject.turtle).to have_attributes(x: 4, y: 4, direction: 'SOUTH')
      expect(subject.fields.reverse).to eq(
        [
          [nil, nil, nil, nil, 'T'],
          [nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil]
        ]
      )
    end

    context 'when turtle is placed two times' do
      it 'is placed on the latest given field' do
        subject.place(4, 4, 'SOUTH')
        subject.place(0, 4, 'NORTH')

        expect(subject.turtle).to have_attributes(x: 0, y: 4, direction: 'NORTH')
        expect(subject.fields.reverse).to eq(
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

  describe '#move' do
    before { subject.place(2, 3, direction) }

    context 'when turtle direction is SOUTH' do
      let(:direction) { 'SOUTH' }

      it 'moves turtle one field forward' do
        subject.move

        expect(subject.turtle).to have_attributes(x: 2, y: 2)
        expect(subject.fields.reverse).to eq(
          [
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, 'T', nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil]
          ]
        )
      end
    end

    context 'when turtle direction is WEST' do
      let(:direction) { 'WEST' }

      it 'moves turtle one field forward' do
        subject.move

        expect(subject.turtle).to have_attributes(x: 1, y: 3)
        expect(subject.fields.reverse).to eq(
          [
            [nil, nil, nil, nil, nil],
            [nil, 'T', nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil]
          ]
        )
      end
    end

    context 'when turtle direction is NORTH' do
      let(:direction) { 'NORTH' }

      it 'moves turtle one field forward' do
        subject.move

        expect(subject.turtle).to have_attributes(x: 2, y: 4)
        expect(subject.fields.reverse).to eq(
          [
            [nil, nil, 'T', nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil]
          ]
        )
      end
    end

    context 'when turtle direction is EAST' do
      let(:direction) { 'EAST' }

      it 'moves turtle one field forward' do
        subject.move

        expect(subject.turtle).to have_attributes(x: 3, y: 3)
        expect(subject.fields.reverse).to eq(
          [
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, 'T', nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil]
          ]
        )
      end
    end

    context 'when turtle is placed on table corner' do
      before { subject.place(4, 4, direction) }

      context 'when direction is NORTH' do
        let(:direction) { 'NORTH' }

        it 'stays on previous place' do
          subject.move

          expect(subject.turtle).to have_attributes(x: 4, y: 4)
          expect(subject.fields.reverse).to eq(
            [
              [nil, nil, nil, nil, 'T'],
              [nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil]
            ]
          )
        end
      end

      context 'when direction is EAST' do
        let(:direction) { 'EAST' }

        it 'stays on previous place' do
          subject.move

          expect(subject.turtle).to have_attributes(x: 4, y: 4)
          expect(subject.fields.reverse).to eq(
            [
              [nil, nil, nil, nil, 'T'],
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
