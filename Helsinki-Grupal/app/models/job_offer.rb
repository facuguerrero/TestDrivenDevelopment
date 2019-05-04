MAX_SALARY = 2147483647
MAX_EXPERIENCE = 30

class JobOffer
  include DataMapper::Resource

  ACTIVE = 0
  EXPIRED = 1
  HIRED_IN = 2
  HIRED_OUT = 3
  CLOSED = 4

  property :id, Serial
  property :title, String
  property :location, String
  property :description, String
  property :created_on, Date
  property :updated_on, Date
  property :is_active, Boolean, :default => true
  property :experience, Integer
  property :salary, Integer
  property :candidates_number, Integer, :default => 0
  property :status, Integer, :default => ACTIVE
  belongs_to :user

  validates_presence_of :title

  def owner
    user
  end

  def owner=(a_user)
    self.user = a_user
  end

  def update_status(status)
    self.status = status
  end

  def self.all_active
    JobOffer.all(:status => ACTIVE)
  end

  def creation_date(date = DateTime.now)
    self.created_on = date
  end

  def self.find_by_owner(user)
    JobOffer.all(:user => user)
  end

  def activate
    self.created_on = DateTime.now
  end

  def add_candidate
    self.candidates_number = self.candidates_number + 1
  end

  def experience_is_valid?
    @experience.nil? or @experience >= 0
  end

  def experience_is_default?
    @experience.nil?
  end

  def salary_is_valid?
    @salary.nil? or @salary >= 0
  end

  def salary_is_default?
    @salary.nil?
  end

  def self.more_than_max_experience?(experience)
    experience > MAX_EXPERIENCE
  end

  def self.more_than_max_salary?(salary)
    salary > MAX_SALARY
  end

  def candidates_number_is_valid?
    @candidates_number >= 0
  end

  def self.expire_all
    offers = JobOffer.all(:created_on.lt => 1.month.ago)
    offers.each do |offer|
      offer.status = EXPIRED
      offer.save
    end
  end

end