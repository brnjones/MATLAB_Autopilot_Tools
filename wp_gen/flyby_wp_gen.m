function [ B1, B2, B3 ] = flyby_wp_gen(A, B, C, radius)

   R=6378100;
  
   q1=(B-A)/norm(B-A);
   q2=(C-B)/norm(C-B);
   temp=acosd(-q1*q2')/2;
   B1=B-(radius/tand(temp))*q1;
   B2=B-(radius/sind(temp))*((q1-q2)/norm(q1-q2));
   B3=B+(radius/tand(temp))*q2;

        
end

