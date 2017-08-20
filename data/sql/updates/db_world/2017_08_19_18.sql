-- DB update 2017_08_19_17 -> 2017_08_19_18
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_08_19_17';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_08_19_17 2017_08_19_18 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1503138789369120900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1503138789369120900');

-- Scarlet Infantryman
UPDATE creature_equip_template SET ItemID1= 38721, ItemID2= 12932 WHERE CreatureID= 28609;
UPDATE creature_equip_template SET ItemID1= 38723, ItemID2= 12932 WHERE CreatureID= 28896;
--
-- END UPDATING QUERIES
--
COMMIT;
END;
//
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
