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
    font = love.graphics.getFont()

    game = Game:new()
    leftPaddle = Paddle:create(20, WINDOW_HEIGHT / 2 - 50, 20, 100, "w", "s")
    rightPaddle = Paddle:create(WINDOW_WIDTH - 40, WINDOW_HEIGHT / 2 - 50, 20, 100, "up", "down")
    ball = Ball:create(16)

end

function love.update(dt)

    if game.isRunning == false then

        if love.keyboard.isDown("return") then

            game:reset()
            ball:reset()
            rightPaddle:setPosition(WINDOW_WIDTH - 40, WINDOW_HEIGHT / 2 - 50)
            leftPaddle:setPosition(20, WINDOW_HEIGHT / 2 - 50)
            game.isRunning = true
    
        end

    elseif game.isRunning then

        --wall collision
        
        local wall = ball:checkOffScreen()

        if wall == "right" then

            game:incrementPlayerOne()
            game:toggleTurn() --change ball direction
            ball:reset(game.turn)

        elseif wall == "left" then

            game:incrementPlayerTwo()
            game:toggleTurn()
            ball:reset(game.turn)

        elseif wall == "top" then
        
            ball:toggleDirY()
            ball.y = 0 --fix collision overlap issue
        
        elseif wall == "bottom" then

            ball:toggleDirY()
            ball.y = love.graphics.getHeight() - ball.height

        end

        --paddle collision

        if ball:checkCollision(leftPaddle) then

            ball:toggleDirX()
            ball.x = leftPaddle.x + leftPaddle.width --fix collision overlap issue

        elseif ball:checkCollision(rightPaddle) then

            ball:toggleDirX()
            ball.x = rightPaddle.x - ball.width

        end

        --movement

        ball:move(dt)
        leftPaddle:move(dt)
        rightPaddle:move(dt)

        --game status

        if game:didEnd() then

            game:decideWinner()
            game.isRunning = false

        end

    end

end

function love.draw()
    
    if game.isRunning then

        game:renderScores()
        game:renderLines()

        ball:render()

        leftPaddle:render()
        rightPaddle:render()

    elseif game.isRunning == false then

        love.graphics.clear()
        game:renderMenu()

    end

end