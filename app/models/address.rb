class Address
  vattr_initialize :locality, :region, :country_name

  def blank?
    [@locality, @region, @country_name].all?(&:blank?)
  end

  def present?
    not blank?
  end
end
