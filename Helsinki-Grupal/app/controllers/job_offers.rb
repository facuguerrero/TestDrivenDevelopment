JobVacancy::App.controllers :job_offers do

  get :my do
    JobOffer.expire_all
    @offers = JobOffer.find_by_owner(current_user)
    render 'job_offers/my_offers'
  end

  get :index do
    @offers = JobOffer.all
    render 'job_offers/list'
  end

  get :new do
    @job_offer = JobOffer.new
    render 'job_offers/new'
  end

  get :latest do
    JobOffer.expire_all
    @offers = JobOffer.all_active
    render 'job_offers/list'
  end

  get :edit, :with =>:offer_id  do
    @job_offer = JobOffer.get(params[:offer_id])
    # ToDo: validate the current user is the owner of the offer
    render 'job_offers/edit'
  end

  get :apply, :with =>:offer_id  do
    @job_offer = JobOffer.get(params[:offer_id])
    @job_application = JobApplication.new
    # ToDo: validate the current user is the owner of the offer
    render 'job_offers/apply'
  end

  post :search do
    @offers = get_offers_matching(params[:q])
    render 'job_offers/list'
  end


  post :apply, :with => :offer_id do
    @job_offer = JobOffer.get(params[:offer_id])
    @job_offer.add_candidate
    if @job_offer.save
      flash[:success] = 'Offer Saved'
    else
      flash.now[:error] = 'Error saving the offer'
    end
    applicant_email = params[:job_application][:applicant_email]
    @job_application = JobApplication.create_for(applicant_email, @job_offer)
    @job_application.process
    flash[:success] = 'Contact information sent.'
    redirect '/job_offers'
  end

  post :create do

    #validate params

    experience = params[:job_offer][:experience]
    params[:job_offer][:experience] = experience.to_i

    salary = params[:job_offer][:salary]
    params[:job_offer][:salary] = salary.to_i


    #validate dafault
    if experience == ''
      experience = nil
      params[:job_offer][:experience] = nil
    end
    if salary == ''
      salary = nil
      params[:job_offer][:salary] = nil
    end

    #new job offer
    @job_offer = JobOffer.new(params[:job_offer])
    @job_offer.owner = current_user
    @job_offer.activate

    if not experience.nil? and JobOffer.more_than_max_experience?(experience.to_i)
      flash.now[:error] = 'Years of experience is too big'
      render 'job_offers/new'
    elsif not salary.nil? and JobOffer.more_than_max_salary?(salary.to_i)
      flash.now[:error] = 'Salary is too big'
      render 'job_offers/new'
    elsif not numeric_or_nil?(experience) or not @job_offer.experience_is_valid?
      flash.now[:error] = 'Years of experience must be a positive number'
      render 'job_offers/new'
    elsif not numeric_or_nil?(salary) or not @job_offer.salary_is_valid?
      flash.now[:error] = 'Salary must be a positive number'
      render 'job_offers/new'
    elsif @job_offer.save
      flash[:success] = 'Offer created'
      redirect '/job_offers/my'
    else @job_offer.save
      flash.now[:error] = 'Title is mandatory'
      render 'job_offers/new'
    end

  end

  post :update, :with => :offer_id do

    @job_offer = JobOffer.get(params[:offer_id])

    #old values
    old_experience = @job_offer.experience
    old_salary = @job_offer.salary

    #new values
    experience = params[:job_offer][:experience]
    params[:job_offer][:experience] = experience.to_i
    salary = params[:job_offer][:salary]
    params[:job_offer][:salary] = salary.to_i
    #validate dafault
    if experience == ''
      experience = nil
      params[:job_offer][:experience] = nil
    end
    if salary == ''
      salary = nil
      params[:job_offer][:salary] = nil
    end

    if not experience.nil? and JobOffer.more_than_max_experience?(experience.to_i)
      flash.now[:error] = 'Years of experience is too big'
      render 'job_offers/edit'
    elsif not salary.nil? and JobOffer.more_than_max_salary?(salary.to_i)
      flash.now[:error] = 'Salary is too big'
      render 'job_offers/edit'
    else
      @job_offer.update(params[:job_offer])

      if not numeric_or_nil?(experience) or not @job_offer.experience_is_valid?

        #save the offer to the original state
        @job_offer.experience = old_experience
        @job_offer.salary = old_salary
        @job_offer.save

        flash.now[:error] = 'Years of experience must be a positive number'
        render 'job_offers/edit'

      elsif not numeric_or_nil?(salary) or not @job_offer.salary_is_valid?

        #save the offer to the original state
        @job_offer.salary = old_salary
        @job_offer.save

        flash.now[:error] = 'Salary must be a positive number'
        render 'job_offers/edit'

      elsif @job_offer.save
        flash[:success] = 'Offer updated'
        redirect '/job_offers/my'
      else
        flash.now[:error] = 'Title is mandatory'
        render 'job_offers/edit'
      end
    end
  end


  put :activate, :with => :offer_id do
    @job_offer = JobOffer.get(params[:offer_id])
    @job_offer.activate
    if @job_offer.save
      flash[:success] = 'Offer activated'
      redirect '/job_offers/my'
    else
      flash.now[:error] = 'Operation failed'
      redirect '/job_offers/my'
    end
  end

  delete :destroy do
    @job_offer = JobOffer.get(params[:offer_id])
    if @job_offer.destroy
      flash[:success] = 'Offer deleted'
    else
      flash.now[:error] = 'Title is mandatory'
    end
    redirect 'job_offers/my'
  end

  post :complete, :with => :offer_id do
    @job_offer = JobOffer.get(params[:offer_id])
    @job_offer.update_status(params[":status"])
    @job_offer.save
    redirect 'job_offers/my'
  end

  get :complete, :with =>:offer_id  do
    @job_offer = JobOffer.get(params[:offer_id])
    render 'job_offers/complete'
  end

end
