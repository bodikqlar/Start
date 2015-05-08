require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to have_many(:movies) }

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end
end
