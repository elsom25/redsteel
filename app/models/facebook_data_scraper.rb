class FacebookDataScraper < DataScraper

  def update_user
    set_location
    # set_date_of_birth
    set_gender
  end

protected

  # def set_date_of_birth
  #   return if self.user.dob
  #   dob = data['extra']['raw_info']['birthday']
  #   self.user.dob = Date.strptime(dob, "%m/%d/%Y") if dob
  # end

  def set_gender
    return if @user.gender
    gender = data['extra']['raw_info']['gender']
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
    facebook_location_id = data['extra']['raw_info']['location']['id'].to_i
    facebook_location = JSON.parse(open("https://graph.facebook.com/#{facebook_location_id}").read)
    latitude = facebook_location['location']['latitude']
    longitude = facebook_location['location']['longitude']

    @address ||= AddressGetter.new("#{latitude}, #{longitude}").address
  end
end
