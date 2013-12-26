

require 'spec_helper'
  describe User do

  describe "passwords" do
    it "needs a password and confirmation to save" do
      u = User.new(name: "devuser", email: "devuser@example.com")

      u.save
      expect(u).to_not be_valid

      u.password = "password"
      u.password_confirmation = ""
      u.save
      expect(u).to_not be_valid

      u.password_confirmation = "password"
      u.save
      expect(u).to be_valid
    end

    it "needs password and confirmation to match" do
      u = User.create(
            name: "devuser",
            password: "good_password",
            email: "devuser@example.com",
            password_confirmation: "bad_password")
      expect(u).to_not be_valid
    end

    it "requires an email" do
      u = User.new(name: "someuser",
                   password: "password9",
                   password_confirmation: "password9")
      u.save
      expect(u).to_not be_valid
      u.email = "someuser@example.com"
      u.save
      expect(u).to be_valid
    end
  end


  describe "authentication" do
    let(:user) { User.create( name: "diddy",
                              password: "badboy",
                              email: "devuser@example.com",
                              password_confirmation: "badboy") 
                }

    it "authenticates with a correct password" do
      expect(user.authenticate("badboy")).to be
    end

    it "does not authenticate with an incorrect password" do
      expect(user.authenticate("deathrow")).to_not be
    end 
  end
end