{ config, ... }:{
  
  #Fingerprint Scanner
  #https://github.com/ahbnr/nixos-06cb-009a-fingerprint-sensor
  services."06cb-009a-fingerprint-sensor" = {                                 
    enable = true;                                                            
    backend = "libfprint-tod";   
    calib-data-file = /home/${config.vars.user}/.config/fingerprint/calib-data.bin;                                           
  };
}