use 5.010;

@board = ();
$len = 0;
while ($line = <>) {
    $i = 0;
    $line=~ s/\s+$//;
    foreach $char (split('', $line)) {
        given ($char) {
            when('S') {
                $sx = $len;
                $sy = $i;
                $board[$len][$i++] = 1;
            }
            when('E') {
                $ex = $len;
                $ey = $i;
                $board[$len][$i++] = 26;
            }
            default {
                $board[$len][$i++] = ord($char) - ord('a') + 1;
            }
        }
    }
    $len ++;
}

@distance = ();
$distance[$sx][$sy] = 0;
@dirx = (0,0,1,-1);
@diry = (1,-1,0,0);
@nodes = ($sx, $sy);

$step = 0;
while (@nodes) {
    $curx = shift @nodes;
    $cury = shift @nodes;
    for (0..3) {
        $nx = $curx + $dirx[$_];
        $ny = $cury + $diry[$_];
        if ($board[$nx][$ny] &&
            !defined $distance[$nx][$ny] &&
            $board[$nx][$ny] - $board[$curx][$cury] < 2) {
            push @nodes, $nx;
            push @nodes, $ny;
            $distance[$nx][$ny] = $distance[$curx][$cury] + 1;
        }
    }
}

print $distance[$ex][$ey], "\n";
