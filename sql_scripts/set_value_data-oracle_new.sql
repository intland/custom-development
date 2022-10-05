create or replace PROCEDURE SET_BROKEN_REFRENCES ( list_of_existing_data IN varchar2 )
IS
   non_existing_data number;
   broken_reference_id number;
   latest_data number;
   cursor list_of_not_existing_data IS 
      SELECT object_id 
      FROM object_revision 
      WHERE object_id NOT IN (74852,74858,74864,74872,78028,78105,78118,78130,78133,78140,78143,78146,78149,78152,78160,78163,78166,78169,78172,78176,78179,78182,78190,78193,78196,78199,78216,78219,78222,78225,78228,78231,78234,78237,78240,78243,78246,78249,78252,78255,78258,78262,78265,78268,78271,78274,78279,78282,78285,78288,78291,78294,78297,78300,78303,78308,78311,78314,78318,78321,78336,78339,78353,78465,78570,78573,78576,78745,76101,76104,76238,76241,76267,76269,76379,76382,76516,76519,76653,76656,76697,76703,76709,76717,75984,75977,75980,75988,77705,77817,77820,77988,77991,79071,79079,79082,79087,79090,79326,83701,83704,83706,2263,2281,2031,2266,2285,2288,2298,2303,2037,2043,37212,37215,1012,10256,16904,16907,16947,18183,18191,18194,18197,18200,18203,18206,18209,18212,18215,18221,18236,18245,18248,18251,18431,18451,32359,33382,42904,54688,54691,54694,54697,54700,54703,54706,54709,54712,54715,54718,54721,54730,54737,54791,54794,54868,54871,54874,54885,54888,54891,54894,54901,54904,54907,54912,54917,54920,54923,54930,54933,54936,54945,54948,55104,55107,55110,55113,55116,55119,55122,55125,55128,55131,55134,55137,55140,55143,55146,55149,55015,55152,55155,55164,55167,55170,55173,55178,55018,55183,55186,55189,55198,55203,55208,55021,55213,55218,55223,55024,55027,55285,55030,55033,55084,55093,55096,55099,59052,6230,6233,6236,6239,6242,6245,6248,6251,6254,6257,6260,6263,6268,6273,6276,6279,6282,6285,6288,61787,64197,64220,64223,64233,64236,64239,64242,64245,64248,64251,64521,64526,64529,64532,69224) AND 
            type_id = 44;
			
	cursor list_broken_reference_id IS SELECT from_id FROM object_reference WHERE to_id = non_existing_data;
BEGIN
   OPEN list_of_not_existing_data;
   
	-- SELECT ('** START set_broken_refrences_to_last_valid_data') AS '** DEBUG:';
	LOOP
    FETCH list_of_not_existing_data INTO non_existing_data;
    EXIT WHEN list_of_not_existing_data%notfound;
    -- SELECT CONCAT('**Start loop ') AS '** DEBUG:';
    -- SELECT the id of the valid data reference. 
    BEGIN
		LOOP
		FETCH list_broken_reference_id INTO broken_reference_id;
		EXIT WHEN list_broken_reference_id%notfound;

		BEGIN
		  SELECT MAX(to_id) INTO latest_data 
		  FROM object_reference 
		  WHERE from_id IN (broken_reference_id) 
			AND to_id IN (74852,74858,74864,74872,78028,78105,78118,78130,78133,78140,78143,78146,78149,78152,78160,78163,78166,78169,78172,78176,78179,78182,78190,78193,78196,78199,78216,78219,78222,78225,78228,78231,78234,78237,78240,78243,78246,78249,78252,78255,78258,78262,78265,78268,78271,78274,78279,78282,78285,78288,78291,78294,78297,78300,78303,78308,78311,78314,78318,78321,78336,78339,78353,78465,78570,78573,78576,78745,76101,76104,76238,76241,76267,76269,76379,76382,76516,76519,76653,76656,76697,76703,76709,76717,75984,75977,75980,75988,77705,77817,77820,77988,77991,79071,79079,79082,79087,79090,79326,83701,83704,83706,2263,2281,2031,2266,2285,2288,2298,2303,2037,2043,37212,37215,1012,10256,16904,16907,16947,18183,18191,18194,18197,18200,18203,18206,18209,18212,18215,18221,18236,18245,18248,18251,18431,18451,32359,33382,42904,54688,54691,54694,54697,54700,54703,54706,54709,54712,54715,54718,54721,54730,54737,54791,54794,54868,54871,54874,54885,54888,54891,54894,54901,54904,54907,54912,54917,54920,54923,54930,54933,54936,54945,54948,55104,55107,55110,55113,55116,55119,55122,55125,55128,55131,55134,55137,55140,55143,55146,55149,55015,55152,55155,55164,55167,55170,55173,55178,55018,55183,55186,55189,55198,55203,55208,55021,55213,55218,55223,55024,55027,55285,55030,55033,55084,55093,55096,55099,59052,6230,6233,6236,6239,6242,6245,6248,6251,6254,6257,6260,6263,6268,6273,6276,6279,6282,6285,6288,61787,64197,64220,64223,64233,64236,64239,64242,64245,64248,64251,64521,64526,64529,64532,69224);
		  --SELECT CONCAT('** Get latest data ', @latest_data, ' Non existing Data id: ', non_existing_data) AS '** DEBUG:';
		  -- set all occurence of broken reference to the valid reference
		  IF latest_data is not null THEN
			UPDATE object_reference SET to_id = latest_data WHERE to_id = non_existing_data;
			DBMS_OUTPUT.PUT_LINE('Get latest data ' || latest_data || ' Non existing Data id: ' || non_existing_data);
		  END IF;
		EXCEPTION WHEN NO_DATA_FOUND THEN
		  DBMS_OUTPUT.PUT_LINE('No data found for non-existing-id: ''' || non_existing_data || '''');
		END;
		END LOOP;	
      
    EXCEPTION WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No data found for non-existing-id: ''' || non_existing_data || '''');
    END;
	END LOOP;
  CLOSE list_of_not_existing_data;

EXCEPTION
  WHEN OTHERS THEN
     raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END SET_BROKEN_REFRENCES;