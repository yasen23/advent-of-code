object MyClass {
    val snafuToDigit = Map(
        '1' -> 1,
        '2' -> 2,
        '0' -> 0,
        '-' -> -1,
        '=' -> -2)
    val digitToSnafu = Map(
        0L -> "0",
        1L -> "1",
        2L -> "2",
        3L -> "=",
        4L -> "-")

    def snafu(num:String) = num.foldLeft(0L)(_ * 5L + snafuToDigit(_));

    def numToSnafu(snafu:Long, carry:Long):String = {
        val num = snafu + carry;
        if (num == 0L) ""
        else numToSnafu(num / 5, if (num % 5 > 2) 1 else 0) + digitToSnafu(num % 5L)
    }

    def main(args: Array[String]) {
        print(
            numToSnafu(
                Iterator.continually(scala.io.StdIn.readLine)
                .takeWhile(_.nonEmpty)
                .foldLeft(0L)(_ + snafu(_)), 0L))
    }
}
