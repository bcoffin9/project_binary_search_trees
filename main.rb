require_relative "tree.rb"

tree = Tree.new(Array.new(15) {rand(1..100)})
puts "Is the tree balanced? #{tree.balanced?}"
puts "Level Order:"
puts tree.level_order.to_s
puts ""
puts "Pre Order:"
puts tree.preorder.to_s
puts ""
puts "Post Order:"
puts tree.postorder.to_s
puts ""
puts "In Order:"
puts tree.inorder.to_s
puts ""
8.times do
    a = rand(101..250)
    tree.insert(a)
end
puts "After adding 8 larger numbers is the tree balanced? #{tree.balanced?}"
puts "Level Order:"
puts tree.level_order.to_s
puts ""
puts "Pre Order:"
puts tree.preorder.to_s
puts ""
puts "Post Order:"
puts tree.postorder.to_s
puts ""
puts "In Order:"
puts tree.inorder.to_s
puts ""
puts "Rebalancing the tree"
tree.rebalance!
puts tree.level_order.to_s
puts "Halving the data using inorder"
tree.level_order do |a|
    a = a + 44
end
puts tree.inorder.to_s

#inorder, preorder, and postorder will not change the values of the tree yet
#because the block is not carried down recursive calls