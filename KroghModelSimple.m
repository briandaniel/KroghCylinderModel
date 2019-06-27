function [r,z,Psltn] = KroghModelSimple(prm)
%%
% Brian Hong 6-19-19
%
% File determines the equations of the Krogh cylinder model of oxygen
% transport used in Mcguire, Secomb (2001)
%

    z = linspace(0,prm.L,prm.Nz);
    r_tissue = linspace(prm.Rc,prm.Rt,prm.Nr);
    
    Psltn = zeros(prm.Nr, prm.Nz);
    
    Pb = prm.Pb;
 
    for k = 1:prm.Nz
       
        if( k > 1 )
            % compute the integral
            MP = prm.M0*( P/(prm.P0 + P) );
            q = 2*pi*trapz(r,MP*r);
            Shbi = (Pb/prm.P50)^prm.n / ( 1 + (Pb/prm.P50)^prm.n );
            Ci = prm.Cb*Shbi;
            dz = z(k)-z(k-1);
            volFlowRate = prm.Vbar*pi*prm.Rc.^2;
            Ciplus1 = Ci - dz * ( q /volFlowRate );       
            Pb = prm.P50*( Ciplus1/(prm.Cb - Ciplus1) ).^(1/prm.n);
        end

        solinit = bvpinit( r_tissue, @guess );
        
        odeFunc = @(r,Y) diffusionODE( r, Y, prm);
        bcFunc = @(ya,yb) diffusionODE_BC( ya, yb, prm, Pb );
        
        sol = bvp4c(odeFunc, bcFunc, solinit );

        P = interp1( sol.x, sol.y(1,:), r_tissue );
        r = r_tissue;
        
        Psltn(:,k) = P;
        
        disp(['Solving step k = ', num2str(k), '/', num2str(prm.Nz)]);
    end

    
    
end


function g = guess(r)

    g = [1+r*0; 0*r];
    
end


function [dY] = diffusionODE( r, Y, prm )
    

    %NOTE: Y(1) = P, Y(2) = u, where u is the aux variable u = P'
    P = Y(1);
    u = Y(2);

    K = prm.K;
     
    % Oxygen consumption rate (per unit volume)
    MP = prm.M0*( P/(prm.P0 + P) );

    % In this case the derivatve is directly evaluated
    dudr = -u/r + 1/K*MP;
    dPdr = u;


    dY = [ dPdr; dudr];


end


function res = diffusionODE_BC( Ya, Yb, prm, Pb )

    P_Rc = Ya(1);
    dPdr_Rc = Ya(2);
    
    dPdr_Rt = Yb(2);
    

    res1 = 2*pi*prm.Rc*prm.K*dPdr_Rc + prm.Mt*(Pb-P_Rc);
    res2 = dPdr_Rt;
    
    res = [res1; res2];
  
end













































