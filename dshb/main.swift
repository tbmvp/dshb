// if (signal(SIGINT, catch_function) == SIG_ERR) {
//    fputs("An error occurred while setting a signal handler.\n", stderr);
//    return EXIT_FAILURE;
// }

import Darwin


// -v command line arg
let VERSION = "0.0.1"

public struct WinCoords {
    var size  : (length : Int32, width : Int32)
    var pos   : (x : Int32, y : Int32)
}


func sig_resize() {
    clear()
    addstr("RESIZE")
    refresh()
}
var ptr : CFunctionPointer<((Int32) -> Void)>

//ptr =

//signal(SIGWINCH, CFunctionPointer<((Int32) -> Void)>(sig_resize()))
signal(SIGWINCH, nil)



setlocale(LC_ALL, "")

// ncurses settings
initscr()                // Init window. Must be first
cbreak()
noecho()                 // Don't echo user input
nonl()                   // Disable newline mode
intrflush(stdscr, false) // Prevent flush
keypad(stdscr, true)     // Enable function and arrow keys
curs_set(0)              // Set cursor to invisible


if (!has_colors()) {
    println("WARN: Terminal doesn't have support for colours")
}
// do custom colors check

// Init terminal colours
start_color()
init_pair(1, Int16(COLOR_BLACK), Int16(COLOR_GREEN))
init_pair(2, Int16(COLOR_BLACK), Int16(COLOR_YELLOW))
init_pair(3, Int16(COLOR_BLACK), Int16(COLOR_RED))
init_pair(4, Int16(COLOR_WHITE), Int16(use_default_colors()))
init_pair(5, Int16(COLOR_WHITE), Int16(COLOR_CYAN))
var y2 = "Lines: " + String(LINES) + " COLS: " + String(COLS)
addstr("-- Hello")
addstr(y2)
refresh()




KEY_RESIZE
//----------------------

// Sample box
//var win = newwin(1, 30, 10, 10)
//var win2 = newwin(1, 30, 11, 10)
//
// newwin(0,0,0,0) - for config menu
// newwin null check
var gap : Int32 = 5
var bar_size = Int32(ceil(Double((COLS - gap)) / 2.0))
addstr("bar size: " + String(bar_size))
refresh()
var bar_size2 = bar_size + gap


var tmpTitleCoords = WinCoords(size: (length: bar_size, width: 1), pos: (x:0, y:9))
var tmpTitle = TabTitle(title: "TMPs", winCoords: tmpTitleCoords, colour: COLOR_PAIR(5))

var fanTitleCoords = WinCoords(size: (length: bar_size, width: 1), pos: (x:bar_size2, y:9))
var fanTitle = TabTitle(title: "FANS", winCoords: fanTitleCoords, colour: COLOR_PAIR(5))



//var win2  = newwin(1, bar_size, 9, bar_size2)
//wattrset(win2, COLOR_PAIR(5))
////wbkgd(win, CWideChar(" ").value)
//waddstr(win2, "FANs                                   ")
//wrefresh(win2)


// delwin
var cpu_bar = BarGraph(name: "CPU_0_DIODE", length: bar_size, width: 1, x: 0, y: 10, max: 105, unit: BarGraph.Unit.Celsius)
var cpu_bar2 = BarGraph(name: "CPU_0_HEATSINK", length: bar_size, width: 1, x: 0, y: 11, max: 105, unit: BarGraph.Unit.Celsius)
var cpu_bar3 = BarGraph(name: "CPU_0_PROXIMITY", length: bar_size, width: 1, x: 0, y: 12, max: 105, unit: BarGraph.Unit.Celsius)
var cpu_bar4 = BarGraph(name: "CPU_0_PROXIMITY", length: bar_size, width: 1, x: bar_size2, y: 10, max: 105, unit: BarGraph.Unit.Celsius)

for var i = 0; i < 10; ++i {
    cpu_bar.update(Int(arc4random_uniform(105)))
    cpu_bar2.update(Int(arc4random_uniform(105)))
    cpu_bar3.update(Int(arc4random_uniform(105)))
    cpu_bar4.update(Int(arc4random_uniform(105)))
    sleep(1)
}

//delwin(win)

addstr("DONE")
refresh()
//sleep(10)
//
//
var ch = getchar()
//
////if (ch == KEY_RESIZE) {
//    addstr("-- RESIZE" + String(ch))
//    refresh()
//    
//    sleep(10)
////}


endwin()    // Close window. Must call before exit