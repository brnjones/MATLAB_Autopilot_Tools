   function wp_planar=geo2planar(ref,wp)
   %I switched this to match, latitude then longitude.
        wp_planar(2,:)=(wp(2,:)-ref(2))* (pi/180);
        wp_planar(1,:)=(wp(1,:)-ref(1))* cosd(ref(2))*(pi/180);
    end