#!/usr/bin/env wish
# Create the main windows title
wm title . "Simple Tcl/tk Example"
#Create a label with text
label .label -text "Hejsan, Tcl/Tk Världen" -font {Arial 16}
pack .label -pady 20
# Create a counter variable
set counter 0
# Function incrementCounter {} {
    global counterincr counter.countLabel configure -text "Button clicks: $counter"
}
# Create a label to display the counter
label .countLabel -text "Button clicks: $counter" -font {Arial 12}
pack .countlabel -pady 10
# Create a button that calls increamentCounter when clicked
button .button -text "Click me!" -command increamentCounter -bg lightblue -paddx 10 -pady 5
# Create a quit buttonbutton .quit -text "Quit" -command exit -bg pink -padx 10 -pady 5
pack .quit -pady 10
# Center the windows
update
set x [expr ([winfo screenwidth .] - [winfo width .]) / 2]
set y [expr ([winfo screenheight .] -[winfo height .]) / 2]
wm geometry . +$x+$y
