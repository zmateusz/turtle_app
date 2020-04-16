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

  describe '#place_turtle' do
    it 'places turtle on given field' do
      subject.place_turtle(4, 4, 'SOUTH')

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
        subject.place_turtle(4, 4, 'SOUTH')
        subject.place_turtle(0, 4, 'NORTH')

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

      context 'when trying to place outside the table' do
        it 'raises IncorrectPlace' do
          expect { subject.place_turtle(5, 4, 'NORTH') }
            .to raise_error(TurtleApp::IncorrectPlace, 'Incorrect place')
        end
      end

      context 'when trying to place with incorrect direction' do
        it 'raises IncorrectDirection' do
          expect { subject.place_turtle(4, 4, 'BAR') }
            .to raise_error(TurtleApp::IncorrectDirection, 'Incorrect direction')
        end
      end
    end
  end

  describe '#move_turtle' do
    before { subject.place_turtle(2, 3, direction) }

    context 'when turtle direction is SOUTH' do
      let(:direction) { 'SOUTH' }

      it 'moves turtle one field forward' do
        subject.move_turtle

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
        subject.move_turtle

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
        subject.move_turtle

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
        subject.move_turtle

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
      before { subject.place_turtle(4, 4, direction) }

      context 'when direction is NORTH' do
        let(:direction) { 'NORTH' }

        it 'stays on previous place' do
          subject.move_turtle

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
          subject.move_turtle

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

  describe '#rotate_turtle_left' do
    it 'rotates turtle in left direction' do
      subject.place_turtle(4, 4, 'SOUTH')

      subject.rotate_turtle_left

      expect(subject.turtle).to have_attributes(direction: 'EAST')
    end
  end

  describe '#rotate_turtle_right' do
    it 'rotates turtle in right direction' do
      subject.place_turtle(4, 4, 'WEST')

      subject.rotate_turtle_right

      expect(subject.turtle).to have_attributes(direction: 'NORTH')
    end
  end

  describe '#report' do
    it 'returns turtle coordinates and direction' do
      subject.place_turtle(4, 4, 'SOUTH')

      expect(subject.report).to eq({x: 4, y: 4, direction: 'SOUTH'})
    end

    context 'when turtle is not placed' do
      it 'raises TurtleNotPlaced' do
        expect { subject.report }
          .to raise_error(TurtleApp::TurtleNotPlaced, 'Turtle not placed')
      end
    end
  end

  describe 'test multiple methods scenario' do
    before do
      subject.place_turtle(4, 4, 'SOUTH')
      subject.move_turtle
      subject.rotate_turtle_right
    end

    it 'report returns correct data' do
      expect(subject.report).to eq({x: 4, y: 3, direction: 'WEST'})
    end
  end
end
