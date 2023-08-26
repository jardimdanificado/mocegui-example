local mocegui = require "mocegui"
local util = require "mocegui.luatils"
local pending={}

function love.load()
	mocegui.load()
  local counter = 0
  local defwin = mocegui.newWindow(nil,{(love.graphics.getWidth()/2)-144,48},{288,94}) -- default window
  defwin.text.new('Right mouse button close windows.\nMiddle mouse button move windows.\nLeft mouse button interacts, and also move\nwindows if click on title bar.\nWhen a window got title bar it also got a close\nbutton on top12-right',{4,4})
  local windowspawner = mocegui.newWindow('window spawner',{(love.graphics.getWidth()/2)-50,148},{100,60},{0.3,0.4,0.5,1}) -- default window
  windowspawner.button.new({windowspawner.size[1]/2-16,windowspawner.size[2]/2-4},{32,16},function ()
  	counter = counter + 1
  	mocegui.newWindow("window " .. counter,{mocegui.util.random(0,love.graphics.getWidth()/2),mocegui.util.random(0,love.graphics.getHeight()/2)-16},{mocegui.util.random(0,love.graphics.getWidth()/2)+16,mocegui.util.random(0,love.graphics.getHeight()/2)+16})
  end)
  
  util.agendar(pending, function(obj)
    for i,v in ipairs(mocegui.window) do
       if v == obj then
         mocegui.window[i] = nil
         util.array.selfclear(mocegui.window)
         break
       end
    end
  end,{defwin},4)
end

function love.keypressed(key)
	mocegui.keypressed(key)
end

function love.mousemoved( x, y, dx, dy, istouch )
	mocegui.mousemoved( x, y, dx, dy, istouch )
end

function love.mousereleased(x, y, button)
	mocegui.mousereleased(x,y,button)
end

function love.mousepressed(x, y, button, istouch)
	mocegui.mousepressed(x, y, button, istouch)
end

function love.update()
  mocegui.util.repeater(pending)
	mocegui.update()
end

function love.draw()
	mocegui.draw()
end

return mocegui