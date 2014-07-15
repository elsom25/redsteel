class TwitterDataScraper < DataScraper
  def update_user
    set_location
  end

protected

  def address
    twitter_location = data['extra']['raw_info']['location']
    @address = AddressGetter.new(twitter_location).address if @address.blank?
    @address
  end
end
