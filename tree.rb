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
        temp = val > root.data ? root.rchild : root.lchild
        if !temp.lchild && val < temp.data
            temp.lchild = Node.new(val)
        elsif
            !temp.rchild && val > temp.data
            temp.rchild = Node.new(val)
        else
            insert(val, temp)
        end
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

    def inorder root=@root, nodes=[]
        raise StandardError.new("Empty tree") if !root
        if block_given?
            inorder root.lchild,  if root.lchild
            yield(root.data)
            inorder root.rchild if root.rchild
        else
            inorder(root.lchild, nodes) if root.lchild
            nodes.push(root.data)
            inorder(root.rchild, nodes) if root.rchild
        end
        nodes unless block_given?
    end

    def preorder root=@root, nodes=[]
        raise StandardError.new("Empty tree") if !root
        if block_given?
            yield(root.data)
            preorder root.lchild if root.lchild
            preorder root.rchild if root.rchild
        else
            nodes.push(root.data)
            preorder(root.lchild, nodes) if root.lchild
            preorder(root.rchild, nodes) if root.rchild
        end
        nodes unless block_given?
    end

    def postorder root=@root, nodes=[]
        raise StandardError.new("Empty tree") if !root
        if block_given?
            postorder root.lchild if root.lchild
            postorder root.rchild if root.rchild
            yield(root.data)
        else
            postorder(root.lchild, nodes) if root.lchild
            postorder(root.rchild, nodes) if root.rchild
            nodes.push(root.data)
        end
        nodes unless block_given?
    end

    def depth node=@root
        return 0 if !node
        depth = 1
        left = depth(node.lchild)
        right = depth(node.rchild)
        depth += left > right ? left : right
    end

    def balanced?
        left = depth(@root.lchild)
        right = depth(@root.rchild)
        diff = (left - right).abs
        return diff < 2 ? true : false
    end

    def rebalance!
        arr = inorder
        initialize(arr)
    end
        
end