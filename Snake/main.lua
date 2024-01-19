
--- let's do this ---

push = require 'push'
Class = require 'class'
-- --
require 'Snake'
require 'Apple'

-- state machine--

require 'StateMachine'
require 'states/BaseState'
require 'states/TitleState'
require 'states/PlayState'


MAX_WIDTH = 1366
MAX_HEIGHT = 768

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

TIME = 5
running = true
SCORE = 0

-- load the background
background_img = love.graphics.newImage('/img/background.jpg')

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    -- fonts --
    default_font = love.graphics.newFont('font.ttf', 8)
    title_font = love.graphics.newFont('font.ttf', 45)
    mediumFont = love.graphics.newFont('font.ttf', 25)
    scoreFont = love.graphics.newFont('font.ttf', 10)

    love.graphics.setFont(default_font)

    love.window.setTitle("Snake")
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, MAX_WIDTH, MAX_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    -- state machine
    gStateMachine = StateMachine {
        ['title'] = function() return TitleState() end,
        ['play'] = function() return PlayState() end
    }

    sounds = {
        ['eat'] = love.audio.newSource("sound/score.wav", 'static'),
        ['hit'] = love.audio.newSource('sound/hit.wav', 'static'),
        ['enter'] = love.audio.newSource('sound/enter.wav', 'static'),

        --music--
        ['music'] = love.audio.newSource('sound/chopin.mp3', 'static')
    }

    sounds['music']:setLooping(true)
    sounds['music']:play()
    -- setting the state
    gStateMachine:change('title')
    -- recording keystrokes
    love.keyboard.keypressed = {}

end

function love.update(dt)

    TIME = TIME - 1
    if TIME < 0 then
        gStateMachine:update(dt)   
        TIME = 5
        love.keyboard.keypressed = {}
    end
    
end


function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keypressed[key] = true

end

-- return the keypressed
function love.isPressed(key)
    
    return love.keyboard.keypressed[key]

end

function love.draw()

    push:start()

    --love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    --love.graphics.draw(background_img, 0, 0, 0, 0.74, 0.48)
    love.graphics.draw(background_img, 0, 0)
    gStateMachine:render()
    

    push:finish()
end