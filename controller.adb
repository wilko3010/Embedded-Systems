
--with Ada.Text_IO;
--use Ada.Text_IO;
--With Ada.Integer_Text_IO;
--use Ada.Integer_Text_IO;


with HWIF; with HWIF_Types;
use HWIF; use HWIF_Types;

procedure Controller is
   type Traffic_Light_State_Type  is (AllRed, NSRedAmber, NSGreen, NSAmber, NSRed, EWRed, EWRedAmber, EWGreen, EWAmber);

   TLState : Traffic_Light_State_Type;
   delayTime : Integer;

begin
   TLState := AllRed;

   loop

      case TLState is

         when AllRed =>
            Traffic_Light(North) := 4;
            Traffic_Light(South) := 4;
            Traffic_Light(East) := 4;
            Traffic_Light(West) := 4;
            delayTime := 1;
         when NSRedAmber =>
            Traffic_Light(North) := 6;
            Traffic_Light(South) := 6;
            delayTime  :=  1;
         when NSGreen =>
            Traffic_Light(North) :=1;
            Traffic_Light(South) :=1;
            delayTime  :=  5;
         when NSAmber =>
            Traffic_Light(North) :=2;
            Traffic_Light(South) :=2;
            delayTime  :=  3;
         when NSRed =>
            Traffic_Light(North) := 4;
            Traffic_Light(South) := 4;
            delayTime  :=  2;
         When EWRed =>
            Traffic_Light(East) := 4;
            Traffic_Light(West) := 4;
            delayTime  :=  2;
         when EWRedAmber =>
            Traffic_Light(East) := 6;
            Traffic_Light(West) := 6;
            delayTime  :=  1;
         when EWGreen =>
            Traffic_Light(East) :=1;
            Traffic_Light(West) :=1;
            delayTime  :=  5;
         when EWAmber =>
            Traffic_Light(East) :=2;
            Traffic_Light(West) :=2;
            delayTime := 3;

      end case;

      for I in Integer range 1 .. 10 *delayTime loop
        delay 0.1;

      if Pedestrian_Button(North) = 1 or Pedestrian_Button(South) =1 or Pedestrian_Button(East) = 1 or Pedestrian_Button(West) =1 or Pedestrian_Wait(North) = 1 or Pedestrian_Wait(East) = 1 then
         Pedestrian_Wait(North) := 1;
         Pedestrian_Wait(South) :=1;
		 Pedestrian_Wait(East) := 1;
         Pedestrian_Wait(West) :=1;
        -- Put("TLState");
         if TLState = AllRed or TLState = NSRed or TLState = EWRed then
            Pedestrian_Light(North) := 1;
            Pedestrian_Wait(North) := 0;
            Pedestrian_Light(South) := 1;
            Pedestrian_Wait(South) := 0;
		    Pedestrian_Light(East) := 1;
            Pedestrian_Wait(East) := 0;
            Pedestrian_Light(West) := 1;
            Pedestrian_Wait(West) := 0;
            delay 6.0;
            Pedestrian_Light(North) := 2;
            Pedestrian_Light(South) := 2;
		 	Pedestrian_Light(East) := 2;
            Pedestrian_Light(West) := 2;
            end if;
         end if;

       --  if Pedestrian_Button(East) = 1 or Pedestrian_Button(West) =1 or Pedestrian_Wait(East) = 1 then
        -- Pedestrian_Wait(East) := 1;
        -- Pedestrian_Wait(West) :=1;
        -- Put("TLState");
        -- if TLState = AllRed or TLState = NSRed or TLState = EWRed then
         --   Pedestrian_Light(East) := 1;
          --  Pedestrian_Wait(East) := 0;
          --  Pedestrian_Light(West) := 1;
          --  Pedestrian_Wait(West) := 0;
          --  delay 6.0;
          --  Pedestrian_Light(East) := 2;
          --  Pedestrian_Light(West) := 2;
          --  end if;
         --end if;

--           if Emergency_Vehicle_Sensor(North) = 1 then
--              TLState := Traffic_Light_State_Type'Succ(NSGreen);
--              delay 10.0;
--
--           end if;

      end loop;

      if TLState = EWAmber then
         TLState := AllRed;
      else
         TLState := Traffic_Light_State_Type'Succ(TLState);
      end if;

   end loop;

end Controller;
