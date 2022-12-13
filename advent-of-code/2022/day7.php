<?php

function writePath($curr_path) {
    foreach ($curr_path as $path) {
        fwrite(STDOUT, $path);
        if ($path != "/") fwrite(STDOUT, "/");
    }
    fwrite(STDOUT, "\n");
}

function constructPath($curr_path) {
    $ret = "";
    foreach ($curr_path as $path) {
        $ret .= $path;
        if ($path != "/") $ret .= "/";
    }
    return $ret;
}

$curr_dir = array();
$score = array();
$ans = 0;

while ($line = fgets(STDIN)) {
    writePath($curr_dir);

    $line = trim($line);
    if (strpos($line, "$ ls") === 0) {
        continue;
    }
    if (strpos($line, "$ cd") === 0) {
        if (strpos($line, "..")) {
            $child_path = constructPath($curr_dir);
            array_pop($curr_dir);
            $parent_path = constructPath($curr_dir);
            $child_score = $score[$child_path];
            $score[$parent_path] += $child_score;
            if ($child_score <= 100000) {
                $ans += $child_score;
            }
            continue;
        }
        array_push($curr_dir, substr($line, 5));
        continue;
    }

    if (strpos($line, "dir") === 0) {
        continue;
    }

    $value = (int) filter_var($line, FILTER_SANITIZE_NUMBER_INT);
    $path = constructPath($curr_dir);
    $score[$path] += $value;
}

$len = sizeof($curr_dir);
while ($len) {
    $child_path = constructPath($curr_dir);
    array_pop($curr_dir);
    $parent_path = constructPath($curr_dir);
    $child_score = $score[$child_path];
    $score[$parent_path] += $child_score;
    if ($child_score <= 100000) {
        $ans += $child_score;
    }

    $len --;
}
fwrite(STDOUT, $ans . "\n");

// Part 2 from here

$total_score = $score["/"];
$target = $total_score - 40000000;
$min_score = $total_score;

foreach ($score as $path => $value) {
    if ($value >= $target) {
        $min_score = min($min_score, $value);
    }
}
fwrite(STDOUT, $min_score . "\n");

?>
