require 'spec_helper'

describe JobOffer do

  describe 'model' do

    subject {@job_offer = JobOffer.new}

    it {should respond_to(:id)}
    it {should respond_to(:title)}
    it {should respond_to(:location)}
    it {should respond_to(:description)}
    it {should respond_to(:owner)}
    it {should respond_to(:owner=)}
    it {should respond_to(:created_on)}
    it {should respond_to(:updated_on)}
    it {should respond_to(:is_active)}

  end

  describe 'valid?' do

    let(:job_offer) do
      user = User.new
      user.id = 1
      job_offer = JobOffer.new
      job_offer.owner = user
      job_offer
    end

    it 'should be true when number of candidates is blank' do
      job_offer.title = 'Dev'
      expect(job_offer.valid?).to eq true
    end

    it 'should be true when number of candidates is not blank' do
      job_offer.title = 'Dev'
      job_offer.candidates_number = 2
      expect(job_offer.valid?).to eq true
    end

    it 'should be 5 when adding 5 candidates' do
      job_offer.title = 'Dev'
      job_offer.candidates_number = 5
      expect(job_offer.candidates_number).to eq 5
    end

    it 'should be 0 when nobody applies ' do
      job_offer.title = 'Dev'
      expect(job_offer.candidates_number).to eq 0
    end

    it 'should be true when candidates number is a 3' do
      job_offer.title = 'Dev'
      job_offer.candidates_number = 3
      expect(job_offer.candidates_number_is_valid?).to eq true
    end

    it 'should be false when experience is -4' do
      job_offer.title = 'Dev'
      job_offer.candidates_number = -4
      expect(job_offer.candidates_number_is_valid?).to eq false
    end

    it 'candidates_number should be 1 after call add_applicant when candidates number was 0 ' do
      job_offer.title = 'Dev'
      job_offer.candidates_number = 0
      job_offer.add_candidate
      expect(job_offer.candidates_number).to eq 1
    end

  end

end

