class Fixnum
  # Fixnum#hash already implemented for you
end

class Array

  def hash
    code = 0
    self.each_with_index do |el, idx|
      if el.is_a?(Integer)
        code *= Math.sqrt(el)
        code += (el + idx)
      elsif el.is_a?(String)
        code += el.hash
      elsif el.is_a?(Symbol)
        code += el.to_s.hash
      end
    end

    code.to_i
  end





  # [1,2,3].hash => 38742875023599
  # def hash
  #   if @store.any? { |k,v| k == self }
  #     self.find_key # => @store[[1,2,3]]
  #   else
  #     val = rand(10_000_000)
  #     @store << [self, val]
  #   end
  # end
  #
  # def find_key
  #   @store.each do |k, v|
  #     return v if k == self
  #   end
  # end

end

class String

  def hash
    code = 0

    ords = self.each_char.map(&:ord)
    ords.each_with_index do |ord, idx|
      code *= Math.sqrt(ord)
      code += (ord + idx)
    end

    code.to_i
  end

end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    pairs = []
    code = 0

    self.each do |k,v|
      pairs << [k,v]
    end

    pairs.each { |subarray| code += subarray.hash }

    code
  end
end
