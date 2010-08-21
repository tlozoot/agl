class Array
  # If +number+ is greater than the size of the array, the method
  # will simply return the array itself sorted randomly
  def randomly_pick(number)
    self.sort_by{ Kernel.rand }.first(number)
  end
    
end
