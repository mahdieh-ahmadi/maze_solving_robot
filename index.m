clear all
close all
clc

vrep=remApi('remoteApi');
vrep.simxFinish(-1); % just in case, close all opened connections
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);

if (clientID>-1)
    disp('hello');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Handle%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%motors
    [returnCode,left_motor]=vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_leftMotor',vrep.simx_opmode_blocking);
    [returnCode,right_motor]=vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_rightMotor',vrep.simx_opmode_blocking);
    
    %%%%%sensores
    [returnCode,ultra_sensore_front]=vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_ultrasonicSensor4',vrep.simx_opmode_blocking);
    [returnCode,ultra_sensore_left]=vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_ultrasonicSensor4',vrep.simx_opmode_blocking);
    [returnCode,ultra_sensore_right]=vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_ultrasonicSensor4',vrep.simx_opmode_blocking);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%other code%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%run motors
    [returnCode]=vrep.simxSetJointTargetVelocity(clientID,left_motor,1,vrep.simx_opmode_blocking);
    [returnCode]=vrep.simxSetJointTargetVelocity(clientID,right_motor,1,vrep.simx_opmode_blocking);
    
    %%%%%initial sensores
    [returnCode,detectionState,detectedPoint_front,~,~]=vrep.simxReadProximitySensor(clientID,ultra_sensore_front,vrep.simx_opmode_streaming);
    [returnCode,detectionState,detectedPoint_left,~,~]=vrep.simxReadProximitySensor(clientID,ultra_sensore_left,vrep.simx_opmode_streaming);
    [returnCode,detectionState,detectedPoint_right,~,~]=vrep.simxReadProximitySensor(clientID,ultra_sensore_right,vrep.simx_opmode_streaming);
    
    for i=1:5000
        [returnCode,detectionState,detectedPoint_front,~,~]=vrep.simxReadProximitySensor(clientID,ultra_sensore_front,vrep.simx_opmode_buffer);
        [returnCode,detectionState,detectedPoint_left,~,~]=vrep.simxReadProximitySensor(clientID,ultra_sensore_left,vrep.simx_opmode_buffer);
        [returnCode,detectionState,detectedPoint_right,~,~]=vrep.simxReadProximitySensor(clientID,ultra_sensore_right,vrep.simx_opmode_buffer);
    
        %display(norm(detectedPoint));
        if(norm(detectedPoint_front) > 0.5)
            
        elseif(norm(detectedPoint_left) > 0.5)
                
        elseif(norm(detectedPoint_right) > 0.5)
         
        elseif(norm(detectedPoint_front) > 0.5 && norm(detectedPoint_left) > 0.5)
            
        elseif(norm(detectedPoint_front) > 0.5 && norm(detectedPoint_right) > 0.5)
            
        elseif(norm(detectedPoint_left) > 0.5 && norm(detectedPoint_right) > 0.5)
            
        elseif(norm(detectedPoint_front) > 0.5 && norm(detectedPoint_right) > 0.5 && norm(detectedPoint_left) > 0.5)
            
        else
            
        end
        pause(0.1);
    end
    [returnCode]=vrep.simxSetJointTargetVelocity(clientID,left_motor,0,vrep.simx_opmode_blocking);
    [returnCode]=vrep.simxSetJointTargetVelocity(clientID,right_motor,0,vrep.simx_opmode_blocking);
else
    disp('Failed connecting to remote API server');
end
vrep.simxFinish(-1);
vrep.delete(); % call the destructor!
disp('Program ended');