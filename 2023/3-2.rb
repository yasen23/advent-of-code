board = []
while line = gets
    board.push(line.chomp())
end

def numeric?(character)
    character =~ /[[:digit:]]/
end

def good?(character)
    character == '*'
end

def checkIndex(board, i, j)
    0 <= i and i < board.length and 0 <= j and j < board[0].length
end

def checkBoard(board, i, j)
    (-1..1).each do |x|
        (-1..1).each do |y|
            if checkIndex(board, i + x, j + y) and good?(board[i + x][j + y])
                return true
            end
        end
    end
    return false
end

n = board.length
m = board[0].length
answer = 0

values = {}

(0...n).each do |i|
    (0...m).each do |j|
        if numeric? board[i][j] and (j == 0 or not numeric? board[i][j-1])
            k = j
            ok = false
            num = 0
            while k < m and numeric? board[i][k] do
                if checkBoard(board, i, k)
                    ok = true
                end
                num = num * 10 + (board[i][k].ord - '0'.ord)
                k = k + 1
            end
            if ok
                k = j
                while k < m and numeric? board[i][k] do
                    values[i * m + k] = num
                    k = k + 1
                end
            end
        end
    end
end

(0...n).each do |i|
    (0...m).each do |j|
        if good? board[i][j]
            first = second = 0
            gap = false
            (-1..1).each do |x|
                (-1..1).each do |y|
                    if not checkIndex(board, i+x, j+y)
                        gap = true if first > 0
                        continue
                    end

                    gap = true if first > 0 and not numeric? board[i+x][j+y]
                    index = (i + x) * m + (j + y)
                    if values.key?(index) and first == 0
                        first = values[index]
                    elsif values.key?(index) and gap
                        second = values[index]
                    end
                end
                gap = true if first > 0
            end
            answer += first * second
        end
    end
end
puts answer