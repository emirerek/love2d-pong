Ball = {}
Ball.__index = Ball

function Ball:create(width)

    local newBall = {

        x = 0,
        y = 0,
        width = width,
        height = width,
        speed = 500,
        dirX = 1,
        dirY = 1

    }
    
    setmetatable(newBall, Ball)
    return newBall

end

function Ball:reset(dirX)

    local randY = math.random(0, 1) --random start direction for the ball

    if randY == 0 then

        self.y = WINDOW_HEIGHT / 10 - self.height / 2

    else

        self.y = (WINDOW_HEIGHT - WINDOW_HEIGHT / 10) - self.height / 2

    end

    self.x = WINDOW_WIDTH / 2 - self.width / 2

    if dirX ~= nil then 

        self.dirX = dirX

    end

end

function Ball:toggleDirX()

    self.dirX = -self.dirX

end

function Ball:toggleDirY()

    self.dirY = -self.dirY

end

function Ball:move(dt)

    self.x = self.x + self.speed * (self.dirX * dt)
    self.y = self.y + self.speed * (self.dirY * dt)

end

function Ball:checkCollision(paddle)

    if self.x + self.width > paddle.x
    
    and self.y + self.height > paddle.y

    and paddle.x + paddle.width > self.x

    and paddle.y + paddle.height > self.y then
    
        return true

    end

    return false

end

function Ball:checkOffScreen() 

    if self.x < 0 then

        return "left"

    elseif self.x + self.width > love.graphics.getWidth() then

        return "right"

    elseif self.y < 0 then

        return "top"

    elseif self.y + self.height > love.graphics.getHeight() then

        return "bottom"

    end

    return false

end

function Ball:render()

    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

end