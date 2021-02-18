RSpec.shared_examples 'synchronizing to the DB' do
  let(:sport) { create :sport }

  context 'havin empty database' do
    xit 'synchronizes the data to DB' do
      subject
      expect(Sport.all.pluck(:name, :external_id)).to eq([['Handball', 1100], ['Football', 240]])
    end
  end

  context 'having non-empty database with no collision' do
    xit 'synchronizes the data to DB' do
      sport
      subject

      expect(Sport.all.pluck(:name, :external_id)).to eq([[sport.name, sport.external_id],['Handball', 1100], ['Football', 240]])
    end
  end

  context 'having non-empty database with full-collision' do
    let(:response) { [{ id: sport.external_id, description: sport.name }, { id: 240, description: 'Football'}] }

    xit 'synchronizes the data to DB' do
      subject
      expect(Sport.all.pluck(:name, :external_id)).to eq([[sport.name, sport.external_id], ['Football', 240]])
    end
  end

  context 'having non-empty database with name-collision' do
    let(:response) { [{ id: sport.external_id+1, description: sport.name }] }

    xit 'synchronizes the data to DB' do
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

    xit 'raises error' do
      expect { subject }.to raise_error
    end
  end
end

