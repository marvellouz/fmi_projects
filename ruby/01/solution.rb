class Array
  
  def to_hash
    self.inject({}){|h,x| k,v = x ; h[k]=v ; h }
  end

  def index_by
    result={}
    self.each do |item|
      result[yield(item)] = item
    end
    result
  end

  def subarray_count(subarray)
    count=0
    (0..self.size).each do |i|
      next if self[i ... i+subarray.size] != subarray
      count += 1
    end
    count
  end

  def occurences_count
    result = {}
    self.each do |item|
      if result.has_key?(item)
        result[item] += 1
      else
        result[item] = 1
      end
    end
    result.default = 0
    result
  end

end
