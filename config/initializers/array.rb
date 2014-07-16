class Array
  def select_and_delete
    self.reduce([[], []]) do |memo, obj|
      if yield obj
        memo[0].append obj
      else
        memo[1].append obj
      end
      memo
    end
  end
end
