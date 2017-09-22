
DECLARE @sResult NVARCHAR(max)=''
declare @XML XML
-----------------获取数据--两个根节点，source,data--------------------
SELECT @sResult=dbo.fnpbHttpInvoke('http://122.237.100.158:8080/huansi/HSAPI/saveAndGetData','utf-8','post','')
print @sResult
select @Xml=convert(xml,REPLACE(@sResult,'<?xml version="1.0" encoding="UTF-8"?>',''))
select @Xml
	DECLARE @idoc1 int
	EXEC sp_xml_preparedocument @idoc1 OUTPUT, @Xml
	SELECT * 
	INTO #2
	FROM OPENXML(@idoc1,'/mmMaterial/total/row/source/row/data/row', 2)
	WITH
	(
		[action] nvarchar(max) '../../action'
		,billType nvarchar(max) '../../billType'
		,companyId nvarchar(max) '../../companyId'
		,barCode nvarchar(max) 
		,color nvarchar(max) 
		,colorNo nvarchar(max) 
		,component nvarchar(max) 
		,[description] nvarchar(max) 
		,gmwt nvarchar(max) 
		,lastPrice nvarchar(max) 
		,materialName nvarchar(max) 
		,materialNo nvarchar(max) 
		,materialType nvarchar(max) 
        ,picName nvarchar(max) 
        ,productArtInfo nvarchar(max) 
		,productConstruction nvarchar(max) 
		,qualityDescription nvarchar(max) 
		,stdPrice nvarchar(max) 
		,unit nvarchar(max) 
		,width nvarchar(max) 
	)
	EXEC sp_xml_removedocument @idoc1
	select * from #2
	drop table #2