require "node.rb"

class Tree

    def initialize arr
        @root = self.build_tree(arr)
    end

    def build_tree arr
        return nil if arr
        arr.sort!.uniq!
        mid = arr.length/2
        root = Node.new(arr[(arr.length/2)-1])
        root.lchild = build_tree(arr[0..mid])
        root.rchild = build_tree(arr)
