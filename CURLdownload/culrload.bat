call c:\curl\bin\curl.exe --anyauth --user admin:admin -H "Content-Type: application/xml" -X PUT "http://localhost:8007/v1/documents?uri=Rottweiler.xml" -d "<pet><name>Rottweiler</name><species>dog</species><birth>20-01-2017</birth></pet>"
echo "Data Load Complete"
pause