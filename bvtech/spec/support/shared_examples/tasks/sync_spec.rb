RSpec.shared_examples 'synchronizing to the DB' do
  let(:sport) { create :sport }

  context 'havin empty database' do
    it 'synchronizes the data to DB' do
      subject
      expect(Sport.all.pluck(:name, :external_id)).to eq([['Handball', 1100], ['Football', 240]])
    end
  end

  context 'having non-empty database with no collision' do
    it 'synchronizes the data to DB' do
      sport
      subject

      expect(Sport.all.pluck(:name, :external_id)).to eq([[sport.name, sport.external_id],['Handball', 1100], ['Football', 240]])
    end
  end

  context 'having non-empty database with full-collision' do
    let(:response) { [{ id: sport.external_id, description: sport.name }, { id: 240, description: 'Football'}] }

    it 'synchronizes the data to DB' do
      subject
      expect(Sport.all.pluck(:name, :external_id)).to eq([[sport.name, sport.external_id], ['Football', 240]])
    end
  end

  context 'having non-empty database with multiple full-collision' do
    let(:sport_inactive) { create :sport, name: sport.name, external_id: sport_external_id-1, active: false }
    let(:response) { [{ id: sport.external_id-1, description: sport.name }, { id: 240, description: 'Football'}] }

    it 'synchronizes the data to DB' do
      subject
      expect(Sport.all.pluck(:name, :external_id, :active)).to eq([
        [sport.name, sport.external_id, false],
        [sport.name, sport.external_id-1, true],
        ['Football', 240, true]
      ])
    end
  end

  context 'having non-empty database with name-collision' do
    let(:response) { [{ id: sport.external_id+1, description: sport.name }] }

    it 'synchronizes the data to DB' do
      subject

      expect(Sport.all.pluck(:name, :external_id)).to eq([
        [sport.name, sport.external_id],
        [sport.name, sport.external_id+1]
      ])

      expect(Sport.active.pluck(:external_id)).to eq([sport.external_id+1])
    end
  end

  context 'having non-empty database with external_id-collision' do
    let(:response) { [{ id: sport.external_id, description: "#{sport.name} Ultra" }] }

    it 'raises error' do
      expect { subject }.to raise_error
    end
  end
end

