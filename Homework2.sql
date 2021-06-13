--- Task 01 ---
SELECT * 
FROM [dbo].[Student] 
WHERE [FirstName] = 'Antonio'
GO

--- Task 02 ---
SELECT *
FROM [dbo].[Student] 
WHERE [DateOfBirth] > '1999.01.01'
ORDER BY [DateOfBirth] DESC
GO

--- Task 03 ---
SELECT * 
FROM [dbo].[Student] 
WHERE [Gender] = 'M'
ORDER BY [FirstName]
GO

--- Task 04 --- 
SELECT * 
FROM [dbo].[Student]
WHERE [LastName] LIKE 'T%'
ORDER BY [FirstName]
GO

--- Task 05 ---
SELECT * 
FROM [dbo].[Student]
WHERE [EnrolledDate] >= '1998.01.01' AND [EnrolledDate] < '1998.02.01'
GO

--- Task 06 ---
SELECT * 
FROM [dbo].[Student]
WHERE [EnrolledDate] >='1998.01.01' AND [EnrolledDate] < '1998.02.01'
AND [LastName] LIKE 'J%'
GO

--- Task 07 ---
SELECT * 
FROM [dbo].[Student]
WHERE [FirstName] = 'Antonio'
ORDER BY [LastName]
GO

--- Task 08 ---
SELECT * 
FROM [dbo].[Student]
ORDER BY [FirstName]
GO

--- Task 09 ---
SELECT * 
FROM [dbo].[Student]
WHERE [Gender] = 'M'
ORDER BY [EnrolledDate] DESC
GO

--- Task 10 ---
SELECT [FirstName]
FROM [dbo].[Teacher]
UNION ALL
SELECT [FirstName] 
FROM [dbo].[Student]
GO

--- Task 11 ---
SELECT [LastName]
FROM [dbo].[Teacher]
UNION
SELECT [LastName]
FROM [dbo].[Student]
GO

--- Task 12 ---
SELECT [FirstName]
FROM [dbo].[Teacher]
INTERSECT
SELECT [FirstName]
FROM [dbo].[Student]
GO

--- Task 13 ---
ALTER TABLE [dbo].[GradeDetails]
ADD CONSTRAINT [GradeMaxPoints]
DEFAULT 100 FOR [AchievementMaxPoints]
GO

--- Task 14 ---
ALTER TABLE [dbo].[GradeDetails] WITH CHECK
ADD CONSTRAINT [CheckGradeMaxPoints]
CHECK (AchievementMaxPoints <= 100);
GO

--- Task 15 ---
ALTER TABLE [dbo].[AchievementType] WITH CHECK
ADD CONSTRAINT [UniqueAchievementTypeName] UNIQUE (Name)
GO

--- Task 16 ---
ALTER TABLE [dbo].[Grade] ADD CONSTRAINT [FK_StudentGrade] FOREIGN KEY ([StudentId]) REFERENCES [dbo].[Student]([Id]) ON DELETE CASCADE;
ALTER TABLE [dbo].[Grade] ADD CONSTRAINT [FK_CourseGrade] FOREIGN KEY ([CourseId]) REFERENCES [dbo].[Course]([Id]) ON DELETE CASCADE;
ALTER TABLE [dbo].[Grade] ADD CONSTRAINT [FK_TeacherGrade] FOREIGN KEY ([TeacherId]) REFERENCES [dbo].[Teacher]([Id]) ON DELETE CASCADE;
ALTER TABLE [dbo].[GradeDetails] ADD CONSTRAINT [FK_DetailsGrade] FOREIGN KEY ([GradeId]) REFERENCES [dbo].[Grade]([Id]) ON DELETE CASCADE;
ALTER TABLE [dbo].[GradeDetails] ADD CONSTRAINT [FK_DetailsAchievement] FOREIGN KEY ([AchievementTypeId]) REFERENCES [dbo].[AchievementType]([Id]) ON DELETE CASCADE;

--- Task 17 ---
SELECT [dbo].[Course].[Name] AS [CourseName], [dbo].[AchievementType].[Name] AS [AchievementType]
FROM [dbo].[Course] 
CROSS JOIN [dbo].[AchievementType]
ORDER BY [CourseName]
GO

--- Task 18 ---
SELECT [dbo].[Teacher].[FirstName] + ' ' + [dbo].[Teacher].[LastName] AS [Teacher] , [dbo].[Grade].[Grade]
FROM [dbo].[Teacher]
INNER JOIN [dbo].[Grade]
ON [dbo].[Teacher].[ID] = [dbo].[Grade].[ID]
ORDER BY [Grade] DESC
GO

--- Task 19 ---
SELECT [dbo].[Teacher].[FirstName] + ' ' + [dbo].[Teacher].[LastName] AS [Teacher] , [dbo].[Grade].[Grade]
FROM [dbo].[Teacher]
LEFT JOIN [dbo].[Grade]
ON [dbo].[Teacher].[ID] = [dbo].[Grade].[ID]
WHERE [dbo].[Grade].[TeacherID] IS NULL
GO

--- Task 20 ---
SELECT [dbo].[Student].[FirstName] + ' ' + [dbo].[Student].[LastName] AS [Student] , [dbo].[Grade].[Grade]
FROM [dbo].[Student]
RIGHT JOIN [dbo].[Grade]
ON [dbo].[Student].[ID] = [dbo].[Grade].[ID]
WHERE [dbo].[Grade].[StudentID] IS NULL
GO
