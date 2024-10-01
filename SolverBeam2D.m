close all
clc
clear all

%% CONSTANTES

AI = 764e-4; %mm2
AII = 653e-4; %mm2

IzI=80.1e-8;
IzII=57.1e-8;

P = 500; %N
E = 210e9; %Pa
u=1;

LE = 235e6; %limite elastico Pa

L1 = 2;
L2 = 3;




%% INTRODUCCIÓN

% Matriz de rigidez global
Ngdl = 51;%numero de nodos(17)*grados de libertad(2) 
K = zeros(Ngdl);

%Puente cuyo origen de circunferencia está abajo
N = 4; %numero de vanos



%% NODOS

%Nodos de la base
x0 = [linspace(-((L1*N)/2),((L1*N)/2),N+1)]'; %dividir nodos entre 7
y0 = zeros(size(x0)); %(size: 7 filas y 1 columna)

%Nodo media planta
x05=[-4]';
y05=[1.5]';


%Nodos planta 1
x1 = x0 ;%puntos del eje x
y1 = [3 3 3 3 3]'; %puntos del eje y, lo aplicamos a la función de antes
 
%Nodo planta y media
x15=[-4]';
y15=[4.5]';


%Nodos planta 2
x2 = x0; %situar nodos en extremos
y2 = [6 6 6 6 6 ]';


%Nodos totales
nodos = [x0 y0 zeros(5,1); x05 y05 0; x1 y1 zeros(5,1); x15 y15 0; x2 y2 zeros(5,1)];
      %  base   arco  extremos



      
%% B A R R A S

%Creamos la matriz de elementos
elementos = [1 2;
             2 3;
             3 4;
             4 5;
             1 6;
             6 7;
             2 8;
             3 9;
             4 10;
             5 11;
             7 8;
             8 9;
             9 10;
             10 11;
             7 12;
             12 13;
             8 14;
             9 15;
             10 16;
             11 17;
             13 14;
             14 15;
             15 16;
             16 17;
             2 7;
             4 9;
             9 14;
             11 16;];
         



%% PROCEDIMIENTO

% CC_U
%u y v fijas que tienen desplazamiento 0;
cc_u = [ 1 0; %u1
         2 0; %v1
         3 0; %o1
         4 0; %u2
         5 0; %v2
         6 0; %o2
         7 0; %u3
         8 0; %v3
         9 0; %o3
        10 0; %u4
        11 0; %v4
        12 0; %o4
        13 0; %u5
        14 0; %v5
        15 0; %o5
        49 0; %u17
        50 0.00000001; %v17
        51 0]; %o17
  
    
 %33 0.01; %u17
 
% CC_F
%todos los impares 0 ya que corresponden a la componente horizontal 
%los nodos de libertad, por eso hay 34
cc_f =[ 1 0; %u1
        2 0; %v1
        3 0; %o1
        4 0; %u2 
        5 0; %v2 :)
        6 0; %o2
        7 0; %u3
        8 0; %v3
        9 0; %o3
        10 0; %u4
        11 P; %v4
        12 0; %o4
        13 P; %u5
        14 0; %v5
        15 0; %o5
        16 0; %u6
        17 0; %v6
        18 0; %o6
        19 0; %u7
        20 0; %v7
        21 0; %o7
        22 0; %u8
        23 P; %v8
        24 0; %o8
        25 P; %u9
        26 0; %v9
        27 0; %o9
        28 0; %u10
        29 0; %v10
        30 0; %o10
        31 0; %u11
        32 0; %v11
        33 0; %o11
        34 0; %u12
        35 0; %v12
        36 0; %o12
        37 0; %u13
        38 0; %v13
        39 0; %o13
        40 0; %u14
        41 0; %v14
        42 0; %o14
        43 0; %u15
        44 0; %v15
        45 0; %o15
        46 0; %u16
        47 0; %v16
        48 0; %o16
        49 0; %u17
        50 0; %v17
        51 0]; %o17



%% PROCEDIMIENTO

[ Uampl, nodosd ] = SolverEles( elementos, nodos, cc_f, cc_u, Ngdl, AI, AII, IzI,IzII, E, LE);
 %% NODO CON MAYOR DESPLAZAMIENTO
   
   aux2= zeros(size(Uampl,1)/3,1);
   cont=0;
   
   for i = 1:3: size(Uampl,1)
       cont=cont+1;
       aux2(cont,1)=Uampl(i,1);
      
   end

   cont=0;
   
   for i = 2:3: size(Uampl,1)
       cont=cont+1;
       aux2(cont,2)=Uampl(i,1);
      
   end
 
    
    cont=0;
    
    for i = 3:3: size(Uampl,1)
    cont=cont+1;
       aux2(cont,3)=Uampl(i,1);
      
    end
   
   
   aux=zeros(size(aux2,1),1);
   for i=1:size(aux2,1)
       
       a=aux2(i,1);
       b=aux2(i,2);
       c=aux2(i,3);
      
       aux(i,1)=i;
       aux(i,2) = sqrt(a^2+b^2+c^2);
     
   end
   
   
 nodoMaxDesplazado=[0 0];
 cont=0;
 contid=0;
 for i=1:size(aux)
     
     if aux(i,2)>cont
         
         cont=aux(i,2);
         contid=aux(i,1);
         
         nodoMaxDesplazado=[contid cont];
     end
     
     
 end

 disp('nodo con mayor desplazamiento y su valor: ' )
 nodoMaxDesplazado
   
   
   
   
   
%% DIBUJAR

figure(1)
hold all

%Ploteo solo nodos
%plot(nodos(:,1),nodos(:,2),'ok') 
plot(x0,y0,'^',x05,y05,'o',x1,y1,'o',x15,y15,'o',x2,y2,'o')

%Plotea nodos desplazados
 plot(nodosd(:,1),nodosd(:,2),'ob')
  

%Plotea desplazamiento vigas normales
for i = 1:(size(elementos,1))-4 %size de elementos es 28 y 2 pero como tenemos en el argumento un 1, es solo el size de filas
    
   elem = elementos(i,:);
   coordx = nodos([elem(1) elem(2)],1); %coordenada x de ambos nodos
   coordy = nodos([elem(1) elem(2)],2); %coordenada y de ambos nodos
   plot(coordx,coordy,'k','LineWidth',2)
 
end


%Plotea desplazamiento vigas diagonales
for i = (size(elementos,1))-4:(size(elementos,1)) %size de elementos es 28 y 2 pero como tenemos en el argumento un 1, es solo el size de filas
    
   elem = elementos(i,:);
   coordx = nodos([elem(1) elem(2)],1); %coordenada x de ambos nodos
   coordy = nodos([elem(1) elem(2)],2); %coordenada y de ambos nodos
   plot(coordx,coordy,'--k','LineWidth',2)
 
end

%Plotea desplazamiento
for i = 1:size(elementos,1) %size de elementos es 28 y 2 pero como tenemos en el argumento un 1, es solo el size de filas
    
   elem = elementos(i,:);
   coordx = nodosd([elem(1) elem(2)],1); %coordenada x de ambos nodos
   coordy = nodosd([elem(1) elem(2)],2); %coordenada y de ambos nodos
   plot(coordx,coordy,'b','LineWidth',2)
 
end


d = -0.5; %distancia de separación de la numeración

%Índice de números
for i = 1:size(nodos,1)
    
   coordx = nodos(i,1);
   coordy = nodos(i,2);
   text(coordx+d,coordy-d,num2str(i))

end


xlim([-12 12]);
ylim([-8 8]);
axis equal
axis padded
grid
hold off


%% FUNCIONES RESOLUTIVAS

function Kele = keleprima(E, A, L, Iz, xj, yj, xi ,yi) % siendo la K la K elemento y siendo la T la matriz de giro

    k11= [E*A/L       0               0;
           0    12*E*Iz/L^3     6*E*Iz/L^2;
           0    6*E*Iz/L^2      4*E*Iz/L    ];
       
       
    k22= [E*A/L       0               0;
           0    12*E*Iz/L^3     -6*E*Iz/L^2;
           0    -6*E*Iz/L^2      4*E*Iz/L    ];
       
       
    k12= [-E*A/L       0               0;
           0    -12*E*Iz/L^3     6*E*Iz/L^2;
           0    -6*E*Iz/L^2      4*E*Iz/L    ];
       
    Kprima = [k11  k12;
              k12' k22];


         %-sacar matriz de giro
          vecA=[(xj-xi) (yj- yi)];
          vecB=[1 0];
          o=acos(dot(vecA,vecB)/(norm(vecA)* norm(vecB)));
          
          T0 = [cos(o) sin(o) 0; 
               -sin(o) cos(o) 0;
                   0      0   1];
          
          T  = [T0 zeros(3); zeros(3) T0];

    Kele = T'*Kprima*T;
        
    
end

function [ Uampl, nodosd] = SolverEles( elementos, nodos,  cc_f, cc_u, Ngdl, AI, AII, IzI,IzII, E, LE) %siendo la Uampl los desplazamientos totales y los nodosd la ubicación de los nodos deformados
    
    
    % Inicializo matriz de rigidez global
    Kglobal= zeros(Ngdl);
    
    
    %Sacar matriz de rigidez local elemento a elemetno
    for elemento = 1:size(elementos,1)
      
        %sacar el area de cada barra
        if elemento < 24
           A=AI;
           Iz=IzI;
       
        else
           A=AII;
           Iz=IzII;
        end
        
        
        %nodoi y nodo j son los nodos por los que está 'formada' una barra
        nodoi = elementos(elemento,1);
        nodoj = elementos(elemento,2);
    
        
        %sacar los grados de libertad de cada nodo, es decir la u y la v de
        %cada nodo
        
        ui=3*nodoi-2;
        vi=3*nodoi-1;
        oi=3*nodoi;
        
        uj=3*nodoj-2;
        vj=3*nodoj-1;
        oj=3*nodoj;
        
        
        %sacar la L de cada barra con 
        xi=nodos(nodoi,1);
        yi=nodos(nodoi,2);
        xj=nodos(nodoj,1);
        yj=nodos(nodoj,2);
        
        L=sqrt((xj-xi)^2+(yj-yi)^2);
        
        
        %aplica la funcion kele para sacar k prima
        Ke=keleprima(E, A, L, Iz, xj,yj,xi,yi);
        
       
        %introducimos Kelemento en matriz K
        Kglobal([ui vi oi uj vj oj], [ui vi oi uj vj oj])=Kglobal([ui vi oi uj vj oj], [ui vi oi uj vj oj])+Ke;
        
   
         
     end


  
    %introducir Kele en la matriz K
    Kred = Kglobal;
    Kred(cc_u(:,1),:) = [];
    Kred(:,cc_u(:,1)) = [];
    
    Fred = cc_f(:,2);
    Fred(cc_u(:,1)) = [];
    
    Ured = Kred\Fred;
   % Ured=Ured*10^-42
    U = Ured;
    
    Uampl= zeros(Ngdl,1);
    gdl_noNulos = 1:Ngdl;
    gdl_noNulos(cc_u(:,1))=[];
 
    Uampl(gdl_noNulos) = U;

  Uampl([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 49 50 51])=cc_u(:,2);

 nodosd=zeros(size(nodos));
 nodosd=nodos;
 
 Uampl = Uampl*1000000;
 
   for i = 1: size(nodosd,1)
        
        nodos_ext = reshape(nodos',51,1);
        nodos_ext = nodos_ext + Uampl;
        nodosd    = reshape(nodos_ext,3,17)';
        

   end
   
   
 

    
end


