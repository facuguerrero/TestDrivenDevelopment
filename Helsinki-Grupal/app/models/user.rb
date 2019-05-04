class User
  include DataMapper::Resource

  DAWN_OF_TIMES = '1970-01-01 00:00:00'
  ONE_DAY = 1.0

  property :id, Serial
  property :name, String
  property :crypted_password, String
  property :email, String
  property :login_tries, Integer, :default => 0
  property :lock_deadline, DateTime, :default => DateTime.parse(DAWN_OF_TIMES)
  has n, :job_offers

  validates_presence_of :name
  validates_presence_of :crypted_password
  validates_presence_of :email
  validates_format_of   :email, :with => :email_address

  def password=(password)
    self.crypted_password = ::BCrypt::Password.create(password) unless password.nil?
  end

  def self.find(email)
    User.find_by_email(email)
  end

  def authenticate(password)
    if has_password?(password) and not locked?
      reset_login_tries
      true
    else
      if self.login_tries >= 3 and not locked?
        reset_login_tries
      end
      add_login_try
      false
    end
  end

  def reset_login_tries
    self.login_tries = 0
    self.lock_deadline = DAWN_OF_TIMES
  end

  def add_login_try
    self.login_tries += 1
    if self.login_tries == 3
      self.lock_deadline = DateTime.now + ONE_DAY
    end
  end

  def locked?
    self.lock_deadline > DateTime.now
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

  def valid_password?(password)
    /^(?=.*[A-Z])(?=.*\d)(?=.*[a-z])[a-zA-Z\d]{8,}.*$/ =~ password ? true : false
  end

end
