function [ bool ] = ovlap(p2x,p2y,p4x,p4y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    p1x = p2x - 128;
    p1y = p2y - 128;
    p3x = p4x - 128;
    p3y = p4y - 128;
    if(p2y < p3y ||  p1y > p4y || p2x < p3x || p1x > p4x )
        bool = false;
    else
        bool = true;
    end
        
end

