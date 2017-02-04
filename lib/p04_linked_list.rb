require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next.prev = @prev
    @next, @prev = nil, nil
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    link(@head, @tail)
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    find_link(key).val
  end

  def include?(key)
    !get(key).nil?
  end

  def append(key, val)
    new_link = Link.new(key, val)
    link(last, new_link)
    link(new_link, @tail)
  end

  def update(key, val)
    find_link(key).val = val
  end

  def remove(key)
    target_link = find_link(key)
    link(target_link.prev, target_link.next)
  end

  def each
    current_link = first
    until current_link.key.nil?
      yield(current_link)
      current_link = current_link.next
    end
  end

  def link(parent, child)
    child.prev = parent
    parent.next = child
  end

  def find_link(key)
    each { |link| return link if link.key == key }
    @tail
  end


  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
