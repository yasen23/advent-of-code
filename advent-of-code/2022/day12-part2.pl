use 5.010;

@board = ();
$len = 0;
@distance = ();
@nodes = ();

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
            when ('a') {
                push @nodes, $len;
                push @nodes, $i;
                $distance[$len][$i] = 0;
                $board[$len][$i++] = 1;
            }
            default {
                $board[$len][$i++] = ord($char) - ord('a') + 1; 
            }
        }
    }
    $len ++;
}

@dirx = (0,0,1,-1);
@diry = (1,-1,0,0);
$distance[$sx][$sy] = 0;
push @nodes, $sx;
push @nodes, $sy;

$step = 0;
while (@nodes) {
    $curx = shift @nodes;
    $cury = shift @nodes;
    for (0..3) {
        $nx = $curx + $dirx[$_];
        $ny = $cury + $diry[$_];
        if ($nx >= 0 && $ny >= 0 && $board[$nx][$ny] &&
            !defined $distance[$nx][$ny] &&
            $board[$nx][$ny] - $board[$curx][$cury] < 2) {
            push @nodes, $nx;
            push @nodes, $ny;
            $distance[$nx][$ny] = $distance[$curx][$cury] + 1;
        }
    }
}

print $distance[$ex][$ey], "\n";
