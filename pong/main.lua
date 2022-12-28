WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
CONFIG = {

    fullscreen = false,
    vsync = true,
    resizable = false

}

require "paddle"
require "ball"
require "game"

function love.load()

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, CONFIG)
    love.window.setTitle("Pong")
    love.graphics.setNewFont(70)

    game = Game:new()
    leftPaddle = Paddle:create(20, WINDOW_HEIGHT / 2 - 50, 20, 100)
    rightPaddle = Paddle:create(WINDOW_WIDTH - 40, WINDOW_HEIGHT / 2 - 50, 20, 100)
    ball = Ball:create(16)

    ball:reset(WINDOW_WIDTH, WINDOW_HEIGHT)

end

function love.update(dt)

    if (game.isRunning) then
        
        local wall = ball:checkOffScreen()

        if wall == "right" then

            game:incrementPlayerOne()
            game:toggleTurn()
            ball:reset(WINDOW_WIDTH, WINDOW_HEIGHT, game.turn)

        elseif wall == "left" then

            game:incrementPlayerTwo()
            game:toggleTurn()
            ball:reset(WINDOW_WIDTH, WINDOW_HEIGHT, game.turn)

        elseif wall == "top" then
        
            ball:toggleDirY()
            ball.y = 0 --fix collision overlap issue
        
        elseif wall == "bottom" then

            ball:toggleDirY()
            ball.y = love.graphics.getHeight() - ball.heigth --fix collision overlap issue

        end

        if ball:checkCollision(leftPaddle) then

            ball:toggleDirX()
            ball.x = leftPaddle.x + leftPaddle.width

        elseif ball:checkCollision(rightPaddle) then 

            ball:toggleDirX()
            ball.x = rightPaddle.x - ball.width

        end

        if love.keyboard.isDown("w") then

            leftPaddle:moveUp(dt)
    
        end
    
        if love.keyboard.isDown("s") then
    
            leftPaddle:moveDown(dt)
    
        end
    
        if love.keyboard.isDown("up") then
    
            rightPaddle:moveUp(dt)
    
        end
    
        if love.keyboard.isDown("down") then
    
            rightPaddle:moveDown(dt)
    
        end

        ball:move(dt)

    else

        if love.keyboard.isDown("return") then

            game:run()
    
        end

    end

end

function love.draw()

    love.graphics.print(love.timer.getFPS(), 20, 20)
    
    game:renderScores(WINDOW_WIDTH, WINDOW_HEIGHT)
    leftPaddle:render()
    rightPaddle:render()
    
    if (game.isRunning) then

        ball:render()

    end

    --if (game.winner ~= nil) then

        --game:renderWinner(WINDOW_WIDTH, WINDOW_HEIGHT)

    --end

end



