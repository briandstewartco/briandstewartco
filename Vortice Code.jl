using Printf
using Statistics
using LinearAlgebra

"""Vertical distance Function"""    #Take vertical, horizontal, and diagonal radius out and bring it to position function#
function distance_vertical()
    dy = 1
    return dy
end

"""Horizontal distance Function"""
function distance_horizontal()
    dx = 1
    return dx
end

"""Diaganol Radius Function"""
function radius(dx,dy)
    dx = 1
    dy = 1
    radius = sqrt(dx^2+dy^2)
    return radius
end

"""Induced Velocity Function vertical"""
function vertical_velocity(isleft,postive,gamma)
    dy = distance_vertical()
    r = [0; -dy; 0]
    vv = (cross(gamma,r)) ./ (2*pi*(dy)^2)
    return vv
end

"""Induced Velocity Function horizontal"""
function horizontal_velocity(isleft,positive,gamma)
    dx = distance_horizontal()
    if !isleft || !positive 
        r = [dx; 0; 0]
    else 
        r = [-dx; 0; 0]
    end
    vh = (cross(gamma,r)) ./ (2*pi*(dx)^2)
    return vh
end

"""Induced Velocity Function diagonal"""
function diagonal_velocity(isleft,positive,gamma)
    dx = distance_horizontal()
    dy = distance_vertical()
    radius = sqrt(dx^2+dy^2)
    if !isleft || !positive 
        r = [-dx; -dy; 0]
    else 
        r = [dx; -dy; 0]
    end
    vd = (cross(gamma,r)) ./ (2*pi*(radius)^2)
    return vd
end

"""Total Velocity Function"""
function velocity(isleft,positive,P0,gamma)
    vv = vertical_velocity(isleft,positive,gamma)
    vh = horizontal_velocity(isleft,positive,gamma)
    vd = diagonal_velocity(isleft,positive,gamma)
    v = vv + vh + vd                              #may need braodcast#
    return v
end

"""Position Function"""
function position(isleft,positive,P0,gamma,t)
    v = velocity(isleft,positive,P0,gamma)
    t = 0.01
     P = P0 + v.*t                                #loop through P array to create P0#
                                                  #This function is going to be the bulkiest function. There should be two loops that loop through P and t#
                                                  #return P array which is number of t steps by 3 (x,y,z)# 
    return P
end


function vortexplot(P0)
    t = collect(range(0,step = 0.01,stop = 10))
    x0 = getindex(P0,1)
    y0 = getindex(P0,2)
    gamma = [0; 0; 1]
    if x0 == 0 
        isleft = true
    else 
        isleft = false
    end
    if y0 > 0
        positive = true
    else
        positive = false
    end
    p = position(isleft,positive,P0,gamma,t)
    println(p)
end

vortexplot([0,-.5,0])
vortexplot([0,.5,0])
vortexplot([1,.5,0])
vortexplot([1,-.5,0])