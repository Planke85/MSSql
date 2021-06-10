CREATE DATABASE aleksandar_planic
GO

USE [aleksandar_planic]
GO

DROP TABLE IF EXISTS [dbo].Student;
DROP TABLE IF EXISTS [dbo].Teacher;
DROP TABLE IF EXISTS [dbo].Course;
DROP TABLE IF EXISTS [dbo].Grade;
DROP TABLE IF EXISTS [dbo].AchievementType;
DROP TABLE IF EXISTS [dbo].GradeDetails;
GO

CREATE TABLE [dbo].[Student](
	[Id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[EnrolledDate] [datetime] NOT NULL DEFAULT CURRENT_TIMESTAMP,
	[Gender] [nvarchar](10) NOT NULL,
	[NationalIdNumber] [int] NOT NULL,
	[StudentCardNumber] [int] NOT NULL
)
GO

CREATE TABLE [dbo].[Teacher](
	[Id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[AcademicRank] [nvarchar](50) NULL,
	[HireDate] [date] NOT NULL
)
GO

CREATE TABLE [dbo].[Course](
	[Id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Name] [nvarchar](50) NOT NULL,
	[Credit] [tinyint] NOT NULL,
	[AcademicYear] [date] NOT NULL,
	[Semester] [nvarchar](20) NOT NULL
)
GO

CREATE TABLE [dbo].[Grade](
	[Id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[StudentId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[TeacherId] [int] NOT NULL,
	[Grade] [decimal](2,1) NULL,
	[Comment] [nvarchar](255) NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT FK_StudentGrade FOREIGN KEY (StudentId) REFERENCES Student(Id) ON DELETE CASCADE,
	CONSTRAINT FK_CourseGrade FOREIGN KEY (CourseId) REFERENCES Course(Id) ON DELETE CASCADE,
	CONSTRAINT FK_TeacherGrade FOREIGN KEY (TeacherId) REFERENCES Teacher(Id) ON DELETE CASCADE
)
GO

CREATE TABLE [dbo].[AchievementType](
	[Id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[ParticipationRate] [decimal](3,2) NOT NULL
)
GO

CREATE TABLE [dbo].[GradeDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[GradeId] [int] NOT NULL,
	[AchievementTypeId] [int] NOT NULL,
	[AchievementPoints] [int] NULL,
	[AchievementMaxPoints] [int] NULL,
	[AchievementDate] [date] NULL,
	CONSTRAINT FK_DetailsGrade FOREIGN KEY (GradeId) REFERENCES Grade(Id) ON DELETE CASCADE,
	CONSTRAINT FK_DetailsAchievement FOREIGN KEY (AchievementTypeId) REFERENCES AchievementType(Id) ON DELETE CASCADE
)
GO