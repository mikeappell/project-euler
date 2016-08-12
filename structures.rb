Node = Struct.new(:data, :next)
BSTNode = Struct.new(:data, :left, :right)

class LinkedList
  attr_accessor :head

  def initialize(data)
    @head = Node.new(data, nil)
  end

  def add(data)
    unless @head
      @head = Node.new(data, nil)
    else
      next_node = head
      while next_node.next
        next_node = next_node.next
      end
      next_node.next = Node.new(data, nil)
    end
  end

  def add_at_index(data, index)
    next_node = head
    (index - 1).times do
      break unless next_node.next
      next_node = next_node.next
    end
    temp = Node.new(data, next_node.next)
    next_node.next = temp
  end

  def get_last
    next_node = head
    while next_node.next
      next_node = next_node.next
    end
    next_node.data
  end

  def get_at_index(index)
    next_node = head
    index.times do
      break unless next_node.next
      next_node = next_node.next
    end
    next_node.data
  end

  def delete_at_index(index)
    return nil if !head || index < 0
    if index == 0
      @head = @head.next
    else
      next_node = head
      (index - 1).times do
        break unless next_node.next
        next_node = next_node.next
      end
      next_node.next = next_node.next.next
    end
  end

  def size
    return 0 unless head
    size = 1
    next_node = head
    while next_node.next
      next_node = next_node.next
      size += 1
    end
    size
  end

  def to_a
    return [] unless head
    return_array = [head.data]
    next_node = head
    while next_node.next
      next_node = next_node.next
      return_array << next_node.data
    end
    return_array
  end
end

class BSTree
  attr_accessor :head

  def initialize(data = nil)
    @head = BSTNode.new(data, nil, nil) if data
  end

  def insert(data)
    node = head
    while node
      node = (node.data > data ? node.left : node.right)
    end
    node = BSTNode.new(data, nil, nil)
  end

  def search(data)
    node = head
    while node
      break if node.data == data
      node = (node.data > data ? node.left : node.right)
    end
    node
  end

  def search_r(data, node = head)
    return node if node.nil? || node.data == data
    node = (node.data > data ? node.left : node.right)
    search_r(data, node)
  end
end

class Stack
  attr_accessor :head

  def initialize(data)
    @head = Node.new(data, nil)
  end

  def push(data)
    new_head = Node.new(data, head)
    @head = new_head
  end

  def pop
    return nil unless head
    popped = head
    @head = head.next
    popped.data
  end

  def unshift(data)
    if !head then @head = Node.new(data, nil)
    else
      current = head
      while current.next
        current = current.next
      end
      current.next = Node.new(data, nil)
    end
  end

  def shift
    return nil unless head
    current = head
    while current.next.next
      current = current.next
    end
    shifted = current.next
    current.next = nil
    shifted.data
  end

  def to_a
    return_array = [head.data]
    current = head
    while current.next
      current = current.next
      return_array << current.data
    end
    return_array
  end
end

class Queue
  attr_accessor :head

  def initialize(data)
    @head = Node.new(data)
  end

  def enqueue(data)
    if !head then @head = Node.new(data)
    else
      current = head
      while current.next
        current = current.next
      end
      current.next = Node.new(data, nil)
    end
  end

  def dequeue
    return nil unless head
    dequeueing = @head.data
    @head = @head.next
    dequeueing
  end

  def to_a
    return nil unless head
    return_array = [head.data]
    current = head
    while current.next
      current = current.next
      return_array << current.data
    end
    return_array
  end
end



