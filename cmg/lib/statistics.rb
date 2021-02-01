# I decided to create my own module extension, because there was no proper lib for that :(
# Stolen from there: https://stackoverflow.com/a/7749613/2488588
# Improved from here: https://github.com/thirtysixthspan/descriptive_statistics
module Enumerable

  def sum
    #self.inject(0){|accum, i| accum + i }
    self.reduce(:+)
  end

  def mean
    self.sum / self.number
  end

  def number
    self.length.to_f
  end

  def sample_variance
    m = self.mean
    #sum = self.inject(0){|accum, i| accum +(i-m)**2 }
    #sum/(self.length - 1).to_f

    self.map { |sample| (m - sample) ** 2 }.reduce(:+) / (self.number - 1)
  end

  def standard_deviation
    Math.sqrt(self.sample_variance)
  end

  def range
    self.max - self.min
  end

end
