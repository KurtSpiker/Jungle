require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "it is a valid user" do
      @user = User.new(first_name: "Creg", last_name: "Smith", email: "cregS@mail.com", password: "123456789", password_confirmation: "123456789")
      @user.save
      expect(@user).to be_valid
    end

    it "it is invalid without a first name entered" do
      @user = User.new(first_name: nil, last_name: "Smith", email: "cregS@mail.com", password: "123456789", password_confirmation: "123456789")
      @user.save
      expect(@user).to_not be_valid
    end

    it "it is invalid without a last name" do
      @user = User.new(first_name: "Creg", last_name: nil, email: "cregS@mail.com", password: "123456789", password_confirmation: "123456789")
      @user.save
      expect(@user).to_not be_valid
    end

    it "it is invalid without an email" do
      @user = User.new(first_name: "Creg", last_name: "Smith", email: nil, password: "123456789", password_confirmation: "123456789")
      @user.save
      expect(@user).to_not be_valid
    end

    it "it is invalid without a password" do
      @user = User.new(first_name: "Creg", last_name: "Smith", email: "cregS@mail.com", password: nil, password_confirmation: "123456789")
      @user.save
      expect(@user).to_not be_valid
    end

    it "it is invalid without a password confirmation" do
      @user = User.new(first_name: "Creg", last_name: "Smith", email: "cregS@mail.com", password: "123456789", password_confirmation: nil)
      @user.save
      expect(@user).to_not be_valid
    end

      it "it is invalid if password and password confirmation don't match" do
        @user = User.new(first_name: "Creg", last_name: "Smith", email: "cregS@mail.com", password: "123456789", password_confirmation: "87654321")
        @user.save
        expect(@user).to_not be_valid
      end

     it "it is invalid if password is shorter than 5 characters" do
      @user = User.new(first_name: "Creg", last_name: "Smith", email: "cregS@mail.com", password: "1234", password_confirmation: "1234")
      @user.save
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "it should return an authenticated user if given valid email and password" do
      @user = User.new(first_name: "Creg", last_name: "Smith", email: "cregS@mail.com", password: "123456789", password_confirmation: "123456789")
      @user.save

      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
    end

    it "it should not return an authenticated user if user email invalid" do
      @user = User.new(first_name: "Creg", last_name: "Smith", email: "cregS@mail.com", password: "123456789", password_confirmation: "123456789")
      @user.save
      expect(User.authenticate_with_credentials("some_email@mail.com", @user.password)).to be_nil
    end

    it "it should not return an authenticated user if user email invalid" do
      @user = User.new(first_name: "Creg", last_name: "Smith", email: "cregS@mail.com", password: "123456789", password_confirmation: "123456789")
      @user.save
      expect(User.authenticate_with_credentials(@user.email, "some_password")).to be_nil
    end

    it "it should return authenticated user if email case is not exact" do
      @user = User.new(first_name: "Creg", last_name: "Smith", email: "cregS@mail.com", password: "123456789", password_confirmation: "123456789")
      @user.save
      expect(User.authenticate_with_credentials("CREGS@mail.com", @user.password)).to eq(@user)
    end

    it "it should return authenticated user if email has white space" do
      @user = User.new(first_name: "Creg", last_name: "Smith", email: "cregS@mail.com", password: "123456789", password_confirmation: "123456789")
      @user.save
      expect(User.authenticate_with_credentials("  cregS@mail.com  ", @user.password)).to eq(@user)
    end
  end
end