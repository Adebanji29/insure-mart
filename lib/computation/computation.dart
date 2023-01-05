import 'package:flutter/material.dart';

import '../Backend models/insurance_model.dart';

class Computation {
  InsuranceModel model;

  Computation({required this.model});

  double vlicence=0;
  double roadworth= 0;
  double hpermit=0;
  double atp=0;
  String? insuranceClass="";
  double thirdparty=0;

  void getClassOfInsurane(){
    if(model.carmake=='Ashok' && model.carmodel== 'Leyland'){
      insuranceClass= "Commercial";
    }
    else if(model.carmake=='Chevrolet' && model.carmodel== 'Express Cargo'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Chevrolet' && model.carmodel== 'N300'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Dodge' && model.carmodel== 'Ram'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Dodge' && model.carmodel== 'Ram Promaster'){
      insuranceClass= "Commercial";
    }
    else if(model.carmake=='Dodge' && model.carmodel== 'Sprinter'){
      insuranceClass= "Commercial";
    }
    else if(model.carmake=='Fiat' && model.carmodel== 'Ducato'){
      insuranceClass= "Commercial";
    }
    else if(model.carmake=='Fiat' && model.carmodel=='FULLBACK' ){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Ford' && model.carmodel=='E-350' ){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Ford' && model.carmodel=='E-Series'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Ford' && model.carmodel=='Econoline' ){
      insuranceClass= "Commercial";
    }
    else if(model.carmake=='Ford' && model.carmodel=='F-150'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Ford' && model.carmodel=='Ranger'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Ford' && model.carmodel=='Transit'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Foton'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='GMC' && model.carmodel=='SAVANA'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Honda' && model.carmodel=='Ridgeline'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Hyundai' && model.carmodel== 'County'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Hyundai' && model.carmodel=='HD 45'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Isuzu' && model.carmodel=='NQR'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='JMC'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Kia' && model.carmodel=='K3000'){
      insuranceClass= "Commercial";
    }


    else if(model.carmake=='Mercedes Benz' && model.carmodel== 'Vito'){
      insuranceClass= "Commercial";
    }


    else if(model.carmake=='Mercedes Benz' && model.carmodel=='Trucck'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Mitsubishi' && model.carmodel== 'BUS'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Mitsubishi' && model.carmodel== 'L200'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Mitsubishi' && model.carmodel== 'L300'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Mitsubishi' && model.carmodel== 'L400'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Nissan' && model.carmodel==  'Frontier'){
      insuranceClass= "Commercial";
    }
    else if(model.carmake=='Nissan' && model.carmodel== 'Titan'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Nissan' && model.carmodel== 'Vanette' ){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Peugeot' && model.carmodel=='Boxer'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Peugeot' && model.carmodel=='Expert'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Stallion'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Toyota' && model.carmodel== 'Celica'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Toyota' && model.carmodel== 'HiAce'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Toyota' && model.carmodel=='Hilux'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Toyota' && model.carmodel=='Tacoma'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Toyota' && model.carmodel=='Tundra'){
      insuranceClass= "Commercial";
    }

    else if(model.carmake=='Volkswagen' && model.carmodel=='Amarok'){
      insuranceClass= "Commercial";
    }
    else{
      insuranceClass= "Private";
    }

  }

  String get getInsClass{
    return insuranceClass.toString();
  }


  // void getThirdPartyInsuranceCost(){
  //   if(insuranceClass== "Commercial"){
  //     thirdparty= 25000;
  //   }
  //   else{
  //     thirdparty= 15000;
  //   }
  // }
  //
  // double get get3rdParty{
  //   return thirdparty;
  // }

  void getVehicleLicence(){
    // if(model.vehicletrackinglicence.toString().isNotEmpty){
      if(model.step3Extensions.contains("Renew Vehicle License")){
      if (model.carmake=='Acura' && model.carmodel== 'Mdx'){
        vlicence= 4000;
      }
      else if (model.carmake=='Acura' && model.carmodel== 'Rdx'){
        vlicence= 4000;
      }
      else if (model.carmake=='Acura' && model.carmodel== 'Tsx'){
        vlicence= 4000;
      }
      else if (model.carmake=='Acura' && model.carmodel== 'Zdx'){
        vlicence= 4000;
      }
      else if (model.carmake=='Ashok' && model.carmodel== 'Leyland'){
        vlicence= 4000;
      }
      else if (model.carmake=='Audi' && model.carmodel== 'Q7'){
        vlicence= 4000;
      }
      else if (model.carmake=='BMW' && model.carmodel== 'X3'){
        vlicence= 4000;
      }
      else if (model.carmake=='BMW' && model.carmodel== 'X5'){
        vlicence= 4000;
      }
      else if (model.carmake=='BMW' && model.carmodel== 'X6'){
        vlicence= 4000;
      }
      else if (model.carmake=='Buick' && model.carmodel== 'Enclave'){
        vlicence= 4000;
      }
      else if (model.carmake=='Cadillac' && model.carmodel== 'Escalade'){
        vlicence= 4000;
      }
      else if (model.carmake=='Cadillac' && model.carmodel== 'Srx'){
        vlicence= 4000;
      }
      else if(model.carmake=='Chevrolet' && model.carmodel== 'Avalanche'){
        vlicence= 4000;
      }
      else if(model.carmake=='Chevrolet' && model.carmodel== 'Aveo'){
        vlicence= 2700;
      }
      else if(model.carmake=='Chevrolet' && model.carmodel== 'Equinox'){
        vlicence= 4000;
      }
      else if(model.carmake=='Chevrolet' && model.carmodel== 'Express Cargo'){
        vlicence= 4000;
      }
      else if(model.carmake=='Chevrolet' && model.carmodel== 'N300'){
        vlicence= 4000;
      }
      else if(model.carmake=='Chevrolet' && model.carmodel== 'TRACKER'){
        vlicence= 4000;
      }
      else if(model.carmake=='Chevrolet' && model.carmodel== 'Trailblazer'){
        vlicence= 4000;
      }
      else if(model.carmake=='Chevrolet' && model.carmodel== 'Traverse'){
        vlicence= 4000;
      }
      else if(model.carmake=='Chevrolet' && model.carmodel== 'Uplander'){
        vlicence= 4000;
      }
      else if(model.carmake=='Chrysler' && model.carmodel== '300'){
        vlicence= 4000;
      }
      else if(model.carmake=='Chrysler' && model.carmodel== 'Pacifica'){
        vlicence= 4000;
      }
      else if(model.carmake=='Chrysler' && model.carmodel== 'Town & Country'){
        vlicence= 4000;
      }
      else if(model.carmake=='Citroen' && model.carmodel== 'BERLINGO'){
        vlicence= 4000;
      }
      else if(model.carmake=='Dodge' && model.carmodel== 'Caliber'){
        vlicence= 4000;
      }
      else if(model.carmake=='Citroen' && model.carmodel== 'Caravan'){
        vlicence= 4000;
      }
      else if(model.carmake=='Citroen' && model.carmodel== 'Durango'){
        vlicence= 4000;
      }
      else if(model.carmake=='Citroen' && model.carmodel== 'Journey'){
        vlicence= 4000;
      }
      else if(model.carmake=='Citroen' && model.carmodel== 'Magnum'){
        vlicence= 4000;
      }
      else if(model.carmake=='Citroen' && model.carmodel== 'minivan'){
        vlicence= 4000;
      }
      else if(model.carmake=='Citroen' && model.carmodel== 'Ram'){
        vlicence= 4000;
      }
      else if(model.carmake=='Citroen' && model.carmodel== 'Ram Promaster'){
        vlicence= 4000;
      }
      else if(model.carmake=='Citroen' && model.carmodel== 'Sprinter'){
        vlicence= 4000;
      }
      else if(model.carmake=='Citroen' && model.carmodel== 'Sprinter'){
        vlicence= 4000;
      }
      else if(model.carmake=='Fiat' && model.carmodel== 'FULLBACK'){
        vlicence= 4000;
      }
      else if(model.carmake=='Fiat' && model.carmodel== 'TIPO'){
        vlicence= 2700;
      }
      else if(model.carmake=='Ford' && model.carmodel== 'E-350'){
        vlicence= 4000;
      }
      else if(model.carmake=='Ford' && model.carmodel=='E-Series'){
        vlicence= 4000;
      }
      else if(model.carmake=='Ford' && model.carmodel== 'Econoline'){
        vlicence= 4000;
      }
      else if(model.carmake=='Ford' && model.carmodel== 'Ecosport'){
        vlicence= 4000;
      }
      else if(model.carmake=='Ford' && model.carmodel==  'Edge'){
        vlicence= 4000;
      }
      else if(model.carmake=='Ford' && model.carmodel== 'Escape'){
        vlicence= 4000;
      }
      else if(model.carmake=='Ford' && model.carmodel== 'Everest'){
        vlicence= 4000;
      }
      else if(model.carmake=='Ford' && model.carmodel== 'Expedition'){
        vlicence= 4000;
      }
      else if(model.carmake=='Ford' && model.carmodel==  'Explorer'){
        vlicence= 4000;
      }
      else if(model.carmake=='Ford' && model.carmodel== 'Explorer Ford Sport Trac'){
        vlicence= 4000;
      }
      else if(model.carmake=='Ford' && model.carmodel==  'F-150'){
        vlicence= 4000;
      }
      else if(model.carmake=='Ford' && model.carmodel==  'Flex'){
        vlicence= 4000;
      }
      else if(model.carmake=='Ford' && model.carmodel== 'Focus'){
        vlicence= 2700;
      }
      else if(model.carmake=='Ford' && model.carmodel==  'Freestyle'){
        vlicence= 4000;
      }
      else if(model.carmake=='Ford' && model.carmodel==   'Galaxy'){
        vlicence= 4000;
      }
      else if(model.carmake=='Ford' && model.carmodel==   'Ranger'){
        vlicence= 4000;
      }
      else if(model.carmake=='Ford' && model.carmodel==   'SMax'){
        vlicence= 4000;
      }
      else if(model.carmake=='Ford' && model.carmodel==   'Transit'){
        vlicence= 4000;
      }
      else if(model.carmake=='Ford' && model.carmodel==   'Windstar'){
        vlicence= 4000;
      }
      else if(model.carmake=='Foton' && model.carmodel==   'VIEW CS2'){
        vlicence= 4000;
      }
      else if(model.carmake=='GAC' && model.carmodel==   'GS4'){
        vlicence= 4000;
      }
      else if(model.carmake=='GAC' && model.carmodel==   'GS5'){
        vlicence= 4000;
      }
      else if(model.carmake=='GMC' ){
        vlicence= 4000;
      }
      else if(model.carmake=='Honda' && model.carmodel==  'Accord Crosstour' ){
        vlicence= 4000;
      }
      else if(model.carmake=='Honda' && model.carmodel==  'City' ){
        vlicence= 2700;
      }
      else if(model.carmake=='Honda' && model.carmodel=='Civic' ){
        vlicence= 2700;
      }
      else if(model.carmake=='Honda' && model.carmodel=='Cr-V' ){
        vlicence= 4000;
      }
      else if(model.carmake=='Honda' && model.carmodel== 'CR-V' ){
        vlicence= 4000;
      }
      else if(model.carmake=='Honda' && model.carmodel== 'Crv'){
        vlicence= 4000;
      }
      else if(model.carmake=='Honda' && model.carmodel=='Hr-V' ){
        vlicence= 4000;
      }
      else if(model.carmake=='Honda' && model.carmodel==  'Odyssey' ){
        vlicence= 4000;
      }
      else if(model.carmake=='Honda' && model.carmodel=='Passport' ){
        vlicence= 4000;
      }
      else if(model.carmake=='Honda' && model.carmodel=='Pilot'){
        vlicence= 4000;
      }
      else if(model.carmake=='Honda' && model.carmodel== 'Ridgeline' ){
        vlicence= 4000;
      }
      else if(model.carmake=='Honda' && model.carmodel=='Shuttle' ){
        vlicence= 4000;
      }

      else if(model.carmake=='Honda' && model.carmodel=='Stream' ){
        vlicence= 4000;
      }

      else if(model.carmake=='Hummer'){
        vlicence= 4000;
      }
      else if(model.carmake=='Hummer'){
        vlicence= 4000;
      }

      else if(model.carmake=='Hyundai' && model.carmodel=='Accent' ){
        vlicence= 2700;
      }

      else if(model.carmake=='Hyundai' && model.carmodel=='County' ){
        vlicence= 4500;
      }

      else if(model.carmake=='Hyundai' && model.carmodel=='Creta' ){
        vlicence= 4000;
      }

      else if(model.carmake=='Hyundai' && model.carmodel=='Entourage' ){
        vlicence= 4000;
      }

      else if(model.carmake=='Hyundai' && model.carmodel=='GRAND i10 XCENT' ){
        vlicence= 2700;
      }

      else if(model.carmake=='Hyundai' && model.carmodel== 'i10' ){
        vlicence= 2700;
      }

      else if(model.carmake=='Hyundai' && model.carmodel== 'Ix35' ){
        vlicence= 4000;
      }

      else if(model.carmake=='Hyundai' && model.carmodel== 'Santa Fe' ){
        vlicence= 4000;
      }

      else if(model.carmake=='Hyundai' && model.carmodel== 'Santamo' ){
        vlicence= 4000;
      }
      else if(model.carmake=='Hyundai' && model.carmodel== 'Trajet' ){
        vlicence= 4000;
      }

      else if(model.carmake=='Hyundai' && model.carmodel== 'Tucson' ){
        vlicence= 4000;
      }

      else if(model.carmake=='Hyundai' && model.carmodel== 'Veracruz' ){
        vlicence= 4000;
      }
      else if(model.carmake=='Infiniti' && model.carmodel== 'Fx' ){
        vlicence= 4000;
      }

      else if(model.carmake=='Infiniti' && model.carmodel== 'Fx 35' ){
        vlicence= 4000;
      }
      else if(model.carmake=='Infiniti' && model.carmodel=='Fx 37'){
        vlicence= 4000;
      }
      else if(model.carmake=='Infiniti' && model.carmodel=='Fx 45' ){
        vlicence= 4000;
      }
      else if(model.carmake=='Infiniti' && model.carmodel=='Fx 50'){
        vlicence= 4000;
      }
      else if(model.carmake=='Infiniti' && model.carmodel== 'Qx'){
        vlicence= 4000;
      }
      else if(model.carmake=='Infiniti' && model.carmodel=='QX4' ){
        vlicence= 4000;
      }
      else if(model.carmake=='Infiniti' && model.carmodel== 'QX56' ){
        vlicence= 4000;
      }

      else if(model.carmake=='Innoson' ){
        vlicence= 4000;
      }

      else if(model.carmake=='Isuzu' ){
        vlicence= 4000;
      }

      else if(model.carmake=='Jeep' ){
        vlicence= 4000;
      }

      else if(model.carmake=='JMC' ){
        vlicence= 4000;
      }

      else if(model.carmake=='Kia' && model.carmodel== 'Carens'){
        vlicence= 4000;
      }

      else if(model.carmake=='Kia' && model.carmodel== 'Carniva' ){
        vlicence= 4000;
      }

      else if(model.carmake=='Kia' && model.carmodel== 'Joice' ){
        vlicence= 4000;
      }

      else if(model.carmake=='Kia' && model.carmodel== 'K3000'){
        vlicence= 4000;
      }

      else if(model.carmake=='Kia' && model.carmodel=='Mohave' ){
        vlicence= 4000;
      }

      else if(model.carmake=='Kia' && model.carmodel== 'Picanto'){
        vlicence= 4000;
      }

      else if(model.carmake=='Kia' && model.carmodel== 'Rio' ){
        vlicence= 4000;
      }
      else if(model.carmake=='Kia' && model.carmodel=='Sedona'){
        vlicence= 4000;
      }
      else if(model.carmake=='Kia' && model.carmodel=='Sedona'){
        vlicence= 4000;
      }

      else if(model.carmake=='Kia' && model.carmodel=='Sportage'){
        vlicence= 4000;
      }

      else if(model.carmake=='Land Rover' ){
        vlicence= 4000;
      }

      else if(model.carmake== 'Lexus' && model.carmodel=='Es 350'){
        vlicence= 4000;
      }

      else if(model.carmake== 'Lexus' && model.carmodel=='GX 460'){
        vlicence= 4000;
      }

      else if(model.carmake== 'Lexus' && model.carmodel=='GX 470'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Lexus' && model.carmodel=='Lx'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Lexus' && model.carmodel=='Lx 470'){
        vlicence= 4000;
      }

      else if(model.carmake== 'Lexus' && model.carmodel== 'Lx 570'){
        vlicence= 4000;
      }

      else if(model.carmake== 'Lexus' && model.carmodel== 'NX'){
        vlicence= 4000;
      }

      else if(model.carmake== 'Lexus' && model.carmodel== 'Rx'){
        vlicence= 4000;
      }

      else if(model.carmake== 'Lexus' && model.carmodel== 'RX 300'){
        vlicence= 4000;
      }

      else if(model.carmake== 'Lexus' && model.carmodel=='RX 330'){
        vlicence= 4000;
      }

      else if(model.carmake== 'Lexus' && model.carmodel=='Rx 400h'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Lincoln' && model.carmodel=='Navigator'){
        vlicence= 4000;
      }

      else if(model.carmake== 'Mazda' && model.carmodel=='323'){
        vlicence= 4000;
      }

      else if(model.carmake== 'Mazda' && model.carmodel=='5'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mazda' && model.carmodel== 'Cx-7'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mazda' && model.carmodel=='Cx-9'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mazda' && model.carmodel=='Mazda5'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mazda' && model.carmodel=='Mpv'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mazda' && model.carmodel== 'Premacy'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mazda' && model.carmodel== 'PRIMACY'){
        vlicence= 4000;
      }

      else if(model.carmake== 'Mazda' && model.carmodel== 'Tribute'){
        vlicence= 4000;
      }

      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'ML 350'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel=='GL 450' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel=='GL 500' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'A140'){
        vlicence= 2700;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel==  'A160'){
        vlicence= 2700;
      }  else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'A170'){
        vlicence= 2700;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel=='B150' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel=='B180' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'Cls55 Amg'){
        vlicence= 4000;
      }  else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'Cls550' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel=='E500' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel==  'E550'){
        vlicence= 4000;
      }  else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'G class' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'G 320' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'G500'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel==  'G550'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'G63'){
        vlicence= 4000;
      }  else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'Gl-cLASS'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'GI350'){
        vlicence= 4000;
      }  else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'GI420'){
        vlicence= 4000;
      }

      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'GI450' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'GI500'){
        vlicence= 4000;
      }  else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'GI550'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel=='GLA250' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'GLC 300' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'GLC43'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'GLE350' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'GLE450' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel=='GLK350' ){
        vlicence= 4000;
      }

      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'GLK250'){
        vlicence= 4000;
      }

      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'M-CLASS' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'MI320'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel=='MI350' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel=='MI500' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel==  'MI550'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'MI63 Amg' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'R350' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'R500' ){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel=='R500 Brabus' ){
        vlicence= 4000;
      }

      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'S500'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mercedes Benz'&& model.carmodel=='S550' ){
        vlicence= 4000;
      }

      else if(model.carmake== 'Mercedes Benz'&& model.carmodel=='S600' ){
        vlicence= 4000;
      }

      else if(model.carmake== 'Mercedes Benz'&& model.carmodel=='Slk230' ){
        vlicence= 4000;
      }

      else if(model.carmake== 'Mercedes Benz'&& model.carmodel=='Slk350' ){
        vlicence= 4000;
      }

      else if(model.carmake== 'Mercedes Benz'&& model.carmodel=='VIANO' ){
        vlicence= 4000;
      }

      else if(model.carmake== 'Mercedes Benz'&& model.carmodel== 'Vito' ){
        vlicence= 4000;
      }

      else if(model.carmake== 'Mercury'&& model.carmodel=='Villager' ){
        vlicence= 4000;
      }

      else if(model.carmake== 'Mini'&& model.carmodel=='Cooper'){
        vlicence= 2700;
      }

      else if(model.carmake== 'Mitsubishi'&& model.carmodel=='Endeavor'){
        vlicence= 4000;
      }

      else if(model.carmake== 'Mitsubishi'&& model.carmodel== 'Galant'){
        vlicence= 2700;
      }
      else if(model.carmake== 'Mitsubishi'&& model.carmodel=='L200'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mitsubishi'&& model.carmodel=='Lancer'){
        vlicence= 4000;
      }

      else if(model.carmake== 'Mitsubishi'&& model.carmodel=='Montero'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mitsubishi'&& model.carmodel=='Outlander'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mitsubishi'&& model.carmodel=='Pajero'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mitsubishi'&& model.carmodel== 'Space gear'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Mitsubishi'&& model.carmodel=='SpaceStar'){
        vlicence= 4000;
      }

      else if(model.carmake== 'Nissan' && model.carmodel=='370z'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Nissan' && model.carmodel=='Almera'){
        vlicence= 2700;
      }
      else if(model.carmake== 'Nissan' && model.carmodel=='Armada'){
        vlicence= 4000;
      }
      else if(model.carmake== 'Nissan' && model.carmodel=='Cefiro'){
        vlicence= 2700;
      }
      else if(model.carmake== 'Nissan' && model.carmodel=='Civilian'){
        vlicence= 4500;
      }
      else if(model.carmake== 'Nissan' && model.carmodel=='Frontier'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Nissan' && model.carmodel=='INFINITY'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Nissan' && model.carmodel=='Juke'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Nissan' && model.carmodel=='Kicks'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Nissan' && model.carmodel=='Murano'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Nissan' && model.carmodel== 'Pathfinder'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Nissan' && model.carmodel== 'Patrol'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Nissan' && model.carmodel=='Primera'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Nissan' && model.carmodel=='Pulsar'){
      vlicence= 2700;
    }  else if(model.carmake== 'Nissan' && model.carmodel=='Qashqai'){
      vlicence= 4000;
    }  else if(model.carmake== 'Nissan' && model.carmodel=='Quest'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Nissan' && model.carmodel=='Rogue'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Nissan' && model.carmodel=='Serena'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Nissan' && model.carmodel=='Sunny'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Nissan' && model.carmodel=='Tiida'){
      vlicence= 2700;
    }

    else if(model.carmake== 'Nissan' && model.carmodel=='Titan'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Nissan' && model.carmodel== 'Versa'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Nissan' && model.carmodel=='X-Trail'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Nissan' && model.carmodel=='Xterra'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Opel' && model.carmodel== 'Astra'){
      vlicence= 2700;
    }

    else if(model.carmake== 'Opel' && model.carmodel=='Frontera'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Opel' && model.carmodel=='Signum'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Opel' && model.carmodel=='Vectra'){
      vlicence= 2700;
    }

    else if(model.carmake== 'Opel' && model.carmodel=='Zafira'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Peugeot' && model.carmodel== '206'){
      vlicence= 2700;
    }

    else if(model.carmake== 'Peugeot' && model.carmodel=='207'){
      vlicence= 2700;
    }

    else if(model.carmake== 'Peugeot' && model.carmodel=='301'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Peugeot' && model.carmodel== '307'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Peugeot' && model.carmodel=='308'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Peugeot' && model.carmodel=='406'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Peugeot' && model.carmodel=='807'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Pontiac' && model.carmodel=='Montana'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Pontiac' && model.carmodel=='Torent'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Porsche' ){
      vlicence= 4000;
    }

    else if(model.carmake== 'Range Rover' ){
      vlicence= 4000;
    }

    else if(model.carmake== 'Renault' && model.carmodel=='Duster'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Renault' && model.carmodel=='Espace'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Renault' && model.carmodel=='Laguna'){
      vlicence= 3300;
    }

    else if(model.carmake== 'Renault' && model.carmodel=='Megane'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Renault' && model.carmodel=='Scenic'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Rolls-Royce' ){
      vlicence= 4000;
    }

    else if(model.carmake== 'Rover' && model.carmodel=='LAND ROVER'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Saturn' && model.carmodel=='Outlook'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Saturn' && model.carmodel=='VUE'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Seat' ){
      vlicence= 2700;
    }

    else if(model.carmake== 'Skoda' && model.carmodel=='Fabia'){
      vlicence= 2700;
    }

    else if(model.carmake== 'Skoda' && model.carmodel=='Superb'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Ssangyong' ){
      vlicence= 4000;
    }

    else if(model.carmake== 'Stallion' ){
      vlicence= 4000;
    }

    else if(model.carmake== 'Subaru' && model.carmodel=='Forester'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Subaru' && model.carmodel=='Outback'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Suzuki' && model.carmodel=='Aerio'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Suzuki' && model.carmodel=='Alto'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Suzuki' && model.carmodel=='BALENO'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Suzuki' && model.carmodel=='CIAZ'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Suzuki' && model.carmodel=='Ertiga'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Suzuki' && model.carmodel== 'Esteem'){
      vlicence= 2700;
    }  else if(model.carmake== 'Suzuki' && model.carmodel=='Forenza'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Suzuki' && model.carmodel== 'Grand Viatra'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Suzuki' && model.carmodel=='Jimny'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Suzuki' && model.carmodel== 'Swift'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Suzuki' && model.carmodel=='Sx4'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Suzuki' && model.carmodel=='Vitara'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Suzuki' && model.carmodel=='XL-7'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Suzuki' && model.carmodel=='XL7'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Toyota' && model.carmodel=='4Runner'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Toyota' && model.carmodel== 'Avensis'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='Coaster'){
      vlicence= 4500;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='Corolla'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='Corolla Sport'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='COROLLA VERSO'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='Corona'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='Echo'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='Fj Cruiser'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='Fortuner'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='Harrier'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='HiAce'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='Highlander'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='Hilux'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='ipsum'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Toyota' && model.carmodel== 'KLUGER(HIGHLANDER)'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='Land Cruiser'){
      vlicence= 4000;
    }  else if(model.carmake== 'Toyota' && model.carmodel=='Land Cruiser Prado'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Toyota' && model.carmodel== 'Picnic'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='Rav4'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='Sequoia'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Toyota' && model.carmodel==  'Sienna'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='Tacoma'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='Tundra'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='Venza'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Toyota' && model.carmodel=='Verso'){
      vlicence= 2700;
    }
    else if(model.carmake== 'Toyota' && model.carmodel== 'Yaris'){
      vlicence= 2700;
    }

    else if(model.carmake== 'Volkswagen' && model.carmodel== 'Amarok'){
      vlicence= 4000;
    }
    else if(model.carmake== 'Volkswagen' && model.carmodel== 'Beatle'){
      vlicence= 2700;
    }

    else if(model.carmake== 'Volkswagen' && model.carmodel=='Beetle' ){
      vlicence= 2700;
    }

    else if(model.carmake== 'Volkswagen' && model.carmodel=='Golf' ){
      vlicence= 2700;
    }

    else if(model.carmake== 'Volkswagen' && model.carmodel=='Jetta' ){
      vlicence= 2700;
    }

    else if(model.carmake== 'Volkswagen' && model.carmodel== 'Polo' ){
      vlicence= 2700;
    }

    else if(model.carmake== 'Volkswagen' && model.carmodel== 'Sharan'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Volkswagen' && model.carmodel=='Tiguaan' ){
      vlicence= 4000;
    }

    else if(model.carmake== 'Volkswagen' && model.carmodel=='Touareg' ){
      vlicence= 4000;
    }

    else if(model.carmake== 'Volkswagen' && model.carmodel== 'Touran'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Volvo' && model.carmodel== 'V60' ){
      vlicence= 4000;
    }

    else if(model.carmake== 'Volvo' && model.carmodel=='V70' ){
      vlicence= 4000;
    }

    else if(model.carmake== 'Volvo' && model.carmodel== 'X40'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Volvo' && model.carmodel== 'XC 60'){
      vlicence= 4000;
    }

    else if(model.carmake== 'Volvo' && model.carmodel=='XC 90' ){
      vlicence= 4000;
    }



    else{
        vlicence= 3300;
      }
    }
    else {
      vlicence=0;
    }
    print(vlicence);
  }

  double get getVlc{
    return vlicence;
}


  void getRoadWorthiness(){
    if(model.step3Extensions.toString().contains('rrw')){
      if (model.carmake=='Ashok' ){
        roadworth= 6400;
      }

      else if(model.carmake=='Chevrolet' && model.carmodel=='Aveo'){
        roadworth= 5400;
      }
      else if(model.carmake=='Chevrolet' && model.carmodel=='Express Cargo'){
        roadworth= 5900;
      }
      else if(model.carmake=='Chevrolet' && model.carmodel=='N300'){
        roadworth= 6400;
      }
      else if(model.carmake=='Dodge' && model.carmodel=='Ram Promaster'){
        roadworth= 6400;
      }
      else if(model.carmake=='Dodge' && model.carmodel=='Sprinter'){
        roadworth= 6400;
      }

      else if(model.carmake=='Fiat' && model.carmodel=='Ducato'){
        roadworth= 5900;
      }

      else if(model.carmake=='Fiat' && model.carmodel== 'TIPO'){
        roadworth= 5400;
      }

      else if(model.carmake=='Ford' && model.carmodel== 'E-350'){
        roadworth= 6400;
      }
      else if(model.carmake=='Ford' && model.carmodel=='E-Series' ){
        roadworth= 6400;
      }
      else if(model.carmake=='Ford' && model.carmodel=='Econoline' ){
        roadworth= 6400;
      }
      else if(model.carmake=='Ford' && model.carmodel== 'Transit'){
        roadworth= 6400;
      }

      else if(model.carmake=='Foton'){
        roadworth= 6400;
      }

      else if(model.carmake=='GMC' && model.carmodel== 'SAVANA' ){
        roadworth= 6400;
      }

      else if(model.carmake=='Honda' && model.carmodel==  'Shuttle' ){
        roadworth= 6400;
      }

      else if(model.carmake=='Hyundai' && model.carmodel== 'Accent'){
        roadworth= 5400;
      }

      else if(model.carmake=='Hyundai' && model.carmodel=='County' ){
        roadworth= 7000;
      }

      else if(model.carmake=='Hyundai' && model.carmodel=='GRAND i10 XCENT' ){
        roadworth= 5400;
      }
      else if(model.carmake=='Hyundai' && model.carmodel== 'i10' ){
        roadworth= 5400;
      }

      else if(model.carmake=='Isuzu' && model.carmodel==  'NQR' ){
        roadworth= 6400;
      }

      else if(model.carmake=='JMC'){
        roadworth= 6400;
      }

      else if(model.carmake=='Kia' && model.carmodel== 'Soul' ){
        roadworth= 5400;
      }

      else if(model.carmake=='Kia' && model.carmodel== 'Spectra' ){
        roadworth= 5400;
      }

      else if(model.carmake=='Kia' && model.carmodel=='VENGA' ){
        roadworth= 5400;
      }

      else if(model.carmake=='Mazda' && model.carmodel=='323' ){
        roadworth= 5400;
      }

      else if(model.carmake=='Mercedes Benz' && model.carmodel=='A140'){
        roadworth= 5400;
      }
      else if(model.carmake=='Mercedes Benz' && model.carmodel=='A160'){
        roadworth= 5400;
      }
      else if(model.carmake=='Mercedes Benz' && model.carmodel=='A170'){
        roadworth= 5400;
      }
      else if(model.carmake=='Mercedes Benz' && model.carmodel=='Vito'){
        roadworth= 5900;
      }

      else if(model.carmake=='Mini'){
        roadworth= 5400;
      }

      else if(model.carmake=='Mitsubishi' && model.carmodel=='BUS'){
        roadworth= 5900;
      }

      else if(model.carmake=='Mitsubishi' && model.carmodel=='Galant'){
        roadworth= 5400;
      }

      else if(model.carmake=='Mitsubishi' && model.carmodel=='L300'){
        roadworth= 5900;
      }

      else if(model.carmake=='Mitsubishi' && model.carmodel=='L400'){
        roadworth= 5900;
      }

      else if(model.carmake=='Nissan' && model.carmodel== 'Almera'){
        roadworth= 5400;
      }

      else if(model.carmake=='Nissan' && model.carmodel=='Cefiro'){
        roadworth= 5400;
      }

      else if(model.carmake== 'Civilian' && model.carmodel== 'Primera'){
        roadworth= 7000;
      }

      else if(model.carmake=='Nissan' && model.carmodel=='Pulsar'){
        roadworth= 5400;
      }

      else if(model.carmake=='Nissan' && model.carmodel=='Sunny'){
        roadworth= 5400;
      }

      else if(model.carmake=='Nissan' && model.carmodel=='Tiida'){
        roadworth= 5400;
      }

      else if(model.carmake=='Nissan' && model.carmodel=='Vanette'){
        roadworth= 5900;
      }

      else if(model.carmake=='Nissan' && model.carmodel=='Versa'){
        roadworth= 5400;
      }

      else if(model.carmake=='Opel' && model.carmodel== 'Astra'){
        roadworth= 5400;
      }
      else if(model.carmake=='Opel' && model.carmodel== 'Vectra'){
        roadworth= 5400;
      }

      else if(model.carmake=='Peugeot' && model.carmodel=='206' ){
        roadworth= 5400;
      }

      else if(model.carmake=='Peugeot' && model.carmodel== '207'){
        roadworth= 5400;
      }
      else if(model.carmake=='Peugeot' && model.carmodel== '301'){
        roadworth= 5400;
      }

      else if(model.carmake=='Peugeot' && model.carmodel== '307'){
        roadworth= 5400;
      }

      else if(model.carmake=='Peugeot' && model.carmodel==  '308'){
        roadworth= 5400;
      }

      else if(model.carmake=='Peugeot' && model.carmodel== '406'){
        roadworth= 5400;
      }

      else if(model.carmake=='Peugeot' && model.carmodel== 'Boxer'){
        roadworth= 5900;
      }

      else if(model.carmake=='Peugeot' && model.carmodel=='Expert' ) {
        roadworth = 5900;
      }

      else if(model.carmake=='Seat' ){
        roadworth= 5400;
      }


      else if(model.carmake=='Skoda' && model.carmodel=='Fabia'){
        roadworth= 5400;
      }

      else if(model.carmake=='Suzuki' && model.carmodel== 'Aerio'){
        roadworth= 5400;
      }

      else if(model.carmake=='Suzuki' && model.carmodel=='Alto'){
        roadworth= 5400;
      }

      else if(model.carmake=='Suzuki' && model.carmodel== 'CIAZ'){
        roadworth= 5400;
      }

      else if(model.carmake=='Suzuki' && model.carmodel=='Esteem'){
        roadworth= 5400;
      }

      else if(model.carmake=='Suzuki' && model.carmodel=='Forenza'){
        roadworth= 5400;
      }


      else if(model.carmake=='Suzuki' && model.carmodel=='Swift'){
        roadworth= 5400;
      }

      else if(model.carmake=='Toyota' && model.carmodel=='Avensis'){
        roadworth= 5400;
      }
      else if(model.carmake=='Toyota' && model.carmodel=='Coaster'){
        roadworth= 7000;
      }

      else if(model.carmake=='Toyota' && model.carmodel=='Corolla'){
        roadworth= 5400;
      }

      else if(model.carmake=='Toyota' && model.carmodel=='Corolla Sport'){
        roadworth= 5400;
      }

      else if(model.carmake=='Toyota' && model.carmodel=='COROLLA VERSO'){
        roadworth= 5400;
      }

      else if(model.carmake=='Toyota' && model.carmodel=='Corona'){
        roadworth= 5400;
      }

      else if(model.carmake=='Toyota' && model.carmodel== 'Echo'){
        roadworth= 5400;
      }

      else if(model.carmake=='Toyota' && model.carmodel=='HiAce'){
        roadworth= 6400;
      }

      else if(model.carmake=='Toyota' && model.carmodel=='Verso'){
        roadworth= 5400;
      }

      else if(model.carmake=='Toyota' && model.carmodel=='Yaris'){
        roadworth= 5400;
      }

      else if(model.carmake=='Volkswagen' && model.carmodel=='Beatle'){
        roadworth= 5400;
      }


      else if(model.carmake=='Volkswagen' && model.carmodel=='Beetle'){
        roadworth= 5400;
      }


      else if(model.carmake=='Volkswagen' && model.carmodel== 'Golf'){
        roadworth= 5400;
      }


      else if(model.carmake=='Volkswagen' && model.carmodel=='Jetta'){
        roadworth= 5400;
      }


      else if(model.carmake=='Volkswagen' && model.carmodel== 'Polo'){
        roadworth= 5400;
      }

      else{
      roadworth= 6100;
    }
  }
    else{
    roadworth=0;
    }
    print(roadworth);
  }

  double get getRRW{
    return roadworth;
  }



  void getHackneyPermit(){
    if(model.step3Extensions.toString().contains('rhp')){
      if (model.carmake=='Ashok' ){
        hpermit= 5500;
      }

      else if(model.carmake=='Chevrolet' && model.carmodel== 'N300'){
        hpermit= 5500;
      }

      else if(model.carmake=='Ford' && model.carmodel== 'E-350'){
        hpermit= 5500;
      }

      else if(model.carmake=='Ford' && model.carmodel=='E-Series' ){
        hpermit= 5500;
      }

      else if(model.carmake=='Ford' && model.carmodel=='Econoline' ){
        hpermit= 5500;
      }
      else if(model.carmake=='Foton' ){
        hpermit= 5500;
      }

      else if(model.carmake=='GMC' && model.carmodel=='SAVANA' ){
        hpermit= 5500;
      }

      else if(model.carmake=='Honda' && model.carmodel=='Shuttle' ){
        hpermit= 5500;
      }

      else if(model.carmake=='Hyundai' && model.carmodel=='County' ){
        hpermit= 6000;
      }

      else if(model.carmake=='Isuzu' && model.carmodel=='NQR' ){
        hpermit= 5500;
      }

      else if(model.carmake=='JMC'){
        hpermit= 5500;
      }

      else if(model.carmake=='Kia' && model.carmodel=='K3000' ){
        hpermit= 5500;
      }

      else if(model.carmake=='Nissan' && model.carmodel== 'Civilian' ){
        hpermit= 6000;
      }

      else if(model.carmake=='Toyota' && model.carmodel== 'Coaster' ){
        hpermit= 6000;
      }

      else if(model.carmake=='Toyota' && model.carmodel== 'HiAce' ){
        hpermit= 5500;
      }

      else{
        hpermit= 5000;
      }
    }
    else{
     hpermit=0;
    }
    print(hpermit);
  }

  double get getHP{
    return hpermit;
  }
// getAdditionalThirdParty(){
//     if (model.atp.toString().isNotEmpty){
//      atp = double.parse(model.atp.toString().replaceAll(RegExp('[^0-9.]'), ''));
//     }
//     else{
//       atp=0;
//     }
//     print(atp);
// }
//
//   double get getAtp{
//     return atp;
//   }
}