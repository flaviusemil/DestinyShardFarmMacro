global isScriptEnabled := false

MonitorGet(1, &ScreenLeft, &ScreenTop, &ScreenRight, &ScreenBottom)

global baseWidth := 2560 ; width of your base resolution (2k in this case)
global baseHeight := 1440 ; height of your base resolution

global currentWidth := ScreenRight - ScreenLeft
global currentHeight := ScreenBottom - ScreenTop

SetWorkingDir(A_ScriptDir)
CoordMode("Mouse", "Screen")
SetTitleMatchMode(2)

F9::ToggleScript()

ToggleScript() {
    global isScriptEnabled

    isScriptEnabled := !isScriptEnabled
    if (isScriptEnabled)
        SetTimer(ShardFarm, 100)
    else
        SetTimer(ShardFarm, 0)
}

scaleCoordinates(x, y) {
    global baseWidth, baseHeight, currentWidth, currentHeight
    newX := (x/baseWidth) * currentWidth
    newY := (y/baseHeight) * currentHeight
    return {x: newX, y: newY}
}

ShardFarm() {
    global isScriptEnabled

    Sleep(100)
    ; buyItemCoordonates := scaleCoordinates(1560, 1000) ; Helm
    buyItemCoordonates := scaleCoordinates(1560, 900) ; Gloves
    ; buyItemCoordonates := scaleCoordinates(1560, 875) ; Chest
    ; buyItemCoordonates := scaleCoordinates(1560, 900) ; Helm
    Loop 10
    {
        if(!isScriptEnabled)
            return
        Click(buyItemCoordonates.x, buyItemCoordonates.y)
        Sleep(800)
    }

    if(!isScriptEnabled)
            return

    Sleep(100)
    Send("I")
    Sleep(500)

    ; Hover over the armor
    ; itemSlotCoordonates := scaleCoordinates(1860, 350) ; helm
    itemSlotCoordonates := scaleCoordinates(1860, 525) ; gloves
    ; itemSlotCoordonates := scaleCoordinates(1860, 700) ; chest
    ; itemSlotCoordonates := scaleCoordinates(1860, 850) ; legs
    MouseMove(itemSlotCoordonates.x, itemSlotCoordonates.y)
    ; Wait for the menu to open
    Sleep(100)
    
    ; itemToDestroyCoordonates := scaleCoordinates(2000, 350) ; Helm
    itemToDestroyCoordonates := scaleCoordinates(2000, 525) ; Gloves
    ; itemToDestroyCoordonates := scaleCoordinates(2000, 700) ; Chest
    ; itemToDestroyCoordonates := scaleCoordinates(2000, 850) ; Legs
    MouseMove(itemToDestroyCoordonates.x, itemToDestroyCoordonates.y)

    Loop 9
    {
        if(!isScriptEnabled)
            return

        Sleep(100)
        Send("{f Down}")
        Sleep(5000)
        Send("{f Up}")
        Sleep(100)
    }

    if(!isScriptEnabled)
        return

    Send("I")
    Sleep(3000)
}
