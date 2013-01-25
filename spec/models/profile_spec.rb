require 'spec_helper'

describe Profile do
  let(:user) { FactoryGirl.create(:user) }
  before { @profile = user.build_profile(sex: true,
                                         hometown: 'hunan',
                                         location: 'beijing',
                                         hobby: 'basketball',
                                         style: 'handsome')}

  subject { @profile }

  it { should respond_to(:sex) }
  it { should respond_to(:location) }
  it { should respond_to(:hometown) }
  it { should respond_to(:status) }
  it { should respond_to(:avatar) }
  it { should respond_to(:hobby) }
  it { should respond_to(:style) }
  it { should respond_to(:lover_style) }
  it { should respond_to(:description) }
  it { should respond_to(:birthday) }
  it { should respond_to(:school) }
  it { should respond_to(:school) }
  it { should respond_to(:musical_instruments) }
  it { should respond_to(:books) }
  it { should respond_to(:sports) }
  it { should respond_to(:music) }
  it { should respond_to(:movie) }
  it { should respond_to(:animation) }
  it { should respond_to(:games) }
  it { should respond_to(:telephone) }
  it { should respond_to(:msn) }
  it { should respond_to(:qq) }
  it { should respond_to(:email) }
  it { should respond_to(:user_id) }

  its(:user) { should == user }
  it { should be_valid }

  describe "when user_id is nil" do
    before { @profile.user_id = nil }
    it { should_not be_valid }
  end

  describe "when something required is nil" do
    before { @profile.sex = nil }
    it { should_not be_valid }
  end

  describe "with style is too long" do
    before { @profile.style = "a"*21 }
    it { should_not be_valid}
  end

  describe "with lover_style is too long" do
    before { @profile.lover_style = "a"*21 }
    it { should_not be_valid}
  end
end
