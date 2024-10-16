require 'rails_helper'

RSpec.describe Customer, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "** Checks instance_double() and spy()" do
    it "checks user name and email #instance_double" do
      user = instance_double("Customer")
      allow(user).to receive(:name).and_return("ahnaf")
      allow(user).to receive(:email).and_return("ahnaf@welldev.io")
      
      expect(user.name).to eq("ahnaf")
      expect(user.email).to eq("ahnaf@welldev.io")
    end
  
    it "checks password #spy" do
      user = spy("Customer")
      user.pay(100)
      allow(user).to receive(:get_pass).and_return("1234")
  
      expect(user.get_pass).to eq("1234")
      expect(user).to have_received(:pay).with(100)
    end
  end
  
  describe "** Using factory_bot" do
    it "is valid with valid attributes" do
      cust = create(:customer)
      expect(cust).to be_valid
    end

    it "is invalid without a name" do
      cust = build(:customer, name: nil)
      expect(cust).not_to be_valid 
    end
  end


end
