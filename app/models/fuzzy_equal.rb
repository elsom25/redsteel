module FuzzyEqual
  def self.equal?(a, b)
    a.to_h
    b.to_h
    a.keys.all? { |k| a[k] == b[k] || b[k].nil? || a[k].nil? }
  end
end
