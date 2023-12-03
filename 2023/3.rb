board = []
while line = gets
    board.push(line.chomp())
end

def numeric?(character)
    character =~ /[[:digit:]]/
end

def good?(character)
    not numeric? character and not character == '.'
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

(0...n).each do |i|
    (0...m).each do |j|
        if numeric? board[i][j] and (j == 0 or not numeric? board[i][j-1])
            k = j
            ok = false
            num = 0
            while k < m and numeric? board[i][k] do
                ok = true if checkBoard(board, i, k)
                num = num * 10 + (board[i][k].ord - '0'.ord)
                k = k + 1
            end

            answer += num if ok
        end
    end
end
puts answer