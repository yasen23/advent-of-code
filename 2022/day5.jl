a = string.(("NZ","DCM","P"), "")
move = [1,3,2,1]
from = [2,1,2,1]
to = [1,3,1,2]
size = length(move)

set(t::Tuple,i,val) = ntuple(j -> j == i ? val : t[j], length(t))

for i in 1:size
  str = reverse(a[from[i]][1:move[i]])
  a = set(a, from[i], a[from[i]][(move[i]+1):end])
  a = set(a, to[i], string(str, a[to[i]]))
end

accumulate(*, map(x -> x[1], a))[end]

# For part 2 (executed independently).
for i in 1:size
  str = a[from[i]][1:move[i]]
  a = set(a, from[i], a[from[i]][(move[i]+1):end])
  a = set(a, to[i], string(str, a[to[i]]))
end

accumulate(*, map(x -> x[1], a))[end]
