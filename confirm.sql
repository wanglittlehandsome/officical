DECLARE @sResult NVARCHAR(max)=''
----------------��ȡ���ݺ�������Ӧ idΪ����saveAndGetDataʱ��ȡ��traceIdֵ����ȡ�ɹ�msgΪok,��ȡʧ��Ϊerror---------------------------------
SELECT @sResult=dbo.fnpbHttpInvoke('http://122.237.100.158:8080/huansi/HSAPI/confirm','utf-8','post','json:[{"id":"1506051978815","msg":"ok"}]')
SELECT @sResult
