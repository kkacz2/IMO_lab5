function fun_lab5
x0 = [-1,-1]; % Punkt poczatkowy
    function [y,g]=obj(x) %1 zmienna
        y=x.^2+2*x.^3;
        g=2*x+6*x.^2;
    end
    function [y,g]=obj1(x) %1 zmienna
        y=4*x.^2+2*x.^4;
        g=8*x+8*x.^3;
    end
    function [y,g]=obj2(x) %2 zmienne
        y=x(1)^2+0.5*x(2)^2;
        g=[2*x(1);x(2)];
    end
    function [y,g]=obj3(x) %2 zmienne
        y=2*x(1)^2+4*x(2)^2;
        g=[4*x(1);8*x(2)];
    end
    function [y,g]=obj4(x) %nier??niczkowalna
        y=abs(x(1))+abs(x(2));
        g=[0,0];
    end
    function [y,g]=obj5(x) %Rosenbrock
        y=(1-x(1))^2+100*(x(2)-x(1)^2)^2;
        g=[0,0];
    end

    function stop = out(x, optimvals, state) %funkcja stopu
        if isequal(state, 'iter')
           h = [h; x]; 
        elseif isequal(state, 'done')

        end
        stop = false;
    end
x = linspace(-4,4,100);
y = linspace(-4,4,100);
[X, Y] = meshgrid(x,y);
% Z = X.^3-2*X.^2;
% Z = 4*X.^2+2*X.^4;
% Z = X.^2+0.5*Y.^2;
% Z = 2*X.^2+4*Y.^2;
% Z = abs(X)+abs(Y);
 Z = (1-X).^2+100*(Y-X.^2).^2; 

 %% Newton
opt = optimset('OutputFcn',@out,'Display','iter','MaxIter',10,'gradobj','on');
h = [];
xk=[];
[x,f,e,o] = fminunc(@obj5, x0, opt);
    
figure(1);
contour(X,Y,Z);
hold on;
plot(h(:,1), h(:,2), 'mo-');
plot(h(end,1), h(end,2), 'bx');
xk=[h(end,1),h(end,2)]
title('Metoda Newtona');
hold off;
%% BFGS
opt = optimset('OutputFcn',@out,'Display','iter','MaxIter',10);
h = [];
xk=[];
[x,f,e,o] = fminunc(@obj5, x0, opt);

figure(2);
contour(X,Y,Z);
hold on;
plot(h(:,1), h(:,2), 'mo-');
plot(h(end,1), h(end,2), 'bx');
xk=[h(end,1),h(end,2)]
title('Metoda BFGS');
hold off;
%% Metoda DFP
opt = optimset('OutputFcn',@out,'Display','iter','MaxIter',10,'Hessupdate','dfp');
h = [];
xk=[];
[x,f,e,o] = fminunc(@obj5, x0, opt);
    
figure(3);
contour(X,Y,Z);
hold on;
plot(h(:,1), h(:,2), 'mo-');
plot(h(end,1), h(end,2), 'bx');
xk=[h(end,1),h(end,2)]
title('Metoda DFP');
hold off;
%% Steepdesc
opt = optimset('OutputFcn',@out,'Display','iter','MaxIter',10,'Hessupdate','steepdesc');
h = [];
xk=[];
[x,f,e,o] = fminunc(@obj5, x0, opt);
    
figure(4);
contour(X,Y,Z);
hold on;
plot(h(:,1), h(:,2), 'mo-');
plot(h(end,1), h(end,2), 'bx');
xk=[h(end,1),h(end,2)]
title('Metoda Steepdesc');
hold off;
%% Simplex
opt = optimset('OutputFcn',@out,'Display','iter','MaxIter',20);
h = [];
xk=[];
[x,f,e,o] = fminsearch(@obj5, x0, opt);
    
figure(5);
contour(X,Y,Z);
hold on;
plot(h(:,1), h(:,2), 'mo-');
plot(h(end,1), h(end,2), 'bx');
xk=[h(end,1),h(end,2)]
title('Metoda Simpleksu');
hold off;


% x0=[1 1];
% h=[];
% %opt=optimset('Display','iter','MaxIter',10) - BFGS
% %                                          ,'gradobj','on') - Newton
% %                                          ,'Hessupdate','steepdesc') -
% %                                          Steepdesc
% %                                          ,'Hessupdate','dfp') - DFP
% [x,f,o,e]=fminunc(@objfun,x0,opt);
% plot(h(:,1),h(:,2),'o:')
% 
%     function [z,g]=objfun(x)
%         z=x(1)^2+0.5x(2)^2;
%         g[2x(1); x(2)];
%         h=[h;x,z];
%     end
end