class FacebookDataScraper < DataScraper
  def update_user
    set_name
    set_gender
    set_location
    # set_date_of_birth
  end

protected

  def raw_info
    data['extra']['raw_info']
  end

  def set_name
    @user.given_name ||= raw_info['first_name']
    @user.family_name ||= raw_info['last_name']
  end

  def set_gender
    return if @user.gender
    gender = raw_info['gender']
    @user.gender = case gender
      when 'male'
        User::MASCULINE
      when 'female'
        User::FEMININE
      else
        gender
    end
  end

  def address
    facebook_location_id = raw_info['location']['id'].to_i
    facebook_location = JSON.parse(open("https://graph.facebook.com/#{facebook_location_id}").read)['location']
    latitude = facebook_location['latitude']
    longitude = facebook_location['longitude']

    @address ||= AddressGetter.new("#{latitude}, #{longitude}").address
  end

  # def set_date_of_birth
  #   return if self.user.dob
  #   dob = raw_info['birthday']
  #   self.user.dob = Date.strptime(dob, "%m/%d/%Y") if dob
  # end
end
