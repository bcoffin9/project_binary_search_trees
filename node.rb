class Node
    include Comparable

    attr_accessor :data, :lchild, :rchild
    def initialize data = nil, lchild = nil, rchild = nil
        @data = data
        @lchild = lchild
        @rchild = rchild
    end

    def <=> other
        @data <=> other.data
    end

    def < other
        @data < other.data
    end

    def > other
        @data > other.data
    end
    
end