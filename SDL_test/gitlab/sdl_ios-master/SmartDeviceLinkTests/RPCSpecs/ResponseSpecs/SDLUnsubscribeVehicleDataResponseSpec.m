//
//  SDLUnsubscribeVehicleDataResponseSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLUnsubscribeVehicleDataResponse.h"
#import "SDLRPCParameterNames.h"
#import "SDLRPCFunctionNames.h"
#import "SDLVehicleDataResult.h"
#import "SDLVehicleDataResultCode.h"

QuickSpecBegin(SDLUnsubscribeVehicleDataResponseSpec)

SDLVehicleDataResult* vehicleDataResult = [[SDLVehicleDataResult alloc] init];
SDLVehicleDataResult* customOEMvehicleDataResult = [[SDLVehicleDataResult alloc] initWithCustomOEMDataType:@"customOEMVehicleData" resultCode:SDLVehicleDataResultCodeSuccess];

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLUnsubscribeVehicleDataResponse* testResponse = [[SDLUnsubscribeVehicleDataResponse alloc] init];
        
        testResponse.gps = vehicleDataResult;
        testResponse.speed = vehicleDataResult;
        testResponse.rpm = vehicleDataResult;
        testResponse.fuelLevel = vehicleDataResult;
        testResponse.fuelLevel_State = vehicleDataResult;
        testResponse.fuelRange = vehicleDataResult;
        testResponse.instantFuelConsumption = vehicleDataResult;
        testResponse.externalTemperature = vehicleDataResult;
        testResponse.prndl = vehicleDataResult;
        testResponse.tirePressure = vehicleDataResult;
        testResponse.odometer = vehicleDataResult;
        testResponse.beltStatus = vehicleDataResult;
        testResponse.bodyInformation = vehicleDataResult;
        testResponse.deviceStatus = vehicleDataResult;
        testResponse.driverBraking = vehicleDataResult;
        testResponse.wiperStatus = vehicleDataResult;
        testResponse.headLampStatus = vehicleDataResult;
        testResponse.engineOilLife = vehicleDataResult;
        testResponse.engineTorque = vehicleDataResult;
        testResponse.accPedalPosition = vehicleDataResult;
        testResponse.steeringWheelAngle = vehicleDataResult;
        testResponse.eCallInfo = vehicleDataResult;
        testResponse.airbagStatus = vehicleDataResult;
        testResponse.emergencyEvent = vehicleDataResult;
        testResponse.clusterModes = vehicleDataResult;
        testResponse.myKey = vehicleDataResult;
        testResponse.electronicParkBrakeStatus = vehicleDataResult;
        testResponse.turnSignal = vehicleDataResult;
        testResponse.cloudAppVehicleID = vehicleDataResult;
        
        expect(testResponse.gps).to(equal(vehicleDataResult));
        expect(testResponse.speed).to(equal(vehicleDataResult));
        expect(testResponse.rpm).to(equal(vehicleDataResult));
        expect(testResponse.fuelLevel).to(equal(vehicleDataResult));
        expect(testResponse.fuelLevel_State).to(equal(vehicleDataResult));
        expect(testResponse.fuelRange).to(equal(vehicleDataResult));
        expect(testResponse.instantFuelConsumption).to(equal(vehicleDataResult));
        expect(testResponse.externalTemperature).to(equal(vehicleDataResult));
        expect(testResponse.prndl).to(equal(vehicleDataResult));
        expect(testResponse.tirePressure).to(equal(vehicleDataResult));
        expect(testResponse.odometer).to(equal(vehicleDataResult));
        expect(testResponse.beltStatus).to(equal(vehicleDataResult));
        expect(testResponse.bodyInformation).to(equal(vehicleDataResult));
        expect(testResponse.deviceStatus).to(equal(vehicleDataResult));
        expect(testResponse.driverBraking).to(equal(vehicleDataResult));
        expect(testResponse.wiperStatus).to(equal(vehicleDataResult));
        expect(testResponse.headLampStatus).to(equal(vehicleDataResult));
        expect(testResponse.engineOilLife).to(equal(vehicleDataResult));
        expect(testResponse.engineTorque).to(equal(vehicleDataResult));
        expect(testResponse.accPedalPosition).to(equal(vehicleDataResult));
        expect(testResponse.steeringWheelAngle).to(equal(vehicleDataResult));
        expect(testResponse.eCallInfo).to(equal(vehicleDataResult));
        expect(testResponse.airbagStatus).to(equal(vehicleDataResult));
        expect(testResponse.emergencyEvent).to(equal(vehicleDataResult));
        expect(testResponse.clusterModes).to(equal(vehicleDataResult));
        expect(testResponse.myKey).to(equal(vehicleDataResult));
        expect(testResponse.electronicParkBrakeStatus).to(equal(vehicleDataResult));
        expect(testResponse.turnSignal).to(equal(vehicleDataResult));
        expect(testResponse.cloudAppVehicleID).to(equal(vehicleDataResult));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary<NSString *, id> *dict = [@{SDLRPCParameterNameResponse:
                                                           @{SDLRPCParameterNameParameters:
                                                                 @{SDLRPCParameterNameGPS:vehicleDataResult,
                                                                   SDLRPCParameterNameSpeed:vehicleDataResult,
                                                                   SDLRPCParameterNameRPM:vehicleDataResult,
                                                                   SDLRPCParameterNameFuelLevel:vehicleDataResult,
                                                                   SDLRPCParameterNameFuelLevelState:vehicleDataResult,
                                                                   SDLRPCParameterNameFuelRange:vehicleDataResult,
                                                                   SDLRPCParameterNameInstantFuelConsumption:vehicleDataResult,
                                                                   SDLRPCParameterNameExternalTemperature:vehicleDataResult,
                                                                   SDLRPCParameterNamePRNDL:vehicleDataResult,
                                                                   SDLRPCParameterNameTirePressure:vehicleDataResult,
                                                                   SDLRPCParameterNameOdometer:vehicleDataResult,
                                                                   SDLRPCParameterNameBeltStatus:vehicleDataResult,
                                                                   SDLRPCParameterNameBodyInformation:vehicleDataResult,
                                                                   SDLRPCParameterNameDeviceStatus:vehicleDataResult,
                                                                   SDLRPCParameterNameDriverBraking:vehicleDataResult,
                                                                   SDLRPCParameterNameWiperStatus:vehicleDataResult,
                                                                   SDLRPCParameterNameHeadLampStatus:vehicleDataResult,
                                                                   SDLRPCParameterNameEngineOilLife:vehicleDataResult,
                                                                   SDLRPCParameterNameEngineTorque:vehicleDataResult,
                                                                   SDLRPCParameterNameAccelerationPedalPosition:vehicleDataResult,
                                                                   SDLRPCParameterNameSteeringWheelAngle:vehicleDataResult,
                                                                   SDLRPCParameterNameECallInfo:vehicleDataResult,
                                                                   SDLRPCParameterNameAirbagStatus:vehicleDataResult,
                                                                   SDLRPCParameterNameEmergencyEvent:vehicleDataResult,
                                                                   SDLRPCParameterNameClusterModes:vehicleDataResult,
                                                                   SDLRPCParameterNameMyKey:vehicleDataResult,
                                                                   SDLRPCParameterNameElectronicParkBrakeStatus:vehicleDataResult,
                                                                   SDLRPCParameterNameTurnSignal:vehicleDataResult,
                                                                   SDLRPCParameterNameCloudAppVehicleID:vehicleDataResult
                                                                   },
                                                             SDLRPCParameterNameOperationName:SDLRPCFunctionNameUnsubscribeVehicleData}} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLUnsubscribeVehicleDataResponse* testResponse = [[SDLUnsubscribeVehicleDataResponse alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testResponse.gps).to(equal(vehicleDataResult));
        expect(testResponse.speed).to(equal(vehicleDataResult));
        expect(testResponse.rpm).to(equal(vehicleDataResult));
        expect(testResponse.fuelLevel).to(equal(vehicleDataResult));
        expect(testResponse.fuelLevel_State).to(equal(vehicleDataResult));
        expect(testResponse.fuelRange).to(equal(vehicleDataResult));
        expect(testResponse.instantFuelConsumption).to(equal(vehicleDataResult));
        expect(testResponse.externalTemperature).to(equal(vehicleDataResult));
        expect(testResponse.prndl).to(equal(vehicleDataResult));
        expect(testResponse.tirePressure).to(equal(vehicleDataResult));
        expect(testResponse.odometer).to(equal(vehicleDataResult));
        expect(testResponse.beltStatus).to(equal(vehicleDataResult));
        expect(testResponse.bodyInformation).to(equal(vehicleDataResult));
        expect(testResponse.deviceStatus).to(equal(vehicleDataResult));
        expect(testResponse.driverBraking).to(equal(vehicleDataResult));
        expect(testResponse.wiperStatus).to(equal(vehicleDataResult));
        expect(testResponse.headLampStatus).to(equal(vehicleDataResult));
        expect(testResponse.engineOilLife).to(equal(vehicleDataResult));
        expect(testResponse.engineTorque).to(equal(vehicleDataResult));
        expect(testResponse.accPedalPosition).to(equal(vehicleDataResult));
        expect(testResponse.steeringWheelAngle).to(equal(vehicleDataResult));
        expect(testResponse.eCallInfo).to(equal(vehicleDataResult));
        expect(testResponse.airbagStatus).to(equal(vehicleDataResult));
        expect(testResponse.emergencyEvent).to(equal(vehicleDataResult));
        expect(testResponse.clusterModes).to(equal(vehicleDataResult));
        expect(testResponse.myKey).to(equal(vehicleDataResult));
        expect(testResponse.electronicParkBrakeStatus).to(equal(vehicleDataResult));
        expect(testResponse.turnSignal).to(equal(vehicleDataResult));
        expect(testResponse.cloudAppVehicleID).to(equal(vehicleDataResult));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLUnsubscribeVehicleDataResponse* testResponse = [[SDLUnsubscribeVehicleDataResponse alloc] init];
        
        expect(testResponse.gps).to(beNil());
        expect(testResponse.speed).to(beNil());
        expect(testResponse.rpm).to(beNil());
        expect(testResponse.fuelLevel).to(beNil());
        expect(testResponse.fuelLevel_State).to(beNil());
        expect(testResponse.fuelRange).to(beNil());
        expect(testResponse.instantFuelConsumption).to(beNil());
        expect(testResponse.externalTemperature).to(beNil());
        expect(testResponse.prndl).to(beNil());
        expect(testResponse.tirePressure).to(beNil());
        expect(testResponse.odometer).to(beNil());
        expect(testResponse.beltStatus).to(beNil());
        expect(testResponse.bodyInformation).to(beNil());
        expect(testResponse.deviceStatus).to(beNil());
        expect(testResponse.driverBraking).to(beNil());
        expect(testResponse.wiperStatus).to(beNil());
        expect(testResponse.headLampStatus).to(beNil());
        expect(testResponse.engineOilLife).to(beNil());
        expect(testResponse.engineTorque).to(beNil());
        expect(testResponse.accPedalPosition).to(beNil());
        expect(testResponse.steeringWheelAngle).to(beNil());
        expect(testResponse.eCallInfo).to(beNil());
        expect(testResponse.airbagStatus).to(beNil());
        expect(testResponse.emergencyEvent).to(beNil());
        expect(testResponse.clusterModes).to(beNil());
        expect(testResponse.myKey).to(beNil());
        expect(testResponse.electronicParkBrakeStatus).to(beNil());
        expect(testResponse.turnSignal).to(beNil());
        expect(testResponse.cloudAppVehicleID).to(beNil());
    });

    it(@"Should set and get Generic Network Signal Data", ^{
        SDLUnsubscribeVehicleDataResponse *testRequest = [[SDLUnsubscribeVehicleDataResponse alloc] init];

        [testRequest setOEMCustomVehicleData:@"customOEMVehicleData" withVehicleDataState:customOEMvehicleDataResult];

        expect([testRequest getOEMCustomVehicleData:@"customOEMVehicleData"]).to(equal(customOEMvehicleDataResult));
    });
});

QuickSpecEnd
