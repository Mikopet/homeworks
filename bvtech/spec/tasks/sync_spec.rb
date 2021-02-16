describe 'rake sync:sports', type: :task do
  it "preloads the Rails environment" do
    expect(task.prerequisites).to include "environment"
  end

  xit "raises without arguments" do
    expect { task.execute }.to raise_error
  end
end
