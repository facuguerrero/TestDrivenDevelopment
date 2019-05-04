# Helper methods defined here can be accessed in any controller or view in the application

JobVacancy::App.helpers do
  # def simple_helper_method
  #  ...
  # end

  def get_offers_matching(query)
    query = replace_accent_marks(query.downcase)
    title = JobOffer.all(:conditions => [ "lower(title) like ?", "%#{query}%" ])
    location = JobOffer.all(:conditions => [ "lower(location) like ?", "%#{query}%" ])
    description  = JobOffer.all(:conditions => [ "lower(description) like ?", "%#{query}%" ])
    merge_offers title, location, description
  end

  def replace_accent_marks(query)
    query.tr('á', 'a').tr('é', 'e').tr('í', 'i').tr('ó', 'o').tr('ú', 'u')
  end

  def merge_offers(one, two, three)
    sum = add_elements(one, two)
    add_elements(sum, three)
  end

  def numeric_or_nil?(entry)
    entry.to_i.to_s == entry or entry.nil?
  end

  def add_elements(sum, array)
    array.each do |element|
      if sum.include? element
        next
      else
        sum.insert(0, element)
      end
    end
    sum
  end
end
