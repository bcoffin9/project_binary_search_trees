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
        insert val, root.lchild if (root.data > val && !root.lchild)
        insert val, root.rchild if (root.data < val && !root.rchild)
        newNode = Node.new(val)
        root.lchild = newNode if root > newNode
        root.rchild = newNode if root < newNode
    end

    def delete val, root=@root
        return nil if !root.lchild && !root.rchild
        if val = root.data
            delete root.lchild.data, root.lchild
            delete root.rchild.data, root.rchild
            root.lchild = nil if !root.lchild
            root.rchild = nil if !root.rchild
        elsif val < root.data
            delete val, root.lchild
        else val > root.data
            delete val, root.rchild
        end
    end

    def find val, root=@root
        raise StandardError.new("The value could not be found") if !root
        return root if root.data == val
        node = find val, root.lchild if root.data > val
        node = find val, root.rchild if root.data < val
        return node
    end

    #iterative level_order
    def level_order
        raise StandardError.new("Empty tree") if !root
        queue = []
        nodes = [] unless block_given?
        queue.push(root)
        while(!queue.empty?)
            current = queue[0]
            nodes.push(current.data) unless block_given?
            current.data = yield(current.data) if block_given?
            queue.push(current.lchild) if current.lchild
            queue.push(current.rchild) if current.rchild
            queue.shift
        end
        return nodes unless block_given?
    end

    def rec_level_order root=@root
        raise StandardError.new("Empty tree") if !root
        root.data = yield(root.data) if block_given?
        if block_given?
            rec_level_order root.lchild
            rec_level_order root.rchild
        return root.data unless block_given?
    end
        
end