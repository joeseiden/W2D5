require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    code = key.hash
    # self[code] << key unless self.include?(key)
    unless self.include?(key)
      resize! if @count == num_buckets
      @count += 1
      self[code] << key
    end

  end

  def include?(key)
    code = key.hash
    self[code].include?(key)
  end

  def remove(key)
    code = key.hash
    @count -= 1 if self.include?(key)
    self[code].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    index = num % num_buckets
    @store[index]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    old_store.each do |bucket|
      bucket.each do |el|
        self.insert(el)
      end
    end
  end
end
