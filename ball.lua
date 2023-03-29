Ball = {}
Ball.__index = Ball

function Ball:create(width)

    local newBall = {

        width = width,
        height = width,
        speed = 600,
        pos = {

            x = 0,
            y = 0
    
        },
        vel = {

            x = 1,
            y = 1

        }

    }
    
    setmetatable(newBall, Ball)
    return newBall

end

function Ball:reset(turn)

    self.vel.y = math.sin(math.pi / 4) * self.speed
    local randY = math.random(0, 1) --random start direction for the ball

    if randY == 0 then --start from top headed downwards

        self.pos.y = (WINDOW_HEIGHT / 10) - (self.height / 2)

    else --start from bottom headed upwards

        self.pos.y = (WINDOW_HEIGHT - (WINDOW_HEIGHT / 10)) - (self.height / 2)
        self.vel.y = -self.vel.y

    end

    self.vel.x = math.cos(math.pi / 4) * self.speed
    self.pos.x = (WINDOW_WIDTH / 2) - (self.width / 2)

    if turn == "left" then

        self.vel.x = -self.vel.x

    else

    end

end

function Ball:bounce(paddle)

    local intersectY

    if (self.pos.y < paddle.pos.y) then

        intersectY = self.pos.y + self.height

    else

        intersectY = self.pos.y

    end

    local middlePaddle = paddle.pos.y + paddle.height / 2
    local collisionPoint = intersectY - middlePaddle --get the distance of the collision from the middle of the paddle
    local collisionPointNormalized = collisionPoint / (paddle.height / 2)
    local angle = collisionPointNormalized * (math.pi / 4)

    self.vel.x = math.cos(angle) * self.speed
    self.vel.y = math.sin(angle) * self.speed

end

function Ball:move(dt)

    self.pos.x = self.pos.x + self.vel.x * dt
    self.pos.y = self.pos.y + self.vel.y * dt

end

function Ball:checkCollision(paddle)

    if self.pos.x + self.width > paddle.pos.x
    
    and self.pos.y + self.height > paddle.pos.y

    and paddle.pos.x + paddle.width > self.pos.x

    and paddle.pos.y + paddle.height > self.pos.y then
    
        return true

    end

    return false

end

function Ball:checkOffScreen() 

    if self.pos.x < 0 then

        return "left"

    elseif self.pos.x + self.width > love.graphics.getWidth() then

        return "right"

    elseif self.pos.y < 0 then

        return "top"

    elseif self.pos.y + self.height > love.graphics.getHeight() then

        return "bottom"

    end

    return false

end

function Ball:render()

    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)

end