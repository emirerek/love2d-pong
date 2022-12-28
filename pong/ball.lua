math.randomseed(os.time())

Ball = {}
Ball.__index = Ball

function Ball:create(width)

    local newBall = {

        x = 0,
        y = 0,
        width = width,
        heigth = width,
        speed = 500,
        dirX = 1,
        dirY = 1

    }
    
    setmetatable(newBall, Ball)
    return newBall

end

function Ball:reset(windowWidth, windowHeigth, dirX)

    local randY = math.random(0, 1) --random start direction for the ball

    if randY == 0 then

        self.y = windowHeigth / 10 - self.heigth / 2

    else

        self.y = (windowHeigth - windowHeigth / 10) - self.heigth / 2

    end

    self.x = windowWidth / 2 - self.width / 2

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
    
    and self.y + self.heigth > paddle.y

    and paddle.x + paddle.width > self.x

    and paddle.y + paddle.heigth > self.y then
    
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

    elseif self.y + self.heigth > love.graphics.getHeight() then

        return "bottom"

    end

    return false

end

function Ball:render()

    love.graphics.rectangle("fill", self.x, self.y, self.width, self.heigth)

end