require_relative "tree.rb"

tree = Tree.new([1,2,3,4,5,6,7,8,9])
a = tree.find(3)
puts "Node with value 3: #{a.data}; refers to #{a.lchild.data} and #{a.rchild.data}"
tree.level_order {|a| a*2}
puts tree.level_order