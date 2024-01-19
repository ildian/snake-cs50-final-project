
-- snake

Snake = Class {}

function Snake:init(x, y, size)

    self.x = x
    self.y = y
    self.speed = 100
    self.size = size

    self.dx = 0
    self.dy = 0

    self.right = true
    self.left = false
    self.up = false
    self.down = false
end

function Snake:update(dt)

    if self.up then
        self.dy = -(self.speed * dt) 
        self.dx = 0
        --SnakeY = SnakeY + (-speed * dt)
    elseif self.down then
        self.dy = (self.speed * dt) 
        self.dx = 0
        --SnakeY = SnakeY + (speed * dt)
    elseif self.right then
        self.dx = (self.speed * dt) 
        self.dy = 0
        --SnakeX = SnakeX + (speed * dt)
    elseif self.left then
        self.dx = (-self.speed * dt) 
        self.dy = 0
        --SnakeX = SnakeX + (-speed * dt)
    end

    self.x = self.x + Snake:sign(self.dx)
    self.y = self.y + Snake:sign(self.dy)
    
end

function Snake:sign(num)

    if num < 0 then
        return -5
    elseif num > 0 then
        return 5
    elseif num == 0 then
        return 0
    end

end

function Snake:turns()

    if love.isPressed('right') and self.left == false then
        self.up = false
        self.down = false
        self.right = true
    elseif love.isPressed('left') and self.right == false then
        self.up = false
        self.down = false
        self.left = true
    elseif love.isPressed('up') and self.down == false then
        self.up = true
        self.right = false
        self.left = false
    elseif love.isPressed('down') and self.up == false then
        self.down = true
        self.right = false
        self.left = false
    end

end

function Snake:wall_hit()

    if self.x >= VIRTUAL_WIDTH - 10 then
        self.dx = 0
        self.dy = 0
        self.x = VIRTUAL_WIDTH - 11
        print("Collision right")
        return true

    elseif self.x <= 0 then
        self.dx = 0
        self.dy = 0
        self.x = 1
        print("Collision left")
        return true

    elseif self.y >= VIRTUAL_HEIGHT - 10 then
        self.dx = 0
        self.dy = 0
        self.y = VIRTUAL_HEIGHT - 11
        print("Collision down")
        return true

    elseif self.y <= 0 then
        self.dx = 0
        self.dy = 0
        self.y = 1
        print("Collision up")
        return true
    end
end

function Snake:Collision(objX, objY, size)

    if self.x + self.size >= objX and self.x <= objX + size then
        if self.y + self.size >= objY and self.y <= objY + size then
            return true
        end
    end
    return false
    
end


function Snake:render()
    
    love.graphics.setColor(0.2, 0.5, 1.0, 1.0) -- draw the snake's head
    love.graphics.rectangle('fill', self.x , self.y , self.size, self.size, 10, 10)
    

end