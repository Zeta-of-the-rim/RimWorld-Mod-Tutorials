;Comments in AutoHotkey look like this.

;Scripts for converting code to a format that can be used for Visual Studio Code's code snippets.
;Made for personal use, but feel free to use it if you want.

^b::
Toggle := !Toggle
Loop
{
    If (!Toggle)
        Break

Send {Home}
Send "
Send {End}
Send "
Send, {,}
Send {Down}
Sleep 100
}
Return

^n::
Toggle := !Toggle
Return

;\n is the new line character will add a new line when the snippet is used.
e::
Send \n


w::
Send {Home}
Send "
Send {Delete}
Send {End}
Send "
Send, {,}
Send {Down}
Send {Home}
Return

q::
Send {Delete}
Send \t
Return

r::
Send $
Return