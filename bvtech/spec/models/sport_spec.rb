RSpec.describe Sport, type: :model do
  context 'create invalid model' do
    subject { sport.save! }
    let(:sport) { build :sport}

    %i[name external_id].each do |attr|
      context "without presence of #{attr}" do
        it 'raises error' do
          sport.update("#{attr}": nil)
          expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end

    context 'with non-unique external_id' do
      let(:sport1) { create :sport, external_id: 42 }
      let(:sport2) { build :sport, external_id: 42 }

      it 'raises error' do
        sport1
        expect { sport2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'with non-unique name in scope of external_id' do
      let(:sport1) { create :sport, name: 'Brockian Ultra-Cricket', external_id: 42, active: false }
      let(:sport2) { build :sport, name: 'Brockian Ultra-Cricket', external_id: 42 }

      it 'raises error' do
        sport1
        expect { sport2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'with non-unique name both active' do
      let(:sport1) { create :sport, name: 'Brockian Ultra-Cricket', external_id: 42 }
      let(:sport2) { build :sport, name: 'Brockian Ultra-Cricket', external_id: 43 }

      it 'raises error' do
        sport1
        expect { sport2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  context 'create valid model' do
    context 'with non-unique name with inactive old' do
      let(:sport1) { create :sport, name: 'Brockian Ultra-Cricket', external_id: 42, active: false }
      let(:sport2) { build :sport, name: 'Brockian Ultra-Cricket', external_id: 43 }

      it 'raises no error' do
        sport1
        expect { sport2.save! }.to_not raise_error
      end
    end
  end

  context 'calling scope `active`' do
    let!(:sport1) { create :sport }
    let!(:sport2) { create :sport, active: false }

    it 'returns actives only' do
      expect(described_class.active).to eq([sport1])
      expect(described_class.active).to_not eq([sport1, sport2])
    end
  end

  context 'inactivating a record' do
    let(:sport) { create :sport }

    it 'succeeds' do
      sport.inactivate
      expect(sport.active).to be(false)
    end
  end

  context 'activating a record' do
    let(:sport) { create :sport, :inactive }

    it 'succeeds' do
      sport.activate
      expect(sport.active).to be(true)
    end
  end

  context 'reactivating a record' do
    let!(:sport1) { create :sport, name: 'Brockian Ultra-Cricket', external_id: 42, active: false }
    let!(:sport2) { create :sport, name: 'Brockian Ultra-Cricket', external_id: 43 }

    it 'inactivates others' do
      expect { sport1.activate }.to change { sport2.reload.active }.from(true).to(false)
      expect(sport1.active).to be(true)
    end
  end
end

