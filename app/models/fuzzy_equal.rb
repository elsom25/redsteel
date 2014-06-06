module FuzzyEqual
  def self.equal?(left, right)
    left.to_h
    right.to_h
    left.keys.all?{ |key| left[key] == right[key] || right[key].nil? || left[key].nil? }
  end
end
