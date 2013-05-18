require 'benchmark'
require 'csv'

def test_speed n
  s = []
  n.times { s.insert(0, 12) }
end

def product_test_data
  data = (1..20).map do |i|
    result = Benchmark.measure { test_speed(i * 1000) }
    [i, result.real]
  end

  CSV.open("data.csv", "w+") do |csv|
    data.each{ |d| csv << d }
  end
end

product_test_data
