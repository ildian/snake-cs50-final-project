
TitleState = Class {__includes = BaseState}

function TitleState:update(dt)

    if love.isPressed("enter") or love.isPressed("return") then

        sounds['enter']:setVolume(0.3)
        sounds['enter']:play()
        gStateMachine:change('play')

    end
end

function TitleState:render()

    love.graphics.setFont(title_font)
    love.graphics.printf("The Snake!", 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf("Press Enter ", 0, 150, VIRTUAL_WIDTH, 'center')


end