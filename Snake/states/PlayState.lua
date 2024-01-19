-- let's do this

PlayState = Class {__includes = BaseState}


function PlayState:init()

    self.snake = {}
    self.head =  Snake(VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2, 10)
    self.apple = Apple()

    self.oldX = 0
    self.oldY = 0

end

function PlayState:update(dt)
    if running then

        self.oldX = self.head.x
        self.oldY = self.head.y
        -- test -- how to move the tail
        self.head:turns()
        self.head:update(dt)

        -- collision
        if self.head:Collision(self.apple.x, self.apple.y, 20) then
            self.apple.x = math.random(0, VIRTUAL_WIDTH - 20)
            self.apple.y = math.random(0, VIRTUAL_HEIGHT - 20)

            -- score
            SCORE = SCORE + 10

            table.insert(self.snake, Snake(0, 0, 10))

            --length = length + 1
            --print("length = ", length)
            sounds['eat']:setVolume(0.3)
            sounds['eat']:play()
            print("I ate an apple!!!")
        end

        -- collision with the tail
        local i = 3
        while i < #self.snake do
            i = i + 1 
            if self.head:Collision(self.snake[i].x, self.snake[i].y, 5) then
                
                self.head.dx = 0
                self.head.dy = 0

                self.head.x = self.snake[i].x  
                self.head.y = self.snake[i].y 
                sounds['hit']:setVolume(0.2)
                sounds['hit']:play()
                print("Hit my tail!!")
                
                --gStateMachine:change('title')
                running = false

            end
        end

        -- stoping the snake and the tail
        if self.head:wall_hit() then
            sounds['hit']:setVolume(0.2)
            sounds['hit']:play()
            --gStateMachine:change('title')
            running = false

        else
            -- moving the tail
            for _,p in ipairs(self.snake) do
                temp_x, temp_y = p.x, p.y
                p.x, p.y = self.oldX, self.oldY
                self.oldX, self.oldY = temp_x, temp_y
            end
        end
    end

    if (love.isPressed("enter") or love.isPressed("return")) and running == false then
        print("I am pressing!!!!")
        running = true
        SCORE = 0
        sounds['enter']:setVolume(0.3)
        sounds['enter']:play()
        gStateMachine:change('play')

    end
    
end


function PlayState:render()

    if running then
        self.apple:render()
    -- print(tostring(self.head))
        self.head:render()
        for _, p in ipairs(self.snake) do
            p:render()
        end
        love.graphics.setFont(scoreFont)
        love.graphics.print('Score: '..tostring(SCORE), 0, VIRTUAL_HEIGHT - 10)

    elseif running == false then

        love.graphics.setFont(title_font)
        love.graphics.printf("Game Over", 0, 64, VIRTUAL_WIDTH, 'center')
    
        love.graphics.setFont(mediumFont)
        love.graphics.printf("Score: ".. tostring(SCORE), 0, 150, VIRTUAL_WIDTH, 'center')
    
        love.graphics.printf("Press Enter to Play again", 0, 200, VIRTUAL_WIDTH, 'center')
        gStateMachine:change('play')

    end
end