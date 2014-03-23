class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def days
    %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
  end

  def location_attributes
    {
      :accessibility  => accessibility,
      :address        => address,
      :admins         => admins,
      :contacts       => contacts,
      :description    => params[:description],
      :emails         => emails,
      :faxes          => faxes,
      :hours          => params[:text_hours],
      :kind           => kind,
      :mail_address   => mail_address,
      :name           => location_name,
      :phones         => phones,
      :short_desc     => params[:short_desc],
      :transportation => params[:transportation],
      :urls           => urls
    }
  end

  def service_attributes
    {
      :audience        => params[:audience],
      :eligibility     => params[:eligibility],
      :fees            => params[:fees],
      :how_to_apply    => params[:how_to_apply],
      :keywords        => keywords,
      :service_areas   => service_areas,
      :wait            => params[:wait]
    }
  end

  def accessibility
    params[:accessibility_options]
  end

  def address
    non_state_fields = [params[:street], params[:city], params[:zip]]

    unless non_state_fields.all?(&:empty?)
      {
        :street => params[:street],
        :city => params[:city],
        :state => params[:state],
        :zip => params[:zip]
      }
    end
  end

  def admins
    admins = params[:admins]
    if admins.present? && !admins.all?(&:empty?)
      params[:admins].delete_if { |admin| admin.blank? }
    end
  end

  def contacts
    names = params[:names]
    titles = params[:titles]
    phones = params[:contact_phones]
    extensions = params[:contact_phone_extensions]
    emails = params[:contact_emails]
    faxes = params[:contact_faxes]

    if names.present?
      contacts = []
      (0..names.length).each do |i|
        hash = {
          :name => names[i],
          :title => titles[i],
          :phone => phones[i],
          :extension => extensions[i],
          :email => emails[i],
          :fax => faxes[i]
        }.reject { |_,v| v.blank? }
        contacts.push(hash)
      end
    end
    contacts
  end

  def emails
    params[:emails] unless params[:emails].all?(&:empty?)
  end

  def kind
    params[:kind] unless params[:kind].blank?
  end

  def location_name
    params[:location_name]
  end

  def mail_address
    all_fields = [params[:attention], params[:m_street], params[:m_city], params[:m_state], params[:m_zip]]
    unless all_fields.all?(&:empty?)
      {
        :attention => params[:attention],
        :street => params[:m_street],
        :city => params[:m_city],
        :state => params[:m_state],
        :zip => params[:m_zip]
      }
    end
  end

  def phones
    numbers = params[:number]
    vanity_numbers = params[:vanity_number]
    departments = params[:department]
    extensions = params[:extension]
    hours = params[:hours] unless params[:hours].blank?

    if numbers.present? && !numbers.all?(&:empty?)
      phones = []
      (0..numbers.length).each do |i|
        hash = {
          :number => numbers[i],
          :vanity_number => vanity_numbers[i],
          :extension => extensions[i],
          :department => departments[i],
          :hours => hours[i]
        }.reject { |_,v| v.blank? }
        phones.push(hash)
      end
    end
    phones
  end

  def faxes
    numbers = params[:fax_number]
    departments = params[:fax_department]

    if numbers.present?
      faxes = []
      (0..numbers.length).each do |i|
        hash = {
          :number => numbers[i],
          :department => departments[i],
        }.reject { |_,v| v.blank? }
        faxes.push(hash)
      end
    end
    faxes
  end

  def service_areas
    service_areas = params[:service_areas]
    if service_areas.present? && !service_areas.all?(&:empty?)
      params[:service_areas].delete_if { |sa| sa.blank? }
    else
      []
    end
  end

  # def funding_sources
  #   fs = params[:funding_sources]
  #   if fs.present? && !fs.all?(&:empty?)
  #     params[:funding_sources]
  #   end
  # end

  def keywords
    k = params[:keywords]
    if k.present? && !k.all?(&:empty?)
      params[:keywords].delete_if { |k| k.blank? }
    end
  end

  def urls
    if params[:urls].present? && !params[:urls].all?(&:empty?)
      params[:urls].delete_if { |url| url.blank? }
    end
  end

  def org_id
    params[:org_id]
  end

  def org_name
    params[:org_name]
  end

  def schedule
    # schedule = []
    # days.each_with_index do |day, i|
    #   # h.merge!({ day.downcase.to_sym =>
    #   #   [
    #   #     { :open => params["#{day}_first_open"], :close => params["#{day}_first_close"] },
    #   #     { :open => params["#{day}_sec_open"], :close => params["#{day}_sec_close"] }
    #   #   ]
    #   # })
    #   if params["#{day}_sec_open"].present?
    #     schedule.push(
    #       { :open => params["#{day}_first_open"],
    #         :close => params["#{day}_first_close"],
    #         :day => i.to_i
    #       },
    #       { :open => params["#{day}_sec_open"],
    #         :close => params["#{day}_sec_close"],
    #         :day => i.to_i
    #       }
    #     )
    #   else
    #     schedule.push(
    #       { :open => params["#{day}_first_open"],
    #         :close => params["#{day}_first_close"],
    #         :day => i.to_i
    #       },
    #       { :open => params["#{day}_sec_open"],
    #         :close => params["#{day}_sec_close"],
    #         :day => i.to_i
    #       }
    #     )
    #   end
    # end
  end
end
