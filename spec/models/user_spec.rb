require "rails_helper"

RSpec.describe User, type: :model do
  describe "#description" do
    it "should display name and email" do
      user = User.new(
        name: "Felipe Silva",
        email: "felipe@gmail.com",
      )

      result = user.description

      expect(result).to eq("Felipe Silva - felipe@gmail.com")
    end
  end
end
