require 'rails_helper'

RSpec.describe Movie, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_and_belong_to_many(:categories) }
  it { is_expected.to belong_to(:user) }

  it "has a valid factory" do
    expect(build(:movie)).to be_valid
  end
end
