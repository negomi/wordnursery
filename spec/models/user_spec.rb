require 'spec_helper'

describe User do

  it "can be instantiated" do
    User.new.should be_an_instance_of(User)
  end

  it "can be saved successfully" do
    User.create.should be_persisted
  end

  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:password) }

end
