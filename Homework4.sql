--- Declare scalar variable for storing FirstName values 
--- Assign value ‘Antonio’ to the FirstName variable 
--- Find all Students  having FirstName  same as the variable 
DECLARE @FirstName NVARCHAR(50)

SET @FirstName = 'Antonio'

SELECT * 
FROM [dbo].[Student]
WHERE [FirstName] = @FirstName


--- Declare table variable that will contain StudentId, StudentNameand DateOfBirth
--- Fill the  table variable with all Female  students
DECLARE @student TABLE
(
	StudentId INT,
	FirstName NVARCHAR(50),
	DateOfBirth DATE
)

INSERT INTO @student
SELECT [ID], [FirstName], [DateOfBirth]
FROM [dbo].[Student]
WHERE [Gender] = 'F'

SELECT *
FROM @student


--- Declare temp table that will contain LastNameand EnrolledDatecolumns
--- Fill the temp table with all Male students having First Name starting with ‘A’
--- Retrieve  the students  from the  table which last name  is with 7 characters
CREATE TABLE #student
(
	LastName NVARCHAR(100),
	EnrolledDate DATE
)

INSERT INTO #student
SELECT [LastName], [EnrolledDate]
FROM [dbo].[Student]
WHERE [Gender] = 'M' AND [FirstName] LIKE 'A%'

SELECT *
FROM #student
WHERE LEN([LastName]) = 7


--- Find all teachers whose FirstName length is less than 5 and
--- the first 3 characters of their FirstName  and LastNameare the same
SELECT *
FROM [dbo].[Teacher]
WHERE LEN([FirstName]) < 5 AND LEFT([FirstName], 3) = LEFT([LastName], 3)


--- Declare scalar function (fn_FormatStudentName) for retrieving the Student description for specific StudentIdin the following format:
--- StudentCardNumberwithout “sc-”
--- “ –“
--- First character  of student  FirstName
--- “.”
--- Student LastName ---

CREATE FUNCTION dbo.fn_FormatStudentName (@StudentId INT)
RETURNS NVARCHAR(100)
AS
BEGIN

	DECLARE @result NVARCHAR(100)

	SELECT @result = REPLACE([StudentCardNumber], 'sc-','') + LEFT([FirstName], 1) + '.' + [LastName]
	FROM [dbo].[Student]

	RETURN @result

END

SELECT * , dbo.fn_FormatStudentName([Id]) AS FunctionOutput
FROM dbo.Student
