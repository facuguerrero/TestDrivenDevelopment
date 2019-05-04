require 'spec_helper'

describe User do

  describe 'model' do

    subject {@user = User.new}

    it {should respond_to(:id)}
    it {should respond_to(:name)}
    it {should respond_to(:crypted_password)}
    it {should respond_to(:email)}
    it {should respond_to(:job_offers)}
    it {should respond_to(:login_tries)}
    it {should respond_to(:lock_deadline)}

  end

  describe 'valid?' do

    let(:user) {User.new}

    it 'should be false when name is blank' do
      user.email = 'john.doe@someplace.com'
      user.password = 'a_secure_passWord!'
      expect(user.valid?).to eq false
    end

    it 'should be false when email is not valid' do
      user.name = 'John Doe'
      user.email = 'john'
      user.password = 'a_secure_passWord!'
      expect(user.valid?).to eq false
    end

    it 'should be false when password is blank' do
      user.name = 'John Doe'
      user.email = 'john.doe@someplace.com'
      expect(user.valid?).to eq false
    end

    it 'should be true when all field are valid' do
      user.name = 'John Doe'
      user.email = 'john.doe@someplace.com'
      user.password = 'a_secure_passWord!'
      expect(user.valid?).to eq true
    end

  end

  describe 'password' do

    before do
      @user = User.new
    end

    it 'should be true when password is correct' do
      password = 'a2A4567890'
      expect(@user.valid_password? password).to eq true
    end

    it 'should be false when missing uppercase letter' do
      password = 'a234567890'
      expect(@user.valid_password? password).to eq false
    end

    it 'should be false when missing number' do
      password = 'aAbBcCdDeE'
      expect(@user.valid_password? password).to eq false
    end

    it 'should be false when missing lowercase letter' do
      password = '1A3B5C7D9E'
      expect(@user.valid_password? password).to eq false
    end

    it 'should be false when shorter than 10 chars' do
      password = 'a1Bdc3'
      expect(@user.valid_password? password).to eq false
    end

  end

  describe 'find' do

    before do
      @user = User.new
      @user.email = 'john.doe@someplace.com'
    end

    it 'should return nil when email do not match' do
      email = 'wrong@email.com'
      User.should_receive(:find_by_email).with(email).and_return(nil)
      User.find(email).should be_nil
    end

  end

  describe 'authenticate' do

    before do
      @password = 'password'
      @user = User.new
      @user.email = 'john.doe@someplace.com'
      @user.password = @password
      @user.login_tries = 0
      @user.lock_deadline = DateTime.parse('1970-01-01 00:00:00')
    end

    it 'should return false when password do not match' do
      password = 'wrong_password'
      @user.authenticate(password).should eq false
    end

    it 'should return the user when email and password match' do
      @user.authenticate(@password).should eq true
    end

    it 'should add to login tries when password is wrong' do
      password = 'wrong_password'
      @user.authenticate(password).should eq false
      @user.authenticate(password).should eq false
      expect(@user.login_tries).to eq 2
    end

    it 'should reset login tries after successful login when password is right' do
      @user.login_tries = 2
      @user.authenticate(@password).should eq true
      expect(@user.login_tries).to eq 0
    end

    it 'should update deadline when third failing login is made' do
      password = 'wrong_password'
      @user.authenticate(password).should eq false
      @user.authenticate(password).should eq false
      @user.authenticate(password).should eq false
      expect(@user.lock_deadline).not_to eq DateTime.parse('1970-01-01 00:00:00')
    end

    it 'should not update deadline when a login failure is not the third' do
      password = 'wrong_password'
      @user.authenticate(password).should eq false
      @user.authenticate(password).should eq false
      expect(@user.lock_deadline).to eq DateTime.parse('1970-01-01 00:00:00')
    end

  end

  describe 'locked?' do

    before do
      @user = User.new
      @user.email = 'john.doe@someplace.com'
    end

    it 'should not be locked if now is more than one day after locking deadline' do
      @user.lock_deadline = DateTime.now - 2
      expect(@user.locked?).to be false
    end

    it 'should not be locked if deadline is within a day from now' do
      @user.lock_deadline = DateTime.now + 0.5
      expect(@user.locked?).to be true
    end

  end

end

