def euclidean_distance(a, b)
  Math.sqrt ( a.zip(b).map { |n| n.reduce(:-) }.map { |n| n**2 }.reduce(:+) )
end

def closest_neighbors(num_neighbors, point, data)
  data.keys.sort { |a,b| euclidean_distance(a, point) <=> euclidean_distance(b, point) }.take(num_neighbors)
end

def classification(num_neighbors, point, data)
  closest_neighbors(num_neighbors, point, data).map { |p| data[p] }.group_by { |n| n }.max_by(&:size).first
end

def read_data
  entities = Hash.new
  DATA.each_line.map(&:chomp).each do |entity|
    entities[entity.split(',').slice(0..-2).map { |n| n.to_i } ] = entity.split(',').slice(-1)
  end
  entities
end

p classification(ARGV[0].to_i, ARGV.slice(1..-1).map { |n| n.to_i }, read_data)

__END__
1,1,1,elf
1,2,1,elf
2,1,2,elf
0,1,1,elf
4,3,7,elf
2,2,3,elf
5,5,5,gnome
5,4,4,gnome
1,1,3,gnome
3,3,2,gnome
4,4,6,gnome
2,4,3,gnome
