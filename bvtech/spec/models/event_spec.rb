RSpec.describe Event, type: :model do
  context 'create invalid model' do
    subject { event.save! }
    let(:event) { build :event }

    %i[name due_date].each do |attr|
      context "without presence of #{attr}" do
        it 'raises error' do
          event.update("#{attr}": nil)
          expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end

    context 'with non-unique name' do
      let(:event1) { create :event, name: 'Very good event' }
      let(:event2) { build :event, name: 'Very good event' }

      it 'raises error' do
        event1
        expect { event2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
