require 'parallel'
require 'time_difference'

a = Time.now
class T
  def self.foo(i)
    puts i
    sleep 0.5
  end
end

results = Parallel.map((1..20),in_threads: 30){|i| T.foo(i) }
b =  Time.now

puts "Total time taken: #{TimeDifference.between(a,b).in_minutes} "
