require 'spec_helper'

describe JobOffer do

  describe 'model' do

    subject { @job_offer = JobOffer.new }

    it { should respond_to( :id) }
    it { should respond_to( :title ) }
    it { should respond_to( :location) }
    it { should respond_to( :description ) }
    it { should respond_to( :owner ) }
    it { should respond_to( :owner= ) }
    it { should respond_to( :created_on) }
    it { should respond_to( :updated_on ) }
    it { should respond_to( :is_active) }
    it { should respond_to( :status ) }

  end

  describe 'valid?' do

    let(:job_offer) do
      user = User.new
      user.id = 1
      job_offer = JobOffer.new
      job_offer.owner = user
      job_offer
    end

    it 'should be false when title is blank' do
      expect(job_offer.valid?).to eq false
    end

    it 'should be true when title is not blank' do
      job_offer.title = 'the title'
      expect(job_offer.valid?).to eq true
    end

  end

  describe 'expiration' do

    let(:job_offer) do
      user = User.new
      user.id = 1
      job_offer = JobOffer.new
      job_offer.owner = user
      job_offer.status = 0
      job_offer
    end

    it 'should be 0 when created' do
      expect(job_offer.status).to eq 0
    end

    it 'should be 1 when set' do
      job_offer.status = 1
      expect(job_offer.status).to eq 1
    end

    it 'should be 2 when set' do
      job_offer.status = 2
      expect(job_offer.status).to eq 2
    end

    it 'should be 3 when set' do
      job_offer.status = 3
      expect(job_offer.status).to eq 3
    end

    it 'should be 4 when set' do
      job_offer.status = 4
      expect(job_offer.status).to eq 4
    end

  end

end
