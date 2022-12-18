import tetris_blocks
import numpy as np

pieces = tetris_blocks.BLOCKS
COLS = 7

def canMove(row, col, piece, board):
    for i in range(len(piece)):
        piece_row = row + piece[i][0]
        piece_col = col + piece[i][1]
        if piece_row < 0 or piece_col < 0 or piece_col >= COLS or board[piece_row][piece_col] > 0:
            return False
    return True

def putPiece(row, time, piece, board, wind):
    current_row = row + 3
    current_col = 2

    while True:
        delta = -1 if wind[time % len(wind)] == '<' else 1
        if canMove(current_row, current_col+delta, piece, board):
            current_col += delta
        time += 1
        if canMove(current_row-1, current_col, piece, board):
            current_row -= 1
        else:
            # Put piece.
            for i in range(len(piece)):
                piece_row = current_row + piece[i][0]
                piece_col = current_col + piece[i][1]
                board[piece_row][piece_col] = 1
                row = row if row > piece_row+1 else piece_row+1
            break

    return (row, time)

def computeState(row, board):
    res = 0
    for i in range(row-5, row):  # The last rows define the whole state
        for j in range(COLS):    # (can be optimized further to the last filled per column)
            res |= int(board[i][j]) * (1 << ((i - row+5) * COLS + j))
    return res

board = np.full(shape=(10000, 7), fill_value=0)

time = row = 0
num_pieces = 0
TARGET_PIECES = 1000000000000
wind = ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>"  # example

mem = {}
ans = {}
while num_pieces < TARGET_PIECES:
    (row, time) = putPiece(row, time, pieces[num_pieces % len(pieces)], board, wind)
    num_pieces += 1
    ans[num_pieces] = row
    # Use this for part 2.
    if row > 5:
        board_state = computeState(row, board)
        time_state = time % len(wind)
        state = (board_state, time_state)
        if state not in mem:
            mem[state] = (num_pieces, row)
        else:
            # Found a cycle!
            old_pieces, old_row = mem[state]
            cycle_length = num_pieces - old_pieces
            rows_in_cycle = row - old_row
            cycle_times = TARGET_PIECES // cycle_length
            print cycle_times * rows_in_cycle + ans[TARGET_PIECES % cycle_length]
            break

# Use this with TARGET_PIECES=2022 for part 1
# print row
