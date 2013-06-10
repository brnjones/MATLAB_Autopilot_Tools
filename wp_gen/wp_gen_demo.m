function figure_button_down_fcn

%% Input Parameters %%%%%%
    type=2;     %1=Fly by, 2=fly to, 3=fly_from    
    A(1)=0;
    A(2)=0;
    C(1)=20;
    C(2)=20;
    radius=4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Interactive GUI Admin.
    a = @newfig; % Create a function handle to the newfig function  
    figure(1)
    set(gcf,'windowbuttonmotion',a)
  
    function plotwaypoints(One,Two)
        cla
        B(1)=Two;
        B(2)=One;

        switch type
            case 1
                [ B1, B2, B3 ] = flyby_wp_gen(A, B, C, radius);           
            case 2
                [ B1, B2, B3, P2, r0, m] = flyto_wp_gen(A, B, C, radius);
            case 3                                
                [ B1, B2, B3, P2, r0, m] = flyfrom_wp_gen(A, B, C, radius); 
        end
    %% plotting
        deg=0:360;
        figure(1)
        plot(radius*sind(deg)+B2(1),radius*cosd(deg)+B2(2),'k:')
        
        %If fly-to or fly-from plot other reference points and circle. 
        if type==3 || type==2
            plot(P2(1),P2(2),'x')
            text(P2(1),P2(2),'P2')
            plot(r0*sind(deg)+m(1),r0*cosd(deg)+m(2),'k:')
            plot(m(1),m(2),'x')
            text(m(1),m(2),'m') 
        end
        
        hold on
        plot(A(1),A(2),'o',B1(1),B1(2),'x',C(1),C(2),'o', B(1),B(2),'o')
        plot([A(1) B1(1)],[A(2) B1(2)])
        plot([B3(1) C(1)],[B3(2) C(2)])
        ylim([-1 30])
        xlim([-1 30])
        hold on
        text(A(1),A(2),'A')
        text(B1(1),B1(2),'B1')
        text(C(1),C(2),'C')
        text(B(1),B(2),'B')
        plot(B2(1),B2(2),'^')
        text(B2(1),B2(2),'B2')
        plot(B3(1),B3(2),'*')
        text(B3(1),B3(2),'B3')
        hold all
    end
%% Call back
    function newfig(src,evnt)
        test=get(gca,'CurrentPoint');
        plotwaypoints(test(1,2),test(1,1))
    end
end