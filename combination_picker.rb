require 'set'

class CombinationPicker
  def initialize(n, initial_state, target_state, restricted_combs = [])
    @n = n
    @initial_state = initial_state
    @target_state = target_state
    @restricted_set = restricted_combs.map(&:join).to_set
    @visited = Set.new
  end

  def pick
    queue = [@initial_state]
    @visited.add @initial_state.join
    parent = {}

    until queue.empty?
      current_state = queue.shift

      return build_path(parent, current_state) if current_state == @target_state

      neighbors(current_state).each do |neighbor|
        next if @visited.include?(neighbor.join)

        @visited.add(neighbor.join)
        parent[neighbor.join] = current_state
        queue << neighbor
      end
    end

    nil
  end

  private

  def neighbors(state)
    neighbors = []

    @n.times do |i|
      up = modify_state(state, +1, i)
      down = modify_state(state, -1, i)

      neighbors << up if up
      neighbors << down if down
    end

    neighbors
  end

  def modify_state(state, step, index)
    current_digit = state[index].to_i
    modified_state = state.dup

    modified_state[index] = ((current_digit + step) % 10).to_s

    modified_state unless @restricted_set.include?(modified_state.join)
  end

  # Builds path from init state to target state
  def build_path(parent, state)
    path = [state]
    while state.join != @initial_state.join
      state = parent[state.join]
      path << state
    end
    path.reverse
  end
end
