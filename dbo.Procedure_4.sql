CREATE PROCEDURE spSalesRemoveNotConfirm
	@salesid varchar(10)

	AS

	DELETE FROM Sales

	WHERE SalesId = @salesid AND Confirmed = 0;
