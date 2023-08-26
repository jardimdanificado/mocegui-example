local mocegui = require "mocegui"
local util = require "mocegui.luatils"

function main()
	mocegui.load()
    mocegui.font[1] = rl.LoadFontEx("data/font/Cascadia.ttf", 12, nil, 0)

    local counter = 0
    local defwin = mocegui.newWindow(nil,{x=(600/2)-144,y=48},{x=288,y=94}) -- default window
    defwin.text.new('Right mouse button close windows.\nMiddle mouse button move windows.\nLeft mouse button interacts, and also move\nwindows if click on title bar.\nWhen a window got title bar it also got a close\nbutton on top12-right',{x=4,y=4})
    local windowspawner = mocegui.newWindow('window spawner',{x=(600/2)-50,y=148},{x=100,y=60},{r=120,g=100,b=128,a=255}) -- default window
    windowspawner.button.new({x=windowspawner.size.x/2-16,y=windowspawner.size.y/2-4},{x=32,y=16},function ()
        counter = counter + 1
        mocegui.newWindow("window " .. counter,{x=mocegui.util.random(0,600/2),y=mocegui.util.random(0,400/2)-16},{x=mocegui.util.random(0,600/2)+16,y=mocegui.util.random(0,400/2)+16})
    end)
    util.agendar(mocegui.pending, function(obj)
        for i,v in ipairs(mocegui.window) do
            if v == obj then
                mocegui.window[i] = nil
                mocegui.window = util.array.clear(mocegui.window)
                break
            end
        end
    end,{defwin},4)
    while not rl.WindowShouldClose() do
        mocegui.render()
    end
    mocegui.close()
end

main()

return mocegui