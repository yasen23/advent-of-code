package main

import (
    "bufio"
    "fmt"
    "os"
)

// part 1
func main2() {
    scanner := bufio.NewScanner(os.Stdin)

	var ans = 0
    for scanner.Scan() {
		m := make(map[byte]int)
		line := scanner.Text()
		var size = len(line) / 2
		for i:=0; i < size; i++ {
			m[line[i]] = 1
		}
		for i:=size; i < 2 * size; i++ {
			if m[line[i]] == 1 {
				if line[i] >= 'a' && line[i] <= 'z' {
					ans += int(line[i] - 'a') + 1
				} else {
					ans += int(line[i] - 'A') + 27
				}
				break
			}
		}

    }
	fmt.Println(ans)
}

// part 2
func main() {
    scanner := bufio.NewScanner(os.Stdin)

	var ans = 0
    for scanner.Scan() {
		m := make(map[byte]int)
		line1 := scanner.Text()
		scanner.Scan()
		line2 := scanner.Text()
		scanner.Scan()
		line3 := scanner.Text()

		for i:=0; i < len(line1); i++ {
			m[line1[i]] |= 1
		}
		for i:=0; i < len(line2); i++ {
			m[line2[i]] |= 2
		}
		for i:=0; i < len(line3); i++ {
			m[line3[i]] |= 4

			if m[line3[i]] == 7 {
				if line3[i] >= 'a' && line3[i] <= 'z' {
					ans += int(line3[i] - 'a') + 1
				} else {
					ans += int(line3[i] - 'A') + 27
				}
				break
			}
		}
    }
	fmt.Println(ans)
}