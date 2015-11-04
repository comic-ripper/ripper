class UnsafeJSON
  def self.dump(obj)
    JSON.dump(obj)
  end

  def self.load(json)
    JSON.load(json)
  end
end
