RSpec.describe Market, type: :model do
  context 'create invalid model' do
    subject { market.save! }
    let(:market) { build :market }

    %i[name].each do |attr|
      context "without presence of #{attr}" do
        it 'raises error' do
          market.update("#{attr}": nil)
          expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end

    context 'with non-unique name' do
      let(:market1) { create :market, name: 'Very good market' }
      let(:market2) { build :market, name: 'Very good market' }

      it 'raises error' do
        market1
        expect { market2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end

