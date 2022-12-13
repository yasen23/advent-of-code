import java.util.*
import kotlin.math.abs

fun close(x: Int, value: Int):Boolean {
    return abs(x % 40 - value) < 2
}

fun printChar(x: Int, value: Int) {
    if (close(x, value)) {
        print('#')
	} else {
        print(' ')
	}

	if (x % 40 == 39) println();
}

fun main(args: Array<String>) {
    val sc = Scanner(System.`in`)
    var x = 0
    var value = 1
    while (sc.hasNext()) {
        val line = sc.nextLine()

        if (line.equals("noop")) {
            printChar(x++, value)
    	} else {
            val ind = line.indexOf(" ")
            val num = line.substring(ind + 1).toInt();
            printChar(x++, value)
            printChar(x++, value)
            value += num
    	}
    }
}
