require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_and_belong_to_many(:movies) }

  it "has a valid factory" do
    expect(build(:category)).to be_valid
  end
end
