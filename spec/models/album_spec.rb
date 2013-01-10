#encoding: utf-8
require 'spec_helper'

describe Album do
  let(:user) { FactoryGirl.create(:user) }

  before { @album = user.albums.build(name: "album1",
                                     description: "张家界之旅")}

  subject { @album }
  
  it { should be_valid}

  
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }

  describe "when name is not present" do
    before { @album.name = nil }
    it { should_not be_valid }
  end

  describe "when user_id is not present" do
    before { @album.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "with description is too long" do
    before { @album.description = "a"*201 }
    it { should_not be_valid }
  end
end
