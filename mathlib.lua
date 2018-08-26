function factorial(n,x)
    x=x or n-1
    return x>0 and factorial(n*x,x-1) or x~=-1 and n or 1
end

function digitpull(n,place)
    return math.floor(n/10^(place-1))%10
end

function digits(n)
    return math.floor(math.log10(n,10)+1)
end

function round(n,m)
    m=m and m or 0
    return math.floor(n*10^m+0.5)/10^m
end

function sign( n, type )
    return n > 0 and 1 or n < 0 and -1 or type == 1 and 1 or type == 2 and -1 or 0
end

function triangle(n1,n2)
    return math.abs((n1-n2)%(2*n2)-n2)
end

function lerp(x1,x2,n)
    return n*(x1-x2)+x2
end

function bilerp(n0,n1,n2,n3,x,y)
    return lerp(lerp(n0,n1,x%scale/scale),lerp(n2,n3,x%scale/scale),y%scale/scale)
end

function cubiclerp(x1,x2,n)
    return (3*n^2-2*n^3)*(x1-x2)+x2
end

function bicubiclerp(n0,n1,n2,n3,x,y)
    return cubiclerp(cubiclerp(n0,n1,x%scale/scale),cubiclerp(n2,n3,x%scale/scale),y%scale/scale)
end

function perlinlerp(x1,x2,n)
    return (6*n^5-15*n^4+10*n^3)*(x1-x2)+x2
end

function biperlinlerp(n0,n1,n2,n3,x,y)
    return perlinlerp(perlinlerp(n0,n1,x%scale/scale),perlinlerp(n2,n3,x%scale/scale),y%scale/scale)
end

function dotprod(t1,t2)
    n=0
    for i=1,#t1 do
        n=n+t1[i]*t2[i]
    end
    return n
end

function dotprod2d(n1,n2,n3,n4)
    return n1*n3+n2*n4
end

--Provided by the Love2d wiki
function HSL(h, s, l, a)
	if s<=0 then return l,l,l,a end
	h = h*6
	local c = (1-math.abs(2*l-1))*s
	local x = (1-math.abs(h%2-1))*c
	local m,r,g,b = (l-.5*c), 0,0,0
	if h < 1     then r,g,b = c,x,0
	elseif h < 2 then r,g,b = x,c,0
	elseif h < 3 then r,g,b = 0,c,x
	elseif h < 4 then r,g,b = 0,x,c
	elseif h < 5 then r,g,b = x,0,c
	else              r,g,b = c,0,x
	end return (r+m),(g+m),(b+m),a
end
