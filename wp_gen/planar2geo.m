    function wp_geo=planar2geo(ref,wp)
        wp_geo(2)=wp(2)*(1/cosd(ref(1)))*(180/pi)+ref(2);
        wp_geo(1)=wp(1)*(180/pi)+ref(1);
    end