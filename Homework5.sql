--- Create multi-statement table value function that for specific Teacher will list of students (FirstName, LastName) who passed the exam
--- with that Teacher and with Average grade per Student
DROP FUNCTION IF EXISTS dbo.fn_StudentGrades
GO

CREATE FUNCTION dbo.fn_StudentGrades (@TeacherId SMALLINT, @CourseId SMALLINT)
RETURNS @output TABLE (StudentFirstName NVARCHAR(50), StudentLastName NVARCHAR(50), Grade TINYINT, CreatedDate DATETIME)
AS
BEGIN
	INSERT INTO @output
	SELECT s.[FirstName] AS StudentFirstName, s.[LastName] AS StudentLastName, g.[Grade], g.[CreatedDate]
	FROM [dbo].[Grade] g
	INNER JOIN [dbo].[Student] s ON g.[StudentID] = s.[ID]
	WHERE [TeacherID] = @TeacherId AND [CourseID] = @CourseId
	RETURN
END
GO

DECLARE @TeacherId INT = 1
DECLARE @CourseId INT = 1

SELECT *
FROM dbo.fn_StudentGrades (@TeacherId, @CourseId)
ORDER BY StudentFirstName, StudentLastName, CreatedDate
GO


--- Create multi-statement table value function that for specific Teacher will list of students (FirstName, LastName) 
--- who passed the exam with that Teacher and with Average grade per Student 
DROP FUNCTION IF EXISTS dbo.fn_StudentAverageGrades
GO

CREATE FUNCTION dbo.fn_StudentAverageGrades (@TeacherId SMALLINT, @CourseId SMALLINT)
RETURNS @output TABLE (StudentFirstName NVARCHAR(50), StudentLastName NVARCHAR(50), AvgGrade TINYINT)
AS
BEGIN
	INSERT INTO @output
	SELECT s.[FirstName] AS StudentFirstName, s.[LastName] AS StudentLastName, AVG(g.[Grade]) AS AvgGrade
	FROM [dbo].[Grade] g
	INNER JOIN [dbo].[Student] s ON g.[StudentID] = s.[ID]
	WHERE [TeacherID] = @TeacherId AND CourseID = @CourseId
	GROUP BY s.[FirstName], s.[LastName]
	RETURN
END
GO

DECLARE @TeacherId INT = 1
DECLARE @CourseId INT = 1

SELECT * 
FROM dbo.fn_StudentAverageGrades (@TeacherId, @CourseId)
GO

--- Modify previous function, by adding new parameter named RewardTreshold. This will be used inside the function logic 
--- to determine if student will received award from teacher or not. Accordingly Add new Output column named ForRewardand
---fill that with ‘yes’ if Student average grade is above RewardTresholdor ‘No’ if Student average grade is below RewardTreshold. 
DROP FUNCTION IF EXISTS dbo.fn_StudentGradesRewards
GO

CREATE FUNCTION dbo.fn_StudentGradesRewards (@TeacherId SMALLINT, @CourseId SMALLINT, @RewardTreshold SMALLINT)
RETURNS @output TABLE (StudentFirstName NVARCHAR(50), StudentLastName NVARCHAR(50), AvgGrade TINYINT, ForReward NVARCHAR(10))
AS
BEGIN
	INSERT INTO @output
	SELECT s.[FirstName] as StudentFirstName, s.[LastName] as StudentLastName, AVG(g.[Grade]) AS AvgGrade,
	CASE
		WHEN AVG(g.[Grade]) > @RewardTreshold THEN 'Yes'
		ELSE 'No'
	END AS ForReward
	FROM [dbo].[Grade] as g
	INNER JOIN [dbo].[Student] as s ON g.[StudentID] = s.ID
	WHERE [TeacherID] = @TeacherID and [CourseID] = @CourseId
	GROUP BY s.[FirstName], s.[LastName]
	RETURN 
END
GO

DECLARE @TeacherId INT = 1
DECLARE @CourseId INT = 1

SELECT *
FROM dbo.fn_StudentGradesRewards (@TeacherId, @CourseId, 8)
GO