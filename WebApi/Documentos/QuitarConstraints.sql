EXEC sp_MSforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all";
-- y al final de los inserts 
EXEC sp_MSforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"
