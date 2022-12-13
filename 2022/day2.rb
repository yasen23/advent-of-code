#!/usr/bin/env ruby

# Use this hash instead for part 1.
# hash = {
#     "A X" => 4,
#     "A Y" => 8,
#     "A Z" => 3,
#     "B X" => 1,
#     "B Y" => 5,
#     "B Z" => 9,
#     "C X" => 7,
#     "C Y" => 2,
#     "C Z" => 6
# }

hash = {
    "A X" => 3,
    "A Y" => 4,
    "A Z" => 8,
    "B X" => 1,
    "B Y" => 5,
    "B Z" => 9,
    "C X" => 2,
    "C Y" => 6,
    "C Z" => 7
}

score = 0

while line = gets
    score += hash[line.strip]
end

puts score
