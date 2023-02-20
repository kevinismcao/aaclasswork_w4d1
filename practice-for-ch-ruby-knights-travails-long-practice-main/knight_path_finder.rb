require_relative "tree_node.rb"
require "byebug"

class KnightPathFinder
    attr_reader :considered_positions, :root_node, :build_move_tree

    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
        
    end

    def self.valid_moves(pos) #8 possible moves
        x, y = pos
        possible_moves = []
        [-2, -1, 1, 2].each do |i|
            [-2, -1, 1, 2].each do |j|
                if i.abs != j.abs && ((x+i) >=0 && (x+i) < 8) && ((y+j) >= 0 && (y+j) < 8)
                    possible_moves << [x+i, y+j]
                end 
            end
        end
        possible_moves
    end

    def build_move_tree #use new_move_pos, build in breadth first manner
        queue = [@root_node]
        until queue.empty?
            node = queue.shift 
            children_pos = self.new_move_positions(node.position)
            children_pos.each do |childpos|
                node.add_child(PolyTreeNode.new(childpos))  
            end
            queue.concat(node.children)
        end
        nil
    end

    def find_path(end_pos)
        end_node = self.root_node.dfs(end_pos)
        self.trace_path_back(end_node)
    end

    def trace_path_back(end_node)
        newpath = [end_node.position]
        node = end_node
        until node.parent.nil?
            newpath.unshift(node.parent.position)
            node = node.parent
        end
        newpath
    end
        
    

    # def trace_path_back(end_node)
    #     path = [end_node] if end_node.parent.nil?
    #     trace_path_back(end_node.parent.position) << end_pos
        


    # end

    # def dfs(target_value)
    #     return self if target_value == self.value
        
    #     self.children.each do |child|
    #         check = child.dfs(target_value)
    #         return check unless check.nil?
    #     end
    #     nil
    # end


    # def count
    #     p self.considered_positions.count
    #     # hash =Hash.new(0)
    #     # self.considered_positions.each {|pos| hash[pos] += 1}
    #     # hash
    # end




    #     def bfs(target_value)
    #         queue = [self]
    #         until queue.empty?
    #             node = queue.shift 
    #             return node if node.value == target_value
    #             queue.concat(node.children)
    #         end
    #         nil
    #     end

    def new_move_positions(pos) #call ::valid_moves method
        vali_move = KnightPathFinder.valid_moves(pos).dup
        new_move = vali_move.select {|pos| !@considered_positions.include?(pos)}
        @considered_positions += new_move
        new_move
    end
end
