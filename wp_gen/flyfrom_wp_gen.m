function [ B1, B2, B3, P2, r0, m] = flyfrom_wp_gen( A, B, C, radius )
    %B(1)=0;
    %B(2)=0;
    
    B1=B;
    q1=(B1-A)/norm(B1-A);
    B2=B1-radius*[q1(2) -q1(1)];

    if(dot([B2(1)-B1(1) B2(2)-B1(2)],[C(1)-B1(1) C(2)-B1(2)])) > 0
        side=1;
    else
        side=-1;
        B2=B1-side*radius*[q1(2) -q1(1)];
    end

    m=(B2+C)/2;
    r0=sqrt( (m(1)-C(1))^2+(m(2)-C(2))^2);
    d=r0;
    a1=(d^2-radius^2+d^2)/(2*d);
    P2=m+(a1*(B2-m))/d;
    h=(sqrt(r0^2-a1^2));
    B3(1)=P2(1)-side*h*(B2(2)-m(2))/d;
    B3(2)=P2(2)+side*h*(B2(1)-m(1))/d;
    
end

