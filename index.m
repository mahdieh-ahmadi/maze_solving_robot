clear all
close all
clc

vrep=remApi('remoteApi');
vrep.simxFinish(-1); % just in case, close all opened connections
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);

if (clientID>-1)
    
else
    disp('Failed connecting to remote API server');
end
vrep.simxFinish(-1);
vrep.delete(); % call the destructor!
disp('Program ended');