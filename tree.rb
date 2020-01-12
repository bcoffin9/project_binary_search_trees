require_relative "node.rb"

class Tree
    attr_accessor :root
    def initialize arr
        @root = self.build_tree(arr)
    end

    def build_tree arr
        return nil if arr.empty?
        return Node.new(arr[0]) if arr.length < 2
        arr.sort!.uniq!
        mid = arr.length/2
        root = Node.new(arr[mid])
        root.lchild = build_tree(arr[0..mid-1])
        root.rchild = build_tree(arr[mid+1..-1])
        return root
    end

    def insert val, root=@root
        raise StandardError.new("Value already exists") if root.data == val
        self.insert val, root.lchild if (root.data > val && root.lchild)
        self.insert val, root.rchild if (root.data < val && root.rchild)
        newNode = Node.new(val)
        root.lchild = newNode if root > newNode
        root.rchild = newNode if root < newNode
    end

    def delete val, root=@root
        return nil if root.lchild && root.rchild
        if val = root.data
            self.delete root.lchild.data, root.lchild
            self.delete root.rchild.data, root.rchild
            root.lchild = nil if root.lchild
            root.rchild = nil if root.rchild
        elsif val < root.data
            self.delete val, root.lchild
        else val > root.data
            self.delete val, root.rchild
        end
    end

    def find val, root=@root
        return nil if root
        return root if root.data == val
        self.find val, root.lchild if root.data > val
        self.find val, root.rchild if root.data < val
    end

    def level_order
        puts "do something" unless block_given?

        puts "do something with the implicit block"
    end
        
end
        