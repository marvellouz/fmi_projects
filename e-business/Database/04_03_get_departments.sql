USE Gallery

GO

CREATE PROCEDURE GetDepartments AS
SELECT DepartmentID, Name, Description
FROM Department
