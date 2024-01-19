
--- Apple ----

Apple = Class {}

apple_img = love.graphics.newImage('/img/apple.png')

function Apple:init()

    self.x = math.random(0, VIRTUAL_WIDTH - 20)
    self.y = math.random (0, VIRTUAL_HEIGHT - 20)
    
end

function Apple:update(dt)

end

function Apple:render()
    
    love.graphics.draw(apple_img, self.x, self.y)
    
end