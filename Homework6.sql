/*
Create new procedure called CreateGrade 
Procedure should create only Grade header info (not Grade Details) 
Procedure should return the total number of grades in the system for the Student on input (from the CreateGrade)
Procedure should return second resultset with the MAX Grade of all grades for the Student and Teacher on input (regardless the Course)
*/
CREATE PROCEDURE [dbo].[CreateGrade]
(
	@StudentID INT,
	@CourseID INT,
	@TeacherID INT,
	@Grade TINYINT,
	@Comment NVARCHAR(100)
)
AS
BEGIN
	INSERT INTO [dbo].[Grade] ([StudentID], [CourseID], [TeacherID], [Grade], [Comment], [CreatedDate])
	VALUES (@StudentID, @CourseID, @TeacherID, @Grade, @Comment, GETDATE())

	SELECT COUNT(*) AS GradeCountsForStudent
	FROM [dbo].[Grade]
	WHERE [StudentID] = @StudentID

	SELECT MAX([Grade]) AS MaxGradeForStudent
	FROM [dbo].[Grade]
	WHERE [StudentID] = @StudentID AND [TeacherID] = @TeacherID
END
GO

EXEC [dbo].[CreateGrade] 
	@StudentID = 1
,	@CourseID = 1
,	@TeacherID = 1
,	@Grade = 10
,	@Comment = 'Dobar'
GO

SELECT TOP 10 * 
FROM [dbo].[Grade]
ORDER BY [ID] DESC
GO


/*
Create new procedure called CreateGradeDetail
Procedure should add details for specific Grade (new record for new AchievementTypeID, Points, MaxPoints, Date for specific Grade)
Output from this procedure should be resultset with SUM of GradePoints calculated with formula
AchievementPoints/AchievementMaxPoints*ParticipationRate for specific Grade
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
	INSERT INTO [dbo].[GradeDetails] ([GradeID], [AchievementTypeID], [AchievementPoints], [AchievementMaxPoints], [AchievementDate])
	VALUES (@GradeID, @AchievementTypeID, @AchievementPoints, @AchievementMaxPoints, GETDATE())

	SELECT SUM (CAST (gd.[AchievementPoints] AS DECIMAL(5,2)) / CAST (gd.[AchievementMaxPoints] AS DECIMAL(5,2) ) * act.[ParticipationRate])
	FROM [dbo].[GradeDetails] gd
	INNER JOIN [dbo].[AchievementType] act ON gd.[AchievementTypeID] = act.[ID]
	WHERE gd.[GradeID] = @GradeID
END
GO

EXEC [dbo].[CreateGradeDetail]
	@GradeId = 16037,
	@AchievementTypeID = 5,
	@AchievementPoints = 93,
	@AchievementMaxPoints = 100
GO

SELECT TOP 10 * 
FROM [dbo].[GradeDetails]
ORDER BY [ID] DESC
GO