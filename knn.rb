# A simple demonstration of the k-nearest neighbors algorithm.
# By default, using 2 attributes (thus, two dimensions).
# This can easily be changed by modifying the data at the bottom of this file.
# If you do so, also make sure to change the number of arguments accepted!
# Usage: ruby knn.rb <k> <attribute_1> <attribute_2>
# e.g. ruby knn.rb 3 4 5 
# will classify based on 3 closest neighbors to a point at 4,5.

# Determine Euclidean distance between two points, a and b
# This will work for an arbitrary number of dimensions
def euclidean_distance(a, b)
  Math.sqrt ( a.zip(b).map { |n| n.reduce(:-) }.map { |n| n**2 }.reduce(:+) )
end

# Determine the k closest neighbors to a point
def closest_neighbors(num_neighbors, point, data)
  data.keys.sort { |a,b| euclidean_distance(a, point) <=> euclidean_distance(b, point) }.take(num_neighbors)
end

# Determine the classification of an input based on the largest number of elements
# of the k closest neighbors
def classification(num_neighbors, point, data)
  closest_neighbors(num_neighbors, point, data).map { |p| data[p] }.group_by { |n| n }.max_by(&:size).first
end

# Read in data from the bottom of the file
def read_data
  entities = Hash.new
  DATA.each_line.map(&:chomp).each do |entity|
    entities[entity.split(',').slice(0..-2).map { |n| n.to_i } ] = entity.split(',').slice(-1)
  end
  entities
end

# Main execution
if (ARGV.length != 3) 
  puts "Enter four integer arguments"
else
  p classification(ARGV[0].to_i, ARGV.slice(1..-1).map { |n| n.to_i }, read_data)
end

# Data (3 dimensions)
__END__
1,1,elf
1,2,elf
2,1,elf
0,1,elf
4,3,elf
2,2,elf
5,5,gnome
5,4,gnome
1,1,gnome
3,3,gnome
4,4,gnome
2,4,gnome
