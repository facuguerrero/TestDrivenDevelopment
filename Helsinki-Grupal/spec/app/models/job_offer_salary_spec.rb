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

	end

	describe 'valid?' do

		let(:job_offer) do
			user = User.new
			user.id = 1
			job_offer = JobOffer.new
			job_offer.owner = user
			job_offer
		end

		it 'should be true when salary is blank' do
      job_offer.title = 'the title'
      expect(job_offer.valid?).to eq true
		end

		it 'should be true when salary is not blank' do
      job_offer.title = 'the title'
      job_offer.salary = 3
      expect(job_offer.valid?).to eq true
		end

		it 'should be 30 when adding 30 salary' do
      job_offer.title = 'the title'
      job_offer.salary = 30
      expect(job_offer.salary).to eq 30
		end

		it 'should be DEFAULT_SALARY when salary is not specified' do
      job_offer.title = 'the title'
      expect(job_offer.salary).to eq nil
    end

    it 'should be true when salary is 4000' do
      job_offer.title = 'the title'
      job_offer.salary = 4000
      expect(job_offer.salary_is_valid?).to eq true
    end

    it 'should be false when salary is -4' do
      job_offer.title = 'the title'
      job_offer.salary = -4
      expect(job_offer.salary_is_valid?).to eq false
    end

	end

end

