/*
Add error handling on CreateGradeDetailprocedure
Test the error handling by inserting not-existing values for AchievementTypeID
*/
CREATE OR ALTER PROCEDURE [dbo].[CreateGradeDetail]
(
	@GradeId INT,
	@AchievementTypeID TINYINT,
	@AchievementPoints TINYINT,
	@AchievementMaxPoints TINYINT
)
AS
BEGIN
	BEGIN TRY
		INSERT INTO [dbo].[GradeDetails] ([GradeID], [AchievementTypeID], [AchievementPoints], [AchievementMaxPoints], [AchievementDate])
		VALUES (@GradeID, @AchievementTypeID, @AchievementPoints, @AchievementMaxPoints, GETDATE())

		SELECT SUM (CAST (gd.[AchievementPoints] AS DECIMAL(5,2)) / CAST (gd.[AchievementMaxPoints] AS DECIMAL(5,2) ) * act.[ParticipationRate])
		FROM [dbo].[GradeDetails] gd
		INNER JOIN [dbo].[AchievementType] act ON gd.[AchievementTypeID] = act.[ID]
		WHERE gd.[GradeID] = @GradeID
	END TRY
	BEGIN CATCH
		SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage
	END CATCH
END
GO