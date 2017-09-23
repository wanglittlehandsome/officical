 DECLARE @sResult NVARCHAR(max)=''
 DECLARE @sXML NVARCHAR(MAX)
SELECT @sXML = (
----------替换sql   begin-----------
  SELECT TOP 2 A.sMaterialNo as materialNo,A.sMaterialName as materialName,A.sMaterialTypeName as materialType,A.sUnit as unit,
 A.sComponent as component,A.sConstruction as productConstruction,A.sWidth as width,A.sGMWT as gmwt,B.sColorNo as colorNo,B.sColorName as color,A.nStdPrice as stdPrice,A.nPrice as lastPrice,B.sBarcode as barCode,
 B.sQualityInfo as qualityDescription,A.sProduceArtInfo as productArtInfo,dbo.fnpbBinaryToBase64String(C.gPic) AS gPic, CONVERT(NVARCHAR(50),B.uGUID)+'.jpg' AS picName
 FROM dbo.vwmmMaterialFabricSample A
 JOIN dbo.mmMaterialColor B ON b.ummMaterialGUID=A.uGUID
 JOIN dbo.mmMaterialColorPicture C ON C.ummMaterialColorGUID = B.uGUID 
 WHERE a.bUsable=1
 AND B.ummMaterialGUID IN (
 SELECT ummMaterialGUID FROM dbo.mmMaterialColor GROUP BY ummMaterialGUID HAVING COUNT(*)<10)
 ------------end--------------------
FOR XML RAW,Root('mmMaterial')
)
 set @sXML=REPLACE(@sXML,',','，')
 -----------action为insert/delete, companyId和billType根据实际情况取值-----------------
 --http://122.237.100.158:8080/huansi/
 SELECT @sResult=dbo.fnpbHttpInvoke('http://122.237.100.158:8080/huansi/HSAPI/checkAndSendData','utf-8','post','code:123456|||param:{"companyId":"B77231F73FDD49A5A491EEFCB5CE956E","billType":"materialColor","action":"insert"}|||strings:'+@sXML)

 select @sResult




 
