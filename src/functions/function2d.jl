function trainfunction2d(func,x,y)
    if func == 1
        a1 = 3 #rand(Uniform(-10,10))
        b1 = -4#rand(Uniform(-10,10))
        u = a1*x + b1*y
    elseif func == 2
        a = [0.9, 0.1, -0.4]#rand(Uniform(-1,1),3)
        b = [0.2, -0.6, -0.3]#rand(Uniform(-1,1),3)
        u = a[2]*sin(1*pi*y)+cos(1*pi*x)
    elseif func == 3
        a = [0.9464328087730216; 0.17162310348664844; 0.07857856828523646]    #rand(Uniform(-1,1),3)
        b = [0.9355991072384002, 0.5353806651162376, -0.0613925812939633]
        u = a[3]*sin(2*pi*y)+b[3]*cos(2*pi*x)
    elseif func == 4
        a = [-0.8752648836596824, -0.2937424545901659, 0.5352037919227479]#rand(Uniform(-1,1),3)
        b = [-0.9137179533411737, -0.4640307310161864, -0.8663071119500332]#rand(Uniform(-1,1),3)
        u1 = a[3]*sin(pi*x)+b[3]*cos(pi*y)
        u = u1 + a[1]*sin(2*pi*x)+b[1]*cos(2*pi*y)
    elseif func == 5
        a = [-0.6867267253726719, 0.21059347965868014, -0.728510882976293]#rand(Uniform(-1,1),3)
        b = [0.676235507814718, 0.8294240477938528, -0.3998500839840293]#rand(Uniform(-1,1),3)
        u1 = a[1]*sin(pi*x)+b[2]*cos(pi*y)
        u = u1 + a[3]*sin(2*pi*x)+b[3]*cos(2*pi*y)
    elseif func == 6
        a = [0.7983982959430316, 0.903381400725598, 0.6022370326216002]#rand(Uniform(-1,1),3)
        b = [-0.7513545425595294, -0.7714624763400932, -0.8408910576188569]#rand(Uniform(-1,1),3)
        u1 = a[1]*sin(pi*x)+b[1]*cos(pi*y)
        u2 = u1 + a[2]*sin(2*pi*x)+b[2]*cos(2*pi*y)
        u = u2 + a[3]*sin(3*pi*x)+b[3]*cos(3*pi*y)
    elseif func == 7
        a = [0.4456995188427575, -0.760694865555275, 0.5341392645364422]#rand(Uniform(-1,1),3)
        b = [0.6038471708245794, -0.9293109017054246, -0.03067895573440227]#rand(Uniform(-1,1),3)
        u1 = a[1]*sin(pi*x)+b[1]*cos(pi*y)
        u2 = u1 + a[2]*sin(2*pi*x)+b[2]*cos(2*pi*y)
        u = u2 + a[3]*sin(3*pi*x)+b[3]*cos(3*pi*y)
    elseif func == 8
        a1 = 8 #rand(Uniform(-10,10))
        b1 = -3 #rand(Uniform(-10,10))
        u = a1*x + b1*y
    elseif func == 9
        a =[0.2653910349699058, 0.4700076088116263, 0.09668422924668407, -0.046234710248600486, 0.20474920422233067, 0.5826924980829493]
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    elseif func == 10
        a =[-0.9017561219736625, -0.03447706434100306, 0.3305030118808854, 0.684511518915635, -0.661785410962842, 0.877713860698909]
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    elseif func == 11
        a =[-0.4, 1.0, 0.2, 0.6, -0.9, 0.8]   # rand(Uniform(-1,1),6)
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    elseif func == 13
        a = [0.8977676302413324, 0.5503759548450637, -0.6451820733536873]#rand(Uniform(-1,1),3)
        b = [0.8, -0.6, -0.3]#rand(Uniform(-1,1),3)
        u = a[2]*sin(1*pi*x)+cos(1*pi*y)
    elseif func == 12
        a =[-0.21587992491755914, -0.041287018187041724, -0.8635531658151585, -0.040103752643044555, -0.0632059673237162, -0.09508661768127391]
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    elseif func == 14
        a = [-0.9, 0.1, -0.4]#rand(Uniform(-1,1),3)
        b = [0.8, -0.6, -0.3]#rand(Uniform(-1,1),3)
        u = a[2]*sin(pi*x)+b[2]*cos(pi*y)
    elseif func == 15
        a1 = -1 #rand(Uniform(-10,10))
        b1 = 3 #rand(Uniform(-10,10))
        u = a1*x + b1*y
    elseif func == 16
        a = [0.2, 0.9, -0.6]#rand(Uniform(-1,1),3)
        b = [-0.1, 0.7, 0.1]#rand(Uniform(-1,1),3)
        u = a[1]*sin(2*pi*x)+b[1]*cos(2*pi*y)
    elseif func == 17
        a = [-0.6, 0.2, -0.9]#rand(Uniform(-1,1),3)
        b = [-1.0, -0.8, 0.3]#rand(Uniform(-1,1),3)
        u1 = a[1]*sin(pi*x)+b[1]*cos(pi*y)
        u2 = u1 + a[2]*sin(2*pi*x)+b[2]*cos(2*pi*y)
        u = u2 + a[3]*sin(3*pi*x)+b[3]*cos(3*pi*y)
    elseif func == 18
        a =[-0.4, 1.0, 0.2, 0.6, -0.9, 0.8]   # rand(Uniform(-1,1),6)
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    elseif func == 19 #10
        a = [0.2, 0.1, -0.4]#rand(Uniform(-1,1),3)
        b = [0.1, -0.6, -0.3]#rand(Uniform(-1,1),3)
        u = a[2]*sin(pi*x)+b[2]cos(pi*y)
    elseif func == 20
        a = [-0.6, 0.2, -0.9]#rand(Uniform(-1,1),3)
        b = [-1.0, -0.8, 0.3]#rand(Uniform(-1,1),3)
        u1 = a[1]*sin(pi*x)+b[1]*cos(pi*y)
        u2 = u1 + a[2]*sin(2*pi*x)+b[2]*cos(2*pi*y)
        u = u2 + a[3]*sin(3*pi*x)+b[3]*cos(3*pi*y)
    elseif func == 21
        a = [0.3, 0.4, -1.0]#rand(Uniform(-1,1),3)
        b = [1.0, -0.4, 0.6]#rand(Uniform(-1,1),3)
        u1 = a[1]*sin(pi*x)+b[1]*cos(pi*y)
        u2 = u1 + a[2]*sin(2*pi*x)+b[2]*cos(2*pi*y)
        u = u2 + a[3]*sin(3*pi*x)+b[3]*cos(3*pi*y)
    elseif func == 22
        a = [0.5, -0.9, -0.2]#rand(Uniform(-1,1),3)
        b = [0.1, 0.2, 0.8]#rand(Uniform(-1,1),3)
        u = a[1]*sin(2*pi*x)+b[1]*cos(2*pi*y)
    elseif func == 23
        a = [-0.2, -0.4, 0.9]#rand(Uniform(-1,1),3)
        b = [0.8, 0.6, -0.1]#rand(Uniform(-1,1),3)
        u = a[1]*sin(pi*x)+b[1]cos(pi*y)
    elseif func == 24
        a = [-0.2, -0.4, 0.9]#rand(Uniform(-1,1),3)
        b = [0.8, 0.6, -0.1]#rand(Uniform(-1,1),3)
        u1 = a[1]*sin(pi*x)+b[1]*cos(pi*y)
        u2 = u1 + a[2]*sin(2*pi*x)+b[2]*cos(2*pi*y)
        u = u2 + a[3]*sin(3*pi*x)+b[3]*cos(3*pi*y)
    elseif func == 25
        a = [-0.3, -0.2, 1.0]#rand(Uniform(-1,1),3)
        b = [1.0, -0.2, -0.6]#rand(Uniform(-1,1),3)
        u1 = a[1]*sin(pi*x)+b[1]*cos(pi*y)
        u2 = u1 + a[2]*sin(2*pi*x)+b[2]*cos(2*pi*y)
        u = u2 + a[3]*sin(3*pi*x)+b[3]*cos(3*pi*y)
    elseif func == 26
        a = [-0.1, -0.4, 1.0]#rand(Uniform(-1,1),3)
        b = [-1.0, 0.1, 0.8]#rand(Uniform(-1,1),3)
        u1 = a[1]*sin(pi*x)+b[1]*cos(pi*y)
        u = u1 + a[2]*sin(2*pi*x)+b[2]*cos(2*pi*y)
    elseif func == 27
        a = [0.8, 0.9, -0.2]#rand(Uniform(-1,1),3)
        b = [0.1, 0.2, -0.1]#rand(Uniform(-1,1),3)
        u = a[1]*sin(2*pi*x)+b[1]*cos(2*pi*y)
    elseif func == 28
        a = [0.2, -0.4, 0.9]#rand(Uniform(-1,1),3)
        b = [-0.8, 0.6, -0.1]#rand(Uniform(-1,1),3)
        u = a[1]*sin(pi*x)+b[1]cos(pi*y)
    elseif func == 29  #20
        a = [0.9, 0.4, -0.7]#rand(Uniform(-1,1),3)
        b = [0.9, -0.5, -0.3]#rand(Uniform(-1,1),3)
        u1 = a[1]*sin(pi*x)+b[1]*cos(pi*y)
        u2 = u1 + a[2]*sin(2*pi*x)+b[2]*cos(2*pi*y)
        u = u2 + a[3]*sin(3*pi*x)+b[3]*cos(3*pi*y)
    elseif func == 30
        a = [0.7, 0.0, -1.0]#rand(Uniform(-1,1),3)
        b = [0.0, -0.2, -0.6]#rand(Uniform(-1,1),3)
        u1 = a[1]*sin(pi*x)+b[1]*cos(pi*y)
        u2 = u1 + a[2]*sin(2*pi*x)+b[2]*cos(2*pi*y)
        u = u2 + a[3]*sin(3*pi*x)+b[3]*cos(3*pi*y)
    elseif func == 31
        a = [0.1, 1.0, 1.0]#rand(Uniform(-1,1),3)
        b = [-1.0, -0.3, 0.8]#rand(Uniform(-1,1),3)
        u1 = a[1]*sin(pi*x)+b[1]*cos(pi*y)
        u = u1 + a[2]*sin(2*pi*x)+b[2]*cos(2*pi*y)
    elseif func == 32
        a = [0.1, 0.9, -0.2]#rand(Uniform(-1,1),3)
        b = [0.2, 0.2, -0.1]#rand(Uniform(-1,1),3)
        u = a[1]*sin(2*pi*x)+b[1]*cos(2*pi*y)
    elseif func == 33
        a = [-0.3, -0.4, 0.9]#rand(Uniform(-1,1),3)
        b = [0.8, 0.6, -0.1]#rand(Uniform(-1,1),3)
        u = a[1]*sin(pi*x)+b[1]cos(pi*y)
    elseif func == 34
        a = [0.9, 0.1, -0.8]#rand(Uniform(-1,1),3)
        b = [0.9, 0.3, -0.3]#rand(Uniform(-1,1),3)
        u1 = a[1]*sin(pi*x)+b[1]*cos(pi*y)
        u2 = u1 + a[2]*sin(2*pi*x)+b[2]*cos(2*pi*y)
        u = u2 + a[3]*sin(3*pi*x)+b[3]*cos(3*pi*y)
    elseif func == 35
        a =[1.0, 0.3, -0.7, -0.2, 0.1, -0.9]    # rand(Uniform(-1,1),6)
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    elseif func == 36
        a =[-0.6, 1.0, 0.6, -0.8, -0.1, 0.7]    # rand(Uniform(-1,1),6)
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    elseif func == 37
        a =[0.9, -0.1, 0.1, -0.8, 0.4, -0.9]    # rand(Uniform(-1,1),6)
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    elseif func == 38
        a =[-1.0, 0.5, 0.2, -0.8, 0.0, -0.9]    # rand(Uniform(-1,1),6)
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    elseif func == 39
        a =[-0.4, 1.0, 0.2, 0.6, -0.9, 0.8]   # rand(Uniform(-1,1),6)
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    elseif func == 40
        a =[0.9, -1.0, 0.4, -0.2, 0.6, -0.2]    # rand(Uniform(-1,1),6)
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    elseif func == 41
        a =[0.4, -0.6, 1.0, 0.5, -0.5, 0.2]    # rand(Uniform(-1,1),6)
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    elseif func == 42
        a =[-0.2, 0.6, 0.3, 0.9, -0.7, 0.9]    # rand(Uniform(-1,1),6)
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    elseif func == 43
        a =[-1.0, -0.1, 0.1, 1.0, 0.1, 0.9]    # rand(Uniform(-1,1),6)
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    elseif func == 44
        a =[0.4, -0.2, 0.8, 0.6, -0.9, 0.8]   # rand(Uniform(-1,1),6)
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    elseif func == 45
        a =[1.0, 0.5, 0.9, -1.0, -0.1, 0.3]    # rand(Uniform(-1,1),6)
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    elseif func == 46
        a =[-0.4, -0.4, 0.9, 0.6, -0.9, -0.8]   # rand(Uniform(-1,1),6)
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    end
    return u
end

function troubledcellfunctionabs2d(x, y, a, m, x0, y0)
    u =  a*abs((y-y0)-m*(x-x0))
    return u
end

function troubledcellfunctionstep2d(x, y, ui, m, x0, y0)
    h1 = y0+m*(x-x0)
    h2 = y0-(1/m)*(x-x0)

    if y <= h1 && y < h2
        u=ui[1]
    elseif y >= h1 && y > h2
        u=ui[2]
    elseif y < h1 && y >= h2
        u=ui[3]
    elseif y > h1 && y <= h2
        u=ui[4]
    elseif y == h1 && y == h2
        u=ui[1]
    end
    return u
end

function roundstep2d(x, y, ui, r0, x0, y0)
    inicenter = SVector(x0, y0)
    x_norm = x - inicenter[1]
    y_norm = y - inicenter[2]
    r = sqrt(x_norm^2 + y_norm^2)

    # Calculate primitive variables
    u = r > r0 ? ui[1] : ui[2]
    return u
end

function good_cell2d(node_coord, length, func, m, x0, y0)
    x1 = node_coord[1]
    y1 = node_coord[2]
    x2 = node_coord[1] + length
    y2 = node_coord[2] + length

    if func == 1
        y1_abs = y0 + m*(x1-x0)
        y2_abs = y0 + m*(x2-x0)
        x1_abs = x0 + (1/m)*(y1-y0)
        x2_abs = x0 + (1/m)*(y2-y0)
        if  y1_abs <=y2 && y1_abs >= y1
            false
        elseif y2_abs <=y2 && y2_abs >= y1
            false
        elseif x1_abs <= x2 && x1_abs >= x1
            false
        elseif x2_abs <= x2 && x2_abs >= x1
            false
        else
            true
        end
    elseif func == 2 || func == 3
        y1_step = y0 + m*(x1-x0)
        y2_step = y0 + m*(x2-x0)
        x1_step = x0 + (1/m)*(y1-y0)
        x2_step = x0 + (1/m)*(y2-y0)
        y1_step2 = y0 -(1/m)*(x1-x0)
        y2_step2 = y0 -(1/m)*(x2-x0)
        x1_step2 = x0 - m*(y1-y0)
        x2_step2 = x0 - m*(y2-y0)
        if  (y1_step <=y2 && y1_step >= y1) ||  (y1_step2 <=y2 && y1_step2 >= y1 )
            false
        elseif (y2_step <=y2 && y2_step >= y1 ) || (y2_step2 <=y2 && y2_step2 >= y1  )
            false
        elseif (x1_step <= x2 && x1_step >= x1 ) ||  (x1_step2 <= x2 && x1_step2 >= x1)
            false
        elseif (x2_step <= x2 && x2_step >= x1)  || (x2_step2 <= x2 && x2_step2 >= x1)
            false
        else
            true
        end
    elseif func == 4
        inicenter = SVector(x0, y0)
        x_norm1 = x1 - inicenter[1]
        x_norm2 = x2 - inicenter[1]
        y_norm1 = y1 - inicenter[2]
        y_norm2 = y2 - inicenter[2]

        r1 = sqrt(x_norm1^2 + y_norm1^2)
        r2 = sqrt(x_norm2^2 + y_norm1^2)
        r3 = sqrt(x_norm1^2 + y_norm2^2)
        r4 = sqrt(x_norm2^2 + y_norm2^2)
        if (r1 <= m && r2 >=m) || (r1>= m && r2 <=m)
            false
        elseif (r1 <= m && r3 >=m) || (r1>= m && r3 <=m)
            false
        elseif (r2 <= m && r4 >=m) || (r2>= m && r4 <=m)
            false
        elseif (r3 <= m && r4 >=m) || (r3>= m && r4 <=m)
            false
        else
            true
        end
    end
end

function validfunction2d(func,x,y)
    if func == 1
        a = [-0.2, 0.8, -0.7    ]#rand(Uniform(-1,1),3)
        b = [-1.0, 0.4, -0.1]   #rand(Uniform(-1,1),3)
        u1 = a[1]*sin(pi*x)+b[1]cos(pi*y)
        u2 = u1 + a[2]*sin(2*pi*x)+b[2]cos(2*pi*y)
        u = u2 + a[3]*sin(3*pi*x)+b[3]cos(3*pi*y)
    elseif func == 2
        a = [0.4, -0.8, 0.1]    #rand(Uniform(-1,1),3)
        b = [0.1, -0.6, 0.9]    #rand(Uniform(-1,1),3)
        u1 = a[1]*sin(pi*x)+b[1]cos(pi*y)
        u2 = u1 + a[2]*sin(2*pi*x)+b[2]cos(2*pi*y)
        u = u2 + a[3]*sin(3*pi*x)+b[3]cos(3*pi*y)
    elseif func == 3
        a = [0.4]
        b = [0.1]
        u = a[1]*sin(pi*x)+b[1]cos(pi*y)
    elseif func == 4
        a = [-0.4]
        b = [0.9]
        u = a[1]*sin(pi*x)+b[1]sin(pi*y)
    elseif func == 5
        a = [0.4]
        b = [-0.7]
        u = a[1]*sin(2*pi*x)+b[1]sin(2*pi*y)
    elseif func == 6
        a =[0.3, -0.1]# rand(Uniform(-1,1),6)
        u = a[1]*x + a[2]*x^2
    elseif func == 7
        a =[-0.1, 0.6, 0.8]# rand(Uniform(-1,1),6)
        u = a[1]*x + a[2]*x^2 + a[3]*x^3
    elseif func == 8
        #a =[-0.5, -0.1, -0.8, 0.8]# rand(Uniform(-1,1),6)
        #u = a[1]*x + a[2]*x^2 + a[3]*x^3 + a[4]*x^4
        a =[1.0, 0.5, 0.9, -1.0, -0.1, 0.3]    # rand(Uniform(-1,1),6)
        u = exp(a[1]*((x-a[2])^2+(y-a[3])^2)) + exp(a[4]*((x-a[5])^2+(y-a[6])^2))
    elseif func == 9
        a =[0.8, -0.4, 0.1]# rand(Uniform(-1,1),6)
        u = a[1]*x + a[2]*x^2 + a[3]*x^3
    end
    return u
end






