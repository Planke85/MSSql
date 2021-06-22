--- Calculate the count of all grades in the system ---
SELECT COUNT(*) AS TotalGrade
FROM [dbo].[Grade]
GO

--- Calculate the count of all grades per Teacher in the system ---
SELECT CONCAT(t.[LastName],' ', t.[FirstName]) AS Teacher, COUNT(*) AS TotalGrade
FROM [dbo].[Grade] AS g
INNER JOIN [dbo].[Teacher] t ON t.[ID] = g.[TeacherID]
GROUP BY CONCAT(t.[LastName],' ', t.[FirstName])
ORDER BY COUNT(*) DESC
GO

--- Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) ---
SELECT [TeacherId], COUNT(*) AS Grade
FROM [dbo].[Grade]
WHERE [StudentID] < 100
GROUP BY [TeacherID]
GO

--- Find the Maximal Grade, and the Average Grade per Student on all grades in the system ---
SELECT CONCAT(s.[LastName],' ',s.[FirstName]) AS Student, MAX([Grade]) AS MaxGrade, AVG([Grade]) AS AvgGrade
FROM [dbo].[Grade] g
INNER JOIN [dbo].[Student] s ON s.[ID] = g.[StudentID]
GROUP BY CONCAT(s.[LastName],' ',s.[FirstName])
GO

--- Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200 ---
SELECT CONCAT(t.[LastName],' ',t.[FirstName]) AS Teacher, COUNT(*) AS TeacherGrade
FROM [dbo].[Grade] g
INNER JOIN [dbo].[Teacher] t ON t.[ID] = g.[TeacherID]
GROUP BY CONCAT(t.[LastName],' ',t.[FirstName])
HAVING COUNT(*) > 200
ORDER BY CONCAT(t.[LastName],' ',t.[FirstName])
GO


--- Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) and filter teachers with more than 50 Grade count ---
SELECT CONCAT(t.[LastName],' ',t.[FirstName]) AS Teacher, COUNT(*) AS Grade
FROM [dbo].[Grade] g
INNER JOIN [dbo].[Teacher] t ON t.[ID] = g.[TeacherID]
WHERE [StudentID] < 100
GROUP BY CONCAT(t.[LastName],' ',t.[FirstName])
HAVING COUNT(*) > 50
ORDER BY COUNT(*) DESC
GO

--- Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. Filter only records where Maximal Grade is equal to Average Grade ---
SELECT CONCAT(s.[LastName],' ',s.[FirstName]) AS Student, COUNT([Grade]) AS TotalGrade, MAX([Grade]) AS MaxGrade, AVG([Grade]) AS AvgGrade
FROM [dbo].[Grade] g
INNER JOIN [dbo].[Student] s ON s.[ID] = g.[StudentID]
WHERE [StudentID] < 100
GROUP BY CONCAT(s.[LastName],' ',s.[FirstName])
HAVING MAX([Grade]) = AVG([Grade])
GO

--- List Student First Name and Last Name next to the other details from previous query ---
SELECT CONCAT(s.[LastName],' ',s.[FirstName]) AS Student, COUNT([Grade]) AS TotalGrade, MAX([Grade]) AS MaxGrade, AVG([Grade]) AS AvgGrade
FROM [dbo].[Grade] g
INNER JOIN [dbo].[Student] s ON s.[ID] = g.[StudentID]
WHERE [StudentID] < 100
GROUP BY CONCAT(s.[LastName],' ',s.[FirstName])
HAVING MAX([Grade]) = AVG([Grade])
GO

--- Create new view (vv_StudentGrades) that will List all StudentIdsand count of Grades per student ---
CREATE VIEW vv_StudentGrades
AS
SELECT CONCAT(s.[LastName],' ',s.[FirstName]) AS Student, COUNT([Grade]) AS TotalGrade
FROM [dbo].[Grade] g
INNER JOIN [dbo].[Student] s ON s.[ID] = g.[StudentID]
GROUP BY CONCAT(s.[LastName],' ',s.[FirstName])
GO

SELECT *
FROM vv_StudentGrades
GO


--- Change the view to show Student First and Last Names instead of StudentID ---
ALTER VIEW vv_StudentGrades
AS
SELECT CONCAT(s.[LastName],' ',s.[FirstName]) AS Student, COUNT([Grade]) AS TotalGrade
FROM [dbo].[Grade] g
INNER JOIN [dbo].[Student] s ON s.[ID] = g.[StudentID]
GROUP BY CONCAT(s.[LastName],' ',s.[FirstName])
GO

--- List all rows from view ordered by biggest Grade Count ---
SELECT *
FROM vv_StudentGrades
ORDER BY TotalGrade DESC
GO

--- Create new view (vv_StudentGradeDetails) that will List all Students (FirstName and LastName) and Count the courses he passed through the exam(Ispit) ---
CREATE VIEW vv_StudentGradeDetails
AS
SELECT CONCAT(s.[LastName],' ',s.[FirstName]) AS Student, COUNT([Grade]) AS TotalGrade
FROM [dbo].[Grade] g
INNER JOIN [dbo].[Student] s ON s.[ID] = g.[StudentID]
INNER JOIN [dbo].[GradeDetails] gd ON gd.[GradeID] = g.[ID]
INNER JOIN [dbo].[AchievementType] a ON a.[ID] = gd.[AchievementTypeID]
WHERE a.[Name] = 'Ispit'
GROUP BY CONCAT(s.[LastName],' ',s.[FirstName])
GO

SELECT * 
FROM vv_StudentGradeDetails
GO