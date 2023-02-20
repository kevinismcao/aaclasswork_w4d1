module Searchable

    def dfs(target_position)
        return self if target_position == self.position
        
        self.children.each do |child|
            check = child.dfs(target_position)
            return check unless check.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        until queue.empty?
            node = queue.shift 
            return node if node.value == target_value
            queue.concat(node.children)
        end
        nil
    end

end

class PolyTreeNode
    include Searchable

    attr_reader :parent, :children, :position

    def initialize (pos)
        @position = pos
        @parent = nil
        @children = []
    end

    def parent= (parent_node)
        old_parent = self.parent
        @parent = parent_node
        if old_parent != nil
            old_parent.children.each_with_index do |child, idx|
                if child == self
                    old_parent.children.delete_at(idx)
                end
            end
        end

        if parent_node != nil 
            parent_node.children << self if !parent_node.children.include?(self)
        end
    end

    def add_child(child_node)

        self.children << child_node if !self.children.include?(child_node)
        child_node.parent= self
        
    end


    def remove_child(child_node)
        raise "not a child node" if !self.children.include?(child_node)
        self.children.each_with_index do |child, idx|
            if child == child_node
                self.children.delete_at(idx)
            end
        end
        child_node.parent=nil
    end


    # def dfs(target_value)
    #     return self if target_value == self.value
        
    #     self.children.each do |child|
    #         check = child.dfs(target_value)
    #         return check unless check.nil?
    #     end
    #     nil
    # end


    # def inspect
    #     @position.inspect
    # end
end


