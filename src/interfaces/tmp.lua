tfm.exec.addImage('17201a440b4.png', ':0', 400 - (520/2), 200 - 150 + 30)




local width = 100
local height = 15
local x = (400 - width/2)
local y = (200 - height/2) - 30

ui.addTextArea(0, '', player, x-1, y-1, width, height, 0x95d44d, 0x95d44d, 1, true)
ui.addTextArea(1, '', player, x+1, y+1, width, height, 0x1, 0x1, 1, true)
ui.addTextArea(2, '', player, x, y, width, height, 0x44662c, 0x44662c, 1, true)
ui.addTextArea(3, '<p align="center"><font color="#cef1c3" size="13"><a href="event:">a\n', player, x-4, y-4, width+8, height+8, 0xff0000, 0xff0000, 0, true)