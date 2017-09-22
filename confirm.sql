DECLARE @sResult NVARCHAR(max)=''
----------------获取数据后做出响应 id为调用saveAndGetData时获取的traceId值，获取成功msg为ok,获取失败为error---------------------------------
SELECT @sResult=dbo.fnpbHttpInvoke('http://122.237.100.158:8080/huansi/HSAPI/confirm','utf-8','post','json:[{"id":"1506051978815","msg":"ok"}]')
SELECT @sResult
